```bash
fd -t d -d 1 -u -g '**service**' --exclude '**proto' --exclude 'earth-hub-service' --exclude 'earth-app-service' --exclude 'earth-auth-service' --exclude 'earth-website-service' -j 1 -x bash -c 'cat <<\EOF >> "$1/cmd/${1//-/_}/ingressgateway.yaml"
---
apiVersion: networking.gke.io/v1
kind: GCPBackendPolicy
metadata:
  name: "%{service}-ingressgateway-waf-policy"
spec:
  default:
    securityPolicy: "earth-base-waf-policy-backend"
  targetRef:
    group: ""
    kind: Service
    name: "%{service}-ingressgateway"
EOF' _ {/}
```

```bash
fd -t d -d 1 -u -g '**service**' --exclude '**proto' --exclude 'earth-hub-service' --exclude 'earth-app-service' --exclude 'earth-auth-service' --exclude 'earth-website-service' -j 1 -x bash -c '(cd {} && git add . && git commit --all -m "feat: waf policy" && git push)'
```
