# ============= POLÍTICA PERSONALIZADA PARA DYNAMODB =============
resource "aws_iam_policy" "dynamodb_access_policy" {
  name = "lambda-dynamodb-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ],
        Resource = "arn:aws:dynamodb:${var.aws_region}:*:table/User"
      }
    ]
  })
}