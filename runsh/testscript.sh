#!/bin/bash -e

export TEST_CURR_JOB="$JOB_NAME"
export TEST_RES_DH="ship_dh"
export TEST_RES_REPO="pipeline_scriptRepo"
export TEST_RES_PARAMS="test_params"
export TEST_RES_IN_IMG="sample_img"
export TEST_RES_IMAGE_OUT="test_out_img"

# since resources here have dashes Shippable replaces them and UPPER cases them
export TEST_RES_REPO_UP=$(echo $TEST_RES_REPO | awk '{print toupper($0)}')
export TEST_RES_REPO_STATE=$(eval echo "$"$TEST_RES_REPO_UP"_STATE")

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
echo RUNSH_RES_ID=$RESOURCE_ID
echo RUNSH_JOB_NAME=$JOB_NAME
echo RUNSH_JOB_TYPE=$JOB_TYPE
echo RUNSH_BUILD_ID=$BUILD_ID
echo RUNSH_BUILD_NUMBER=$BUILD_NUMBER
echo RUNSH_BUILD_JOB_ID=$BUILD_JOB_ID
echo RUNSH_BUILD_JOB_NUMBER=$BUILD_JOB_NUMBER
echo RUNSH_JOB_PATH=$JOB_PATH
echo RUNSH_JOB_STATE=$JOB_STATE
echo RUNSH_JOB_PREVIOUS_STATE=$JOB_PREVIOUS_STATE
echo RUNSH_JOB_MESSAGE_PATH=$JOB_MESSAGE

export TEST_JOBNAME_NAME=$(eval echo "$"$JOB_NAME"_NAME")
export TEST_JOBNAME_TYPE=$(eval echo "$"$JOB_NAME"_TYPE")
export TEST_JOBNAME_PATH=$(eval echo "$"$JOB_NAME"_PATH")
export TEST_JOBNAME_PREVIOUS_STATE=$(eval echo "$"$JOB_NAME"_PREVIOUS_STATE")
export TEST_JOBNAME_STATE=$(eval echo "$"$JOB_NAME"_STATE")
export TEST_JOBNAME_MESSAGE=$(eval echo "$"$JOB_NAME"_MESSAGE")

echo TEST_JOBNAME_NAME=$TEST_JOBNAME_NAME
echo TEST_JOBNAME_TYPE=$TEST_JOBNAME_TYPE
echo TEST_JOBNAME_PATH=$TEST_JOBNAME_PATH
echo TEST_JOBNAME_STATE=$TEST_JOBNAME_STATE
echo TEST_JOBNAME_PREVIOUS_STATE=$TEST_JOBNAME_PREVIOUS_STATE
echo TEST_JOBNAME_MESSAGE=$TEST_JOBNAME_MESSAGE

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
export TEST_RESOURCE_PARAMS_FIELDNAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_PARAMS_FIELDNAME")
export TEST_RESOURCE_INTEGRATION_FIELDNAME=$(eval echo "$"$TEST_RES_IN_IMG_UP"_INTEGRATION_FIELDNAME")

echo $TEST_RESOURCE_NAME
echo $TEST_RESOURCE_ID
echo $TEST_RESOURCE_TYPE
echo $TEST_RESOURCE_PATH
echo $TEST_RESOURCE_STATE
echo $TEST_RESOURCE_META
echo $TEST_RESOURCE_OPERATION
echo $TEST_RESOURCE_VERSIONNAME
echo $TEST_RESOURCE_VERSIONNUMBER
echo $TEST_RESOURCE_VERSIONID
echo $TEST_RESOURCE_SOURCENAME
echo $TEST_RESOURCE_SEED_VERSIONNAME
echo $TEST_RESOURCE_PARAMS_FIELDNAME
echo $TEST_RESOURCE_INTEGRATION_FIELDNAME

dockerhub_login() {
  echo "-----> Logging in to Dockerhub" 
  
  export TEST_DH_USERNAME=$(eval echo "$"$TEST_RES_DH_INT_STR"_USERNAME")
  export TEST_DH_PASSWORD=$(eval echo "$"$TEST_RES_DH_INT_STR"_PASSWORD")
  export TEST_DH_EMAIL=$(eval echo "$"$TEST_RES_DH_INT_STR"_EMAIL")
  
  echo TEST_DH_USERNAME=$TEST_DH_USERNAME
  echo TEST_DH_PASSWORD_LENGTH=${#TEST_DH_PASSWORD} #show only count
  sudo docker login -u $TEST_DH_USERNAME -p $TEST_DH_PASSWORD -e $TEST_DH_EMAIL
}

set_context() {
  echo "-----> Git resource"
  export TEST_VERSION=$(eval echo "$"$TEST_RES_REPO_UP"_VERSIONNUMBER")
  export TEST_REPO_BRANCH=$(eval echo "$"$TEST_RES_REPO_UP"_BRANCH")
  export TEST_REPO_COMMIT=$(eval echo "$"$TEST_RES_REPO_UP"_COMMIT")
  export TEST_REPO_COMMIT_MESSAGE=$(eval echo "$"$TEST_RES_REPO_UP"_COMMIT_MESSAGE")
  export TEST_REPO_COMMITTER=$(eval echo "$"$TEST_RES_REPO_UP"_COMMITTER")  

  echo TEST_RES_REPO=$TEST_RES_REPO
  echo TEST_RES_REPO_UP=$TEST_RES_REPO_UP
  echo TEST_RES_REPO_STATE=$TEST_RES_REPO_STATE
  echo TEST_REPO_RESO_VERSION=$TEST_VERSION
  echo TEST_BRANCH=$TEST_REPO_BRANCH
  echo TEST_COMMIT=$TEST_REPO_COMMIT
  echo TEST_COMMIT_MESSAGE=$TEST_REPO_COMMIT_MESSAGE
  echo TEST_RESO_COMMITER=$TEST_REPO_COMMITTER
}

get_params() {
  echo "-----> Env in paramas resource"
  
  export TEST_RES_PARAMS_UP=$(echo $TEST_RES_PARAMS | awk '{print toupper($0)}')
  export TEST_RES_PARAMS_STR=$TEST_RES_PARAMS_UP"_PARAMS"
  export TEST_USER_PARAM=$(eval echo "$"$TEST_RES_PARAMS_STR"_TEST")
  export TEST_SEC_PARAM=$(eval echo "$"$TEST_RES_PARAMS_STR"_DEV")
  echo TEST_RES_PARAMS_STR=$TEST_RES_PARAMS_STR
  echo TEST_USER_PARAM=$TEST_USER_PARAM
  echo TEST_SECURE_PARAM=$TEST_SEC_PARAM
}

create_out_state() {
  echo "-----> Creating a state file for $RES_IMG_OUT_UP"
  echo versionName=$TEST_VERSION > "$TEST_STATE/$RES_IMAGE_OUT.env"
  echo commitSHA=$TEST_REPO_COMMIT >> "$JOB_STATE/$RES_IMAGE_OUT.env"
  
  echo "-----> Creating a state file for $TEST_CURR_JOB"
  echo versionName=$TEST_VERSION > "$JOB_STATE/$TEST_CURR_JOB.env"
  cat "$JOB_STATE/$TEST_CURR_JOB.env"

  echo "-----> Creating a previous state file for $TEST_CURR_JOB"
  cat "$JOB_PREVIOUS_STATE/$TEST_CURR_JOB.env"   
}

main() {
  dockerhub_login
  set_context  
  get_params  
  create_out_state    
}
main
