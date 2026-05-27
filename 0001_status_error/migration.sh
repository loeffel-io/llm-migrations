#!/bin/bash

ast-grep --lang go \
    -p 'service.statusError.NotFoundError($$$ARGS)' \
    -r 'service.statusError.NotFoundError(
	ctx,
	$$$ARGS,
    )' -U

ast-grep --lang go \
    -p 'service.statusError.PageTokenMismatchError($$$ARGS)' \
    -r 'service.statusError.PageTokenMismatchError(
	ctx,
	$$$ARGS,
    )' -U

ast-grep --lang go \
    -p 'service.statusError.PageTokenExpiryError($$$ARGS)' \
    -r 'service.statusError.PageTokenExpiryError(
	ctx,
	$$$ARGS,
    )' -U

ast-grep --lang go \
    -p 'service.statusError.EtagMismatchError($$$ARGS)' \
    -r 'service.statusError.EtagMismatchError(
	ctx,
	$$$ARGS,
    )' -U

ast-grep --lang go \
    -p 'service.statusError.ParentMismatchError($$$ARGS)' \
    -r 'service.statusError.ParentMismatchError(
	ctx,
	$$$ARGS,
    )' -U

ast-grep --lang go \
    -p 'service.statusError.AlreadyExistsError($$$ARGS)' \
    -r 'service.statusError.AlreadyExistsError(
	ctx,
	$$$ARGS
    )' -U

ast-grep --lang go \
    -p 'service.statusError.ParentNotFoundError($$$ARGS)' \
    -r 'service.statusError.ParentNotFoundError(
	ctx,
	$$$ARGS,
    )' -U

ast-grep run -p 'service.statusError.InternalError()' -r 'service.statusError.InternalError(ctx)' --lang go -U

ast-grep --lang go \
    -p 'service.statusError.Error($$$ARGS)' \
    -r 'service.statusError.Error(
	ctx,
	$$$ARGS
    )' -U

ast-grep --lang go \
    -p 'service.statusError.InvalidArgumentError($$$ARGS)' \
    -r 'service.statusError.InvalidArgumentError(
	ctx, 
    $$$ARGS,
    )' -U

ast-grep run -p 'service.denied()' -r 'service.denied(ctx)' --lang go -U

ast-grep run -p 'service.allowed()' -r 'service.allowed(ctx)' --lang go -U

ast-grep -p 'return service.response($$$ARGS)' -r 'return service.response(ctx, $$$ARGS)' -U

bazel run //:format
bazel build //...
bazel test //...
