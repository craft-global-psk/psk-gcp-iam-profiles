#!/usr/bin/env bash
export ENVIRONMENT=$1

inspec exec tests/iam-roles -t gcp://
inspec exec tests/org-tests -t gcp://
