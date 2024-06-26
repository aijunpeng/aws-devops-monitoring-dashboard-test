#!/bin/bash

export SOLUTION_ID="SO0134"
export SOLUTION_NAME="DevOps Monitoring Dashboard on AWS"
export DIST_SOLUTION_NAME="aws-devops-monitoring-dashboard"
export DIST_VERSION=$LAUNCH_OPTIONS_DIST_VERSION
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
export AWS_REGION=$LAUNCH_OPTIONS_Region
echo "SOLUTION_ID: $SOLUTION_ID"
echo "SOLUTION_NAME: $SOLUTION_NAME"
echo "DIST_VERSION: $DIST_VERSION"
echo "DIST_SOLUTION_NAME: $DIST_SOLUTION_NAME"
echo "ACCOUNT_ID: $ACCOUNT_ID"
echo "AWS_REGION: $LAUNCH_OPTIONS_Region"
echo "LAUNCH_OPTIONS_QuickSightPrincipalArn: $LAUNCH_OPTIONS_QuickSightPrincipalArn"
echo "LAUNCH_OPTIONS_QuickSightSourceTemplateArn: $LAUNCH_OPTIONS_QuickSightSourceTemplateArn"
echo "LAUNCH_OPTIONS_UseGitHub: $LAUNCH_OPTIONS_UseGitHub"
echo "LAUNCH_OPTIONS_WebhookSecretToken: $LAUNCH_OPTIONS_WebhookSecretToken"
echo "LAUNCH_OPTIONS_AllowedIPs: $LAUNCH_OPTIONS_AllowedIPs"
echo "LAUNCH_OPTIONS_CodeCommitRepo: $LAUNCH_OPTIONS_CodeCommitRepo"
echo "LAUNCH_OPTIONS_DataDuration: $LAUNCH_OPTIONS_DataDuration"
echo "LAUNCH_OPTIONS_PrincipalTypepe: $LAUNCH_OPTIONS_PrincipalType"
echo "LAUNCH_OPTIONS_PrincipalList: $LAUNCH_OPTIONS_PrincipalList"
echo "LAUNCH_OPTIONS_S3TransitionDays: $LAUNCH_OPTIONS_S3TransitionDays"
echo "LAUNCH_OPTIONS_TagsConfigCodeCommit: $LAUNCH_OPTIONS_TagsConfigCodeCommit"
echo "LAUNCH_OPTIONS_TagsConfigCodeBuild: $LAUNCH_OPTIONS_TagsConfigCodeBuild"
echo "LAUNCH_OPTIONS_TagsConfigCodePipeline: $LAUNCH_OPTIONS_TagsConfigCodePipeline"