PROJECT_NAME = $(shell basename $$(pwd))
PACKAGE_NAME = package_name

# Docker image name:tag
IMAGE_NAME = $(PACKAGE_NAME)
IMAGE_TAG = $(shell git describe --tags --always --dirty 2> /dev/null || echo "latest")

# some colour for the echoes to the console
BLUE='\033[0;34m'
BRED='\033[1;31m'
BBlue='\033[1;34m'
BWhite='\033[1;37m'
NC='\033[0m' # No Color


.PHONY: clean doc help lint push run shell test version

run: run-main run-script

lint: black flake8 isort bandit mypy 

test: test-all

doc:
	@cd docs && make html && cd ..

run-main:
	@python -m ${PACKAGE_NAME}

run-script:
	@python ./scripts/script.py

bandit:
	@echo "\n${BBlue}Running Bandit against source files...${NC}\n"
	@bandit -r --ini ./.bandit

isort:
	@echo "\n${BBlue}Running Isort against source and test files...${NC}\n"
	@git ls-files -z -- '*.py' | xargs --no-run-if-empty --null isort

black:
	@echo "\n${BBlue}Running Black against source and test files...${NC}\n"
	@git ls-files -z -- '*.py' | xargs --no-run-if-empty --null black

flake8:
	@echo "\n${BBlue}Running Flake8 against source and test files...${NC}\n"
	@git ls-files -z -- '*.py' | xargs --no-run-if-empty --null flake8

mypy:
	@echo "\n${BBlue}Running Mypy against source and test files...${NC}\n"
	@mypy package_name tests

test-all:
	@pytest

# Example: make build-prod VERSION=1.0.0
build-prod:
	@echo "\n${BBlue}Building Production image with labels:\n"
	@echo "    name: ${IMAGE_NAME}"
	@echo "    version: ${VERSION}${NC}\n"
	@sed                                 \
	    -e 's|{NAME}|${IMAGE_NAME}|g'  \
	    -e 's|{VERSION}|${VERSION}|g'    \
	    prod.Dockerfile | docker build -t ${IMAGE_NAME}:${VERSION} -f- .

build-dev:
	@echo "\n${BBlue}Building Development image with labels:\n"
	@echo "    name: ${IMAGE_NAME}"
	@echo "    version: ${IMAGE_TAG}${NC}\n"
	@sed                                 \
	    -e 's|{NAME}|${IMAGE_NAME}|g'  \
	    -e 's|{VERSION}|${IMAGE_TAG}|g'        \
	    dev.Dockerfile | docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f- .

# Example: make shell CMD="-c 'date > datefile'"
#   Use
#           -u $$(id -u):$$(id -g)
#   to enter the container as a std user (i.e. not root)
shell: build-dev
	@echo "\n${BBlue}Launching a shell in the containerized build environment...${NC}\n"
		@docker run                     \
			-it                         \
			--rm                        \
			--entrypoint /bin/bash     \
			${IMAGE_NAME}:${IMAGE_TAG}  \
			${CMD}

version:
	@echo ${IMAGE_TAG}

bump-version:
	@echo "\n${BRED}ERROR: not implemented yet!${NC}\n"

lock-dependencies:
	@echo "\n${BRED}ERROR: not implemented yet!${NC}\n"

clean:
	@rm -rf coverage.xml .coverage .mypy_cache .pytest_cache 
	@py3clean -v .

docker-clean:
#	@docker system prune -f --filter "label=name=${IMAGE_NAME}"
	@docker image rm -f $$(docker image ls --filter "label=name=${IMAGE_NAME}" --format "{{.ID}}")	
