#!/bin/bash -e

export TEST_CURR_JOB="runshscript"
export TEST_RES_DH="ship_dh"
export TEST_RES_REPO="pipeline_scriptRepo"
export TEST_RES_PARAMS="test_params"
export TEST_RES_IN_IMG="sample_img"
export TEST_RES_IMAGE_OUT="test_out_img"

# since resources here have dashes Shippable replaces them and UPPER cases them
export TEST_RES_REPO_UP=$(echo $TEST_RES_REPO | awk '{print toupper($0)}')
export TEST_RES_REPO_STATE=$(eval echo "$"$TEST_RES_REPO_UP"_STATE")

export TEST_CURR_JOB_UP=$(echo $TEST_CURR_JOB | awk '{print toupper($0)}')
echo TEST_CURR_JOB=$JOB_NAME
echo TEST_CURR_JOB_UP=$TEST_CURR_JOB_UP
echo JobTriggredByName=$JOB_TRIGGERED_BY_NAME
echo JobTriggredById=$JOB_TRIGGERED_BY_ID

#get dockerhub EN string
export TEST_RES_DH_UP=$(echo $TEST_RES_DH | awk '{print toupper($0)}')
export TEST_RES_DH_INT_STR=$TEST_RES_DH_UP"_INTEGRATION"
  
export TEST_RES_IMAGE_OUT_UP=$(echo $TEST_RES_IMAGE_OUT | awk '{print toupper($0)}')
export TEST_RES_IMAGE_OUT_VERSION=$(eval echo "$"$TEST_RES_IMAGE_OUT_UP"_VERSIONNUMBER")

export TEST_RES_IN_IMG_UP=$(echo $TEST_RES_IN_IMG | awk '{print toupper($0)}')

echo "-----> Out image resource"
echo TEST_RES_IMG_OUT_VERSION=$TEST_RES_IMAGE_OUT_VERSION
echo TEST_RES_IMG_OUT_UP=$TEST_RES_IMAGE_OUT_UP

echo "-----> Installed package versions"
echo PACKER_VERSION=$(packer version)
echo TERRAFORM_VERSION=$(terraform --version)

