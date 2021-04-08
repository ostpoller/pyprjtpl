#!/bin/bash

DUMMY_PACKAGE_NAME='package_name'

BLUE='\033[0;34m'
NC='\033[0m' # No Color

# usage message
IFS='' read -r -d '' USAGE <<EOF

Usage: $0 package_name

    Substitute the placeholders with the chosen package name.

EOF

# exit if no argument given
if [[ $# -eq 0 ]]; then
    echo "$USAGE"
    exit 0
fi

# parse arguments
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -h|--help)
    echo "$USAGE"
    exit 0
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# use first postional argument for the new package name
NEW_PACKAGE_NAME=${POSITIONAL[0]}


echo -e "\n${BLUE}Renaming variables and files...${NC}\n"

mv ${DUMMY_PACKAGE_NAME} ${NEW_PACKAGE_NAME}
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g ${NEW_PACKAGE_NAME}/__init__.py
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g ${NEW_PACKAGE_NAME}/__main__.py
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g ${NEW_PACKAGE_NAME}/__version__.py
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g ${NEW_PACKAGE_NAME}/api.py
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g ${NEW_PACKAGE_NAME}/app.py

sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g scripts/context.py
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g scripts/script.py

sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g tests/context.py
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g tests/test_app.py

sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g docs/conf.py
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g docs/Makefile
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g docs/publish_gh-pages.sh
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g docs/README.md

sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g .bandit
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g pytest.ini
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g Makefile
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g dev.Dockerfile
sed -i s/${DUMMY_PACKAGE_NAME}/${NEW_PACKAGE_NAME}/g setup.py

sed -i s/\#classified/classified/g .gitignore

echo "# ${NEW_PACKAGE_NAME}" > README.md

echo -e "\n${BLUE}Testing if everything works...${NC}\n"

echo -e "\n${BLUE}Test: make run${NC}\n"
make run
echo -e "\n${BLUE}Test: make test${NC}\n"
make test
echo -e "\n${BLUE}Test: make build-dev${NC}\n"
make build-dev

