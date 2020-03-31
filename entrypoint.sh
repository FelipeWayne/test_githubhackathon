#!/bin/bash
# 
set -e

REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH") ;

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable with the permission for the specified git operation." ;
	exit 1 ;
fi


# 
git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git ;
# 
git config --global user.email "test_revert@github.com" ;
# 
git config --global user.name "Test Revert Merge test" ;
# 
# 
# 
set -o xtrace
git fetch origin $HEAD_BRANCH ;

# 
# 
git checkout -b $HEAD_BRANCH origin/$GITHUB_REF ;

# 
# 
# 
git cat-file -t $GITHUB_SHA ;
# 
git revert -m 1 $GITHUB_SHA --no-edit ;
# 
git push origin HEAD:$INPUT_BRANCH_NAME ;
