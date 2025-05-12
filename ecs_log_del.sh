#!/bin/bash

# Disable Git Bash automatic path conversion
export MSYS_NO_PATHCONV=1

echo "Searching for ECS-related CloudWatch log groups..."

aws logs describe-log-groups --query 'logGroups[].logGroupName' --output text | tr '\t' '\n' | grep -E '^/ecs/|^/aws/ecs/' | while read -r LOG_GROUP; do
  echo "Deleting log group: $LOG_GROUP"
  aws logs delete-log-group --log-group-name "$LOG_GROUP"
done

echo "All ECS-related log groups deleted."