echo "-----> runSh Job variables"
echo SUBSCRIPTION_ID=${#SUBSCRIPTION_ID}
echo CURRENT_JOB_NAME=$JOB_NAME
echo CURRENT_JOB_TYPE=$JOB_TYPE
echo CURRENT_JOB_RESOURCE_ID=$RESOURCE_ID
echo CURRENT_JOB_BUILD_ID=$BUILD_ID
echo CURRENT_JOB_BUILD_NUMBER=$BUILD_NUMBER
echo CURRENT_JOB_BUILD_JOB_ID=$BUILD_JOB_ID
echo CURRENT_JOB_BUILD_JOB_NUMBER=$BUILD_JOB_NUMBER
echo CURRENT_JOB_PATH=$JOB_PATH
echo CURRENT_JOB_STATE=$JOB_STATE
echo CURRENT_JOB_PREVIOUS_STATE=$JOB_PREVIOUS_STATE
echo CURRENT_JOB_MESSAGE_PATH=$JOB_MESSAGE

echo "-----> Resource variables"
echo TEST_RES_IN_IMG_UP=$TEST_RES_IN_IMG_UP
export TEST_RESOURCE_NAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_NAME")
export TEST_RESOURCE_ID=$(eval echo "$"$TEST_RES_IN_IMG_UP"_ID")
export TEST_RESOURCE_TYPE=$(eval echo "$"$TEST_RES_IN_IMG_UP"_TYPE")
export TEST_RESOURCE_PATH=$(eval echo "$"$TEST_RES_IN_IMG_UP"_PATH")
export TEST_RESOURCE_STATE=$(eval echo "$"$TEST_RES_IN_IMG_UP"_STATE")
export TEST_RESOURCE_META=$(eval echo "$"$TEST_RES_IN_IMG_UP"_META")
export TEST_RESOURCE_OPERATION=$(eval echo "$"$TEST_RES_IN_IMG_UP"_OPERATION")
export TEST_RESOURCE_VERSIONNAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_VERSIONNAME")
export TEST_RESOURCE_VERSIONNUMBER=$(eval echo "$"$TEST_RES_IN_IMG_UP"_VERSIONNUMBER")
export TEST_RESOURCE_VERSIONID=$(eval echo "$"$TEST_RES_IN_IMG_UP"_VERSIONID")
export TEST_RESOURCE_SOURCENAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_SOURCENAME")
export TEST_RESOURCE_SEED_VERSIONNAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_SEED_VERSIONNAME")
#export TEST_RESOURCE_PARAMS_FIELDNAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_PARAMS_FIELDNAME") #this is in get_params()
export TEST_RESOURCE_POINTER_SOURCENAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_POINTER_SOURCENAME")
export TEST_RESOURCE_SEED_VERSIONNAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_SEED_VERSIONNAME")
export TEST_RESOURCE_INTEGRATION_USERNAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_INTEGRATION_USERNAME")

echo TEST_RESOURCE_NAME=$TEST_RESOURCE_NAME
echo TEST_RESOURCE_ID=$TEST_RESOURCE_ID
echo TEST_RESOURCE_TYPE=$TEST_RESOURCE_TYPE
echo TEST_RESOURCE_PATH=$TEST_RESOURCE_PATH
echo TEST_RESOURCE_STATE=$TEST_RESOURCE_STATE
echo TEST_RESOURCE_META=$TEST_RESOURCE_META
echo TEST_RESOURCE_OPERATION=$TEST_RESOURCE_OPERATION
echo TEST_RESOURCE_VERSIONNAME=$TEST_RESOURCE_VERSIONNAME
echo TEST_RESOURCE_VERSIONNUMBER=$TEST_RESOURCE_VERSIONNUMBER
echo TEST_RESOURCE_VERSIONID=$TEST_RESOURCE_VERSIONID
echo TEST_RESOURCE_SOURCENAME=$TEST_RESOURCE_SOURCENAME
echo TEST_RESOURCE_SEED_VERSIONNAME=$TEST_RESOURCE_SEED_VERSIONNAME
echo TEST_RESOURCE_PARAMS_FIELDNAME='this is in get_params section'
echo TEST_RESOURCE_POINTER_SOURCENAME=$TEST_RESOURCE_POINTER_SOURCENAME
echo TEST_RESOURCE_SEED_VERSIONNAME=$TEST_RESOURCE_SEED_VERSIONNAME
echo TEST_RESOURCE_INTEGRATION_USERNAME=$TEST_RESOURCE_INTEGRATION_USERNAME

dockerhub_login() {
  echo "-----> Logging in to Dockerhub" 
  
  export TEST_DH_USERNAME=$(eval echo "$"$TEST_RES_DH_INT_STR"_USERNAME")
  export TEST_DH_PASSWORD=$(eval echo "$"$TEST_RES_DH_INT_STR"_PASSWORD")
  export TEST_DH_EMAIL=$(eval echo "$"$TEST_RES_DH_INT_STR"_EMAIL")
  
  echo TEST_DH_USERNAME=$TEST_DH_USERNAME
  echo TEST_DH_PASSWORD_LENGTH=${#TEST_DH_PASSWORD} #show only count
  echo TEST_DH_EMAIL=$TEST_DH_EMAIL
  sudo docker login -u $TEST_DH_USERNAME -p $TEST_DH_PASSWORD -e $TEST_DH_EMAIL
}

set_context() {
  echo "-----> Git resource"
  export TEST_REPO_VERSION=$(eval echo "$"$TEST_RES_REPO_UP"_VERSIONNUMBER") 
  export TEST_REPO_FULL_NAME=$(eval echo "$"$TEST_RES_REPO_UP"_REPO_FULL_NAME")
  export TEST_REPO_BRANCH=$(eval echo "$"$TEST_RES_REPO_UP"_BRANCH")
  export TEST_REPO_COMMIT=$(eval echo "$"$TEST_RES_REPO_UP"_COMMIT")
  export TEST_REPO_COMMIT_MESSAGE=$(eval echo "$"$TEST_RES_REPO_UP"_COMMIT_MESSAGE")
  export TEST_REPO_COMMITTER=$(eval echo "$"$TEST_RES_REPO_UP"_COMMITTER") 
  export TEST_REPO_HTTPS_URL=$(eval echo "$"$TEST_RES_REPO_UP"_HTTPS_URL")
  export TEST_REPO_IS_FORK=$(eval echo "$"$TEST_RES_REPO_UP"_IS_FORK")
  export TEST_REPO_PULL_REQUEST=$(eval echo "$"$TEST_RES_REPO_UP"_PULL_REQUEST")
  export TEST_REPO_IS_PULL_REQUEST=$(eval echo "$"$TEST_RES_REPO_UP"_IS_PULL_REQUEST")
  export TEST_REPO_BASE_BRANCH=$(eval echo "$"$TEST_RES_REPO_UP"_BASE_BRANCH")
  export TEST_REPO_HEAD_BRANCH=$(eval echo "$"$TEST_RES_REPO_UP"_HEAD_BRANCH")   
  export TEST_REPO_PULL_REQUEST_REPO_FULL_NAME=$(eval echo "$"$TEST_RES_REPO_UP"_PULL_REQUEST_REPO_FULL_NAME")    
  export TEST_REPO_IS_GIT_TAG=$(eval echo "$"$TEST_RES_REPO_UP"_IS_GIT_TAG")
  export TEST_REPO_IS_RELEASE=$(eval echo "$"$TEST_RES_REPO_UP"_IS_RELEASE")  
  export TEST_REPO_RELEASE_NAME=$(eval echo "$"$TEST_RES_REPO_UP"_RELEASE_NAME")
  export TEST_REPO_RELEASED_AT=$(eval echo "$"$TEST_RES_REPO_UP"_RELEASED_AT")
  export TEST_REPO_SSH_URL=$(eval echo "$"$TEST_RES_REPO_UP"_SSH_URL")

  echo TEST_RES_REPO=$TEST_RES_REPO
  echo TEST_RES_REPO_UP=$TEST_RES_REPO_UP
  echo TEST_RES_REPO_STATE=$TEST_RES_REPO_STATE
  echo TEST_REPO_RESO_VERSION=$TEST_REPO_VERSION
  echo TEST_REPO_FULL_NAME=$TEST_REPO_FULL_NAME
  echo TEST_BRANCH=$TEST_REPO_BRANCH
  echo TEST_COMMIT=$TEST_REPO_COMMIT
  echo TEST_COMMIT_MESSAGE=$TEST_REPO_COMMIT_MESSAGE
  echo TEST_RESO_COMMITER=$TEST_REPO_COMMITTER
  echo TEST_REPO_HTTPS_URL=$TEST_REPO_HTTPS_URL
  echo TEST_REPO_IS_FORK=$TEST_REPO_IS_FORK
  echo TEST_REPO_PULL_REQUEST=$TEST_REPO_PULL_REQUEST
  echo TEST_REPO_IS_PULL_REQUEST=$TEST_REPO_IS_PULL_REQUEST
  echo TEST_REPO_BASE_BRANCH=$TEST_REPO_BASE_BRANCH
  echo TEST_REPO_HEAD_BRANCH=$TEST_REPO_HEAD_BRANCH
  echo TEST_REPO_PULL_REQUEST_REPO_FULL_NAME=$TEST_REPO_PULL_REQUEST_REPO_FULL_NAME
  echo TEST_REPO_IS_GIT_TAG=$TEST_REPO_IS_GIT_TAG
  echo TEST_REPO_IS_RELEASE=$TEST_REPO_IS_RELEASE
  echo TEST_REPO_RELEASE_NAME=$TEST_REPO_RELEASE_NAME
  echo TEST_REPO_RELEASED_AT=$TEST_REPO_RELEASED_AT
  echo TEST_REPO_SSH_URL=$TEST_REPO_SSH_URL
}

get_params() {
  echo "-----> Env in paramas resource"
  
  export TEST_RES_PARAMS_UP=$(echo $TEST_RES_PARAMS | awk '{print toupper($0)}')
  #export TEST_RESOURCE_PARAMS_FIELDNAME=$(eval echo "$"$TEST_RES_PARAMS_UP"_PARAMS_FIELDNAME")
  export TEST_RESOURCE_PARAMS_TEST=$(eval echo "$"$TEST_RES_PARAMS_UP"_PARAMS_TEST")
  export TEST_RES_PARAMS_STR=$TEST_RES_PARAMS_UP"_PARAMS"
  export TEST_USER_PARAM=$(eval echo "$"$TEST_RES_PARAMS_STR"_TEST")
  #export TEST_USER_PARAM=$(eval echo "$"$TEST_RES_PARAMS_STR"_key1") #keyvaluetest
  export TEST_SEC_PARAM=$(eval echo "$"$TEST_RES_PARAMS_STR"_DEV")
  echo TEST_RES_PARAMS_STR=$TEST_RES_PARAMS_STR
  echo TEST_RESOURCE_PARAMS_TEST=$TEST_RESOURCE_PARAMS_TEST
  echo TEST_USER_PARAM_TEST=$TEST_USER_PARAM
  #echo TEST_USER_PARAM=$TEST_USER_PARAM
  echo TEST_SECURE_PARAM_DEV=$TEST_SEC_PARAM
}

create_out_state() {
 # echo "-----> Creating a state file for $TEST_RES_IMAGE_OUT"
 # echo versionName=$TEST_REPO_VERSION > "$JOB_STATE/$TEST_RES_IMAGE_OUT.env"
 # echo commitSHA=$TEST_REPO_COMMIT >> "$JOB_STATE/$TEST_RES_IMAGE_OUT.env" 
 # cat "$JOB_STATE/$TEST_RES_IMAGE_OUT.env"
  
  echo "-----> Creating a state file for $TEST_CURR_JOB"
  echo versionName=$TEST_REPO_VERSION > "$JOB_STATE/$TEST_CURR_JOB.env"
  cat "$JOB_STATE/$TEST_CURR_JOB.env"
  
  echo "-----> Creating a previous state file for $TEST_CURR_JOB"
  cat "$JOB_PREVIOUS_STATE/$TEST_CURR_JOB.env"  
  echo "EOF for testscript.sh"
  echo "Below are the values from key-value pair resource"
}

main() {
  dockerhub_login
  set_context  
  get_params  
  create_out_state    
}
main    
