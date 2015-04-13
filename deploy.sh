#!/bin/bash

# configs
export repo=https://github.com/eladg/rerised.com
export repo_name=rerised.com
export tmp_dir=/tmp/${repo_name}
export bucket=s3://${repo_name}/
export branch=master

# test everything:
type aws >/dev/null 2>&1 || { echo >&2 "aws is not installed (brew install awscli?). Aborting."; exit 1; }

# Start here:
rm -rf $tmp_dir

# clone repository
echo "cloning repository to ${tmp_dir}"
read -p "Press any key..."

git clone --depth 1 --single-branch -b $branch $repo $tmp_dir
echo ""

echo "uploading to S3"
aws s3 sync $tmp_dir/public $bucket --delete
echo "done."
echo ""

echo "finish deploy. check http://${s3path}.s3-website-us-west-1.amazonaws.com"
read -p "Press any key..."
exit 0;
