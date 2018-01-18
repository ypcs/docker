NAMESPACE = ypcs

IMAGES = $(patsubst %/,%,$(dir $(wildcard */Dockerfile)))

all: $(IMAGES)

$(IMAGES): %: %/Dockerfile
	cd "$@" && \
		docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		-t "$(NAMESPACE)/$@" .

.PHONY: $(IMAGES)
