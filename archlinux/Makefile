BASE_OS    := archlinux
BASE_IMAGE_TAGS := base-devel

AUTHOR := bensuperpc

IMAGE_NAME := distcc

IMAGE := $(AUTHOR)/$(IMAGE_NAME)

DOCKERFILE := Dockerfile
DOCKER := docker

TAG := $(shell date '+%Y%m%d')-$(shell git rev-parse --short HEAD)
DATE := $(shell date -u +"%Y-%m-%d")
VERSION := 1.0.0

all: $(BASE_IMAGE_TAGS)

all.test: $(addsuffix .test,$(BASE_IMAGE_TAGS))

test: all.test

all.push: $(addsuffix .push,$(BASE_IMAGE_TAGS))

push: all.push

$(BASE_OS): all

$(BASE_IMAGE_TAGS):
	$(DOCKER) buildx build . --file $(DOCKERFILE) \
		--platform linux/amd64 \
		-t $(IMAGE):$(BASE_OS)-$@-$(TAG) \
		-t $(IMAGE):$(BASE_OS)-$@ \
		-t $(IMAGE):$(BASE_OS) \
		--build-arg BUILD_DATE=$(DATE) --build-arg DOCKER_IMAGE=$(BASE_OS):$@ \
		--build-arg VERSION=$(VERSION)

clean:
	$(DOCKER) images --filter='reference=$(IMAGE)' --format='{{.Repository}}:{{.Tag}}' | xargs -r $(DOCKER) rmi -f

.SECONDEXPANSION:
$(addsuffix .test,$(BASE_IMAGE_TAGS)): $$(basename $$@)
	export DISTCC_HOSTS="hostname:3632/4 localhost/1"
	$(DOCKER) run -d -p 3632:3632 -p 3633:3633 --name testdistcc-$(BASE_OS)-$(basename $@) $(IMAGE):$(BASE_OS)-$(basename $@)-$(TAG) --allow 0.0.0.0/0 --nice 5
# CMake
	cmake -B build-$(BASE_OS)-$(basename $@) -S ../test/cmake -G Ninja \
		-DCMAKE_C_COMPILER_LAUNCHER="ccache;distcc" \
		-DCMAKE_CXX_COMPILER_LAUNCHER="ccache;distcc" \
		&& cmake --build build-$(BASE_OS)-$(basename $@)
# Make
	make -j8 -C ../test/make CC="distcc gcc" CXX="distcc g++" all
# Clean up
	$(DOCKER) stop testdistcc-$(BASE_OS)-$(basename $@)
	$(DOCKER) rm testdistcc-$(BASE_OS)-$(basename $@)

	rm -rf build-$(BASE_OS)-$(basename $@)
	make -C ../test/make clean


.SECONDEXPANSION:
$(addsuffix .push,$(BASE_IMAGE_TAGS)): $$(basename $$@)
	$(DOCKER) push $(IMAGE) --all-tags

.PHONY: all push clean $(BASE_IMAGE_TAGS)
