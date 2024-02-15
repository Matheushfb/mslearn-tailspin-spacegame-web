resource "aws_iam_policy" "policy" {
  name        = "RDSLambdaAPIGAtewayPolicy"
  path        = "/"
  description = ""

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        Action = [
          "rds:CreateDBInstance",
          "rds:CreateDBInstanceReadReplica",
          "rds:DescribeDBInstances",
          "rds:ModifyDBInstance",
          "rds:RestoreDBInstanceFromDBSnapshot",
          "rds:RestoreDBInstanceToPointInTime"
        ],
        Resource = [
          "arn:aws:rds:us-east-1:813749056723:db:advancedsharedev"
        ]
      },
      {
        Effect   = "Allow"
        Resource = "*"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow"
      },
    ]
  })
}

resource "aws_iam_role" "role" {
  name = "RDSLambdaAPIGAtewayRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attachment" {
  policy_arn = "${aws_iam_policy.policy.arn}"
  role       = "${aws_iam_role.role.name}"
}