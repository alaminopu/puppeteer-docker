# detect platform architecture
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
  UNAME_M := $(shell uname -m)
  ifeq ($(UNAME_M),x86_64)
    arch := amd64
  else ifeq ($(UNAME_M),aarch64)
    arch := arm64
  endif
else ifeq ($(UNAME_S),Darwin)
  UNAME_P := $(shell uname -p)
  ifeq ($(UNAME_P),arm)
    arch := arm64
  else
    arch := amd64
  endif
endif


TAG = $(shell git rev-parse --short HEAD)
DOCKER_IMAGE = "docker.io/alaminopu/puppeteer-docker:$(TAG)"
BUILD_ARGS = --build-arg ARCH=$(arch)

docker-builder:
    # skip if already exists
	docker buildx create --name multiarch || true
	# use it
	docker buildx use multiarch

docker-build: docker-builder
	docker buildx build --push --platform linux/amd64,linux/arm64 -t $(DOCKER_IMAGE) $(BUILD_ARGS) .

docker-run: docker-build
	docker run -it --rm $(DOCKER_IMAGE)

docker-push: docker-build
	docker push $(DOCKER_IMAGE)

