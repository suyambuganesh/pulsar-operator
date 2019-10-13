# Build binary and image.
#
# Example:
#   make
#   make all
all: build
.PHONY: all

# Build the binaries
#
# Example:
#   make build
build:
	cd hack/build && sh build.sh
.PHONY: build

# Build the docker image
#
# Example:
#   make image
image:
	pushd docker && sh ./build-image.sh && popd
.PHONY: image

# Push the docker image
#
# Example:
#   make push
push:
	pushd docker && sh ./push-image.sh && popd
.PHONY: push

# clean all binaries
#
# Example:
#   make clean
clean:
	rm -rf ./bin
.PHONY: clean

# generate code(zz_generated*)
# generate go mod list to vendor
# Example:
#   make generate
generate:
	operator-sdk generate k8s
	operator-sdk generate openapi
	go mod vendor
.PHONY: generate
	
# local test
# Example:
#   make local
local:
	deploy/install_local.sh
.PHONY: local

# install to kubernetes
# Example:
#   make install
install:
	deploy/install.sh

# uninstall from kubernetes
# Example:
#   make uninstall
uninstall:
	deploy/uninstall.sh
