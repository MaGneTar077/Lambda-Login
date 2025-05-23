resource "aws_lambda_function" "user_login" {
  function_name = var.user_lambda_name
  handler       = var.user_lambda_handler
  runtime       = var.lambda_runtime
  role = data.aws_iam_role.lambda_exec_role.arn
  filename      = var.user_lambda_zip
  timeout       = 30
  memory_size   = 512

  environment {
    variables = {
      TABLE_NAME = "User"
    }
  }

  depends_on = [
    data.aws_iam_role.lambda_exec_role,
    aws_iam_role_policy_attachment.cloudwatch_logs,
    aws_iam_policy_attachment.lambda_dynamodb_attach
  ]
}
