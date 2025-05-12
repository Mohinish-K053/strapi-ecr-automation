#!/bin/bash
echo "Searching for ECS-related CloudWatch log groups..."

# Get all log groups, one per line, and filter only ECS ones
aws logs describe-log-groups --query 'logGroups[].logGroupName' --output text | tr '\t' '\n' | grep -E '^/ecs/|^/aws/ecs/' | while read -r LOG_GROUP; do
  LOG_GROUP_TRIMMED=$(echo "$LOG_GROUP" | xargs)
  echo "Deleting log group: $LOG_GROUP_TRIMMED"
  aws logs delete-log-group --log-group-name "$LOG_GROUP_TRIMMED"
done
echo "All ECS-related log groups deleted."
