#!/bin/bash

source ~/.variables
source ~/.functions

# Exit immediately if a command exits with a non-zero status
set -e

# ==========================================
# CONFIGURATION
# ==========================================
SERVICES=("email") # "user" "iam" "resourcemanager" "storage" "content")
DB_NAME="loeffel-io"
DB_HOST="127.0.0.1"
DB_PORT="3306"
PF_PID=""

# ==========================================
# HELPER FUNCTIONS
# ==========================================
start_pf() {
    echo "=> Starting port forwarding (mpf loeffel-io $SERVICE_NAME 3306 3306)..."
    mpf loeffel-io "$SERVICE_NAME" 3306 3306 >/dev/null 2>&1 &
    PF_PID=$!

    wait_for_db
}

stop_pf() {
    if [ -n "$PF_PID" ]; then
        echo "=> Stopping port forwarding (PID: $PF_PID)..."
        kill $PF_PID 2>/dev/null || true
        wait $PF_PID 2>/dev/null || true # Wait for the process to actually die
        sleep 2                          # Give the OS a moment to free the TCP port
        PF_PID=""
    fi
}

wait_for_db() {
    local max_retries=60
    local count=0

    echo -n "=> Waiting for MySQL to become available"

    # Notice $DB_NAME is now included in the check
    while ! mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" "$DB_NAME" -Nse "SELECT 1;" >/dev/null 2>&1; do

        # Self-healing: If the mpf process died, restart it using the correct service name
        if ! kill -0 $PF_PID 2>/dev/null; then
            mpf loeffel-io "$SERVICE_NAME" 3306 3306 >/dev/null 2>&1 &
            PF_PID=$!
        fi

        count=$((count + 1))
        if [ $count -ge $max_retries ]; then
            echo -e "\nERROR: Timed out waiting for MySQL."
            exit 1
        fi

        sleep 2
        echo -n "."
    done
    echo -e "\n   MySQL is connected and ready!"
}

trap 'stop_pf' EXIT

# ==========================================
# MAIN LOOP
# ==========================================
for SERVICE_NAME in "${SERVICES[@]}"; do
    echo "----------------------------------------------------"
    echo "Processing Service: $SERVICE_NAME"
    echo "----------------------------------------------------"

    if [ "$SERVICE_NAME" == "user" ]; then
        DB_USER="earth-user-service-dev-i"
    else
        DB_USER="earth-${SERVICE_NAME}-s-d-i"
    fi

    DUMP_FILE="${SERVICE_NAME}.sql"

    echo "   Using DB User: $DB_USER"
    echo "   Target DB: $DB_NAME"

    # Base commands
    MYSQL_CMD="mysql -h $DB_HOST -P $DB_PORT -u $DB_USER"
    MYSQLDUMP_CMD="mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USER --no-create-info --complete-insert --single-transaction"

    # 1. Start PF & Wait
    start_pf

    # --- A. DUMP FULL DATABASE (DATA ONLY) ---
    echo "=> [1/4] Dumping data to $DUMP_FILE..."
    $MYSQLDUMP_CMD "$DB_NAME" >"$DUMP_FILE"
    echo "   Dump successful."

    # --- B. DROP ALL TABLES ---
    echo "=> [2/4] Dropping all tables in '$DB_NAME'..."
    TABLES=$($MYSQL_CMD -Nse 'SHOW TABLES;' "$DB_NAME")

    if [ -n "$TABLES" ]; then
        DROP_STMT="SET FOREIGN_KEY_CHECKS=0; "
        for t in $TABLES; do
            DROP_STMT="${DROP_STMT}DROP TABLE \`$t\`; "
        done
        DROP_STMT="${DROP_STMT}SET FOREIGN_KEY_CHECKS=1;"

        $MYSQL_CMD -e "$DROP_STMT" "$DB_NAME"
        echo "   All tables dropped."
    else
        echo "   Database is already empty. No tables to drop."
    fi

    # 2. Stop PF cleanly
    stop_pf

    # --- C. DEPLOY MIGRATION ---
    echo "=> [3/4] Deploying migration for $SERVICE_NAME..."
    mmd loeffel-io "$SERVICE_NAME"
    echo "   Migration deployed."

    # 3. Restart PF & Wait
    start_pf

    # --- D. IMPORT DUMP (DATA ONLY) ---
    echo "=> [4/4] Importing data back from $DUMP_FILE..."
    $MYSQL_CMD "$DB_NAME" <"$DUMP_FILE"
    echo "   Import successful."

    # 4. Clean up PF for this loop iteration
    stop_pf

    echo "=> Finished processing $SERVICE_NAME."
    echo ""

done

echo "=========================================="
echo " All services processed successfully! "
echo "=========================================="
