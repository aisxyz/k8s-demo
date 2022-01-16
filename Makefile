imageName := aisxyz/k8s-demo

.PHONY: image_build help

# Define common command sequences.
define enable-quit-mode
	set -e
	@# The prefix '@' means disable echo current command line.
	@echo "Enabled quit mode, which means the program will be terminated when something went wrong."
endef


help:                  # Show help information
	@echo "Usage: make [TARGET]\n"
	@echo "Target                 Description"
	@echo "-------------------------------------"
	@grep -E '^\w+:\s+#.+' Makefile | sed -n -e 's/[:#]//gp'


image_build: oldId:=$(shell docker image ls -q ${imageName})
image_build:           # Build target image
	$(enable-quit-mode)
	@echo "build image $(imageName)..."
	docker build -t $(imageName) .
	@# The prefix '-' means ignore any possible errors and go on.
	-docker image rm ${oldId}

image_push:           # Push target image to remote repository
	$(enable-quit-mode)
	docker push $(imageName)
	@echo "push image ${imageName} succeed!"


# Load other Makefiles here, and ignore any possible errors.
#-include *.make
