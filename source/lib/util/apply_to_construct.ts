// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import { CfnFunction } from 'aws-cdk-lib/aws-lambda';
import { Construct } from 'constructs';
import { Stack } from 'aws-cdk-lib';
import { CfnPolicy, CfnRole } from 'aws-cdk-lib/aws-iam';
import { addCfnSuppressRules } from '@aws-solutions-constructs/core';
import { NagSuppressions } from 'cdk-nag';

/**
 *
 * @param scope
 * @param id
 */
export function ApplyCfnSuppressRulesToLogRetentionResource(scope: Construct, id: string) {
  // Add rules to suppress to log retention lambda
  const logRetentionLambda = Stack.of(scope).node.tryFindChild(id)?.node.findChild('Resource') as CfnFunction;
  if (logRetentionLambda) {
    addCfnSuppressRules(logRetentionLambda, [
      {
        id: 'W58',
        reason: 'Lambda has the required permission to write CloudWatch Logs through a custom policy.'
      },
      {
        id: 'W89',
        reason: 'There is no need to deploy this Lambda to a VPC.'
      },
      {
        id: 'W92',
        reason: 'There is no need for Reserved Concurrency.'
      }
    ]);
  }

  // Add rules to suppress to log retention lambda policy
  const logRetentionPolicy = Stack.of(scope)
    .node.tryFindChild(id)
    ?.node.tryFindChild('ServiceRole')
    ?.node.findChild('DefaultPolicy')
    .node.findChild('Resource') as CfnPolicy;
  if (logRetentionPolicy) {
    addCfnSuppressRules(logRetentionPolicy, [
      {
        id: 'W12',
        reason:
          'Resource * is required by the Lambda Execution role, so that the Lambda can add ResourcePolicies to all required resources.'
      }
    ]);
    NagSuppressions.addResourceSuppressions(logRetentionPolicy, [
      {
        id: 'AwsSolutions-IAM5',
        reason:
          'Resource * is required by the Lambda Execution role, so that the Lambda can add ResourcePolicies to all required resources.'
      }
    ]);
  }

  // Add cdk-nag suppression to log retention service role
  const logRetentionServiceRole = Stack.of(scope)
    .node.tryFindChild(id)
    ?.node.tryFindChild('ServiceRole')
    ?.node.findChild('Resource') as CfnRole;
  if (logRetentionServiceRole) {
    NagSuppressions.addResourceSuppressions(logRetentionServiceRole, [
      {
        id: 'AwsSolutions-IAM4',
        reason: 'The managed policy is automatically generated by CDK itself to enable log retention.'
      }
    ]);
  }
}