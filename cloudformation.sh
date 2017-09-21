aws cloudformation update-stack \
  --stack-name aws-on-tap-ami \
  --template-body file://stack.yml \
  --capabilities CAPABILITY_IAM \
  --parameters \
    ParameterKey=ProjectName,ParameterValue=aws-on-tap-ami \
    ParameterKey=CloudFormationServiceRoleArn,ParameterValue=arn:aws:iam::523613651136:role/cloudformation-aws-on-tap-ami \
    ParameterKey=PublicSubnet,ParameterValue=subnet-fd771da6 \
    ParameterKey=SecurityGroup,ParameterValue=sg-9910e9e4
