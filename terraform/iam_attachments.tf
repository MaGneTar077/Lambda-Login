resource "aws_iam_policy_attachment" "lambda_dynamodb_attach" {
  name       = "attach-dynamodb-to-lambda"
  roles      = [data.aws_iam_role.lambda_exec_role.name]
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

# ============= PERMISOS PARA LOGS DE CLOUDWATCH (RECOMENDADO) =============
resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role       = data.aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}