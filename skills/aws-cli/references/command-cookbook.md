# AWS CLI Command Cookbook

## Official Documentation
- AWS CLI v2 command reference: https://docs.aws.amazon.com/cli/latest/reference/

## Preflight and Context
```bash
scripts/aws-preflight.sh
scripts/aws-auth-status.sh
scripts/aws-context.sh
scripts/aws-diagnostics.sh --json
```

## Inspect-First Patterns
```bash
aws sts get-caller-identity --output json
aws configure list-profiles
aws ec2 describe-instances --output table
aws s3api list-buckets --output table
aws cloudformation describe-stacks --output table
```

## Planned Write Patterns (Confirm First)
```bash
aws s3api create-bucket --bucket <name> --region <region>
aws ec2 terminate-instances --instance-ids <id>
aws iam put-role-policy --role-name <role> --policy-name <name> --policy-document file://policy.json
```

## Output and Query Patterns
```bash
aws ec2 describe-instances --query 'Reservations[].Instances[].{Id:InstanceId,State:State.Name}' --output table
aws s3api list-buckets --query 'Buckets[].Name' --output text
```

## Environment Notes
- Use `--profile` and `--region` explicitly for multi-account workflows.
- Prefer `--no-cli-pager` in automation and diagnostics.
