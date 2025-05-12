#!/bin/bash

echo "🔍 Searching for ECS-related CloudWatch log groups..."

# Get all log groups and filter ECS-related ones
LOG_GROUPS=$(aws logs describe-log-groups --query 'logGroups[].logGroupName' --output text | tr '\t' '\n' | grep -E '^/ecs/|^/aws/ecs/')

if [ -z "$LOG_GROUPS" ]; then
  echo "✅ No ECS-related log groups found."
  exit 0
fi

# Loop through and delete each log group
for LOG_GROUP in $LOG_GROUPS; do
  echo "🗑️ Deleting log group: $LOG_GROUP"
  aws logs delete-log-group --log-group-name "$LOG_GROUP" >/dev/null 2>&1
done

echo "✅ All ECS-related log groups deleted."
