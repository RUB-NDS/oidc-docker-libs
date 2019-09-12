#! /bin/bash
set -e

SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"

if [ ! -d "${SCRIPT_PATH}/eLearningSSO" ]; then
	echo "Please clone the eLearningSSO project into $SCRIPT_PATH/eLearningSSO"
	exit 1
fi

cp -vrf "${SCRIPT_PATH}/conf/oidc" "${SCRIPT_PATH}/eLearningSSO/"

# apply patches to improve professos compatibility 
cp "${SCRIPT_PATH}/conf/git-patches/*.patch" "$SCRIPT_PATH/eLearningSSO"
pushd "${SCRIPT_PATH}/eLearningSSO/"
git checkout 28c9438b20fc41366891648cd3f3534da31ae967
git am *.patch
  
# compile necessary modules
mvn -f "${SCRIPT_PATH}/eLearningSSO/pom.xml" clean package --projects oidc/idp_lib,oidc/sp_lib,oidc/idp_webapp,oidc/sp_webapp,api/utils,api/sso_api,api/eLearning_api

# now, the oidc sp and idp can be used, e.g., by running the provided docker-compose file
