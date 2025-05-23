# Región AWS
variable "aws_region" {
  description = "Región de AWS"
  default     = "us-west-1"
}

# =======================
# LAMBDA - USUARIOS
# =======================
variable "user_lambda_name" {
  default = "user-lambda-login"
}

variable "user_lambda_zip" {
  default = "../lambda-login/target/lambda-login-1.0-SNAPSHOT-lambda-package.zip" # Ruta al ZIP que tendrá tu Lambda de usuario
}

variable "user_lambda_handler" {
  default = "org.example.StreamLambdaHandler"
}

variable "user_api_path" {
  default = "usuarios/{proxy+}"
}

# =======================
# API Gateway Stage
# =======================
variable "api_env_stage_name" {
  default = "dev"
}

# =======================
# Runtime para Lambdas (java 17)
# =======================
variable "lambda_runtime" {
  default = "java17"
}

variable "user_login_zip" {
  default = "../lambda-login/target/lambda-login-1.0-SNAPSHOT-lambda-package.zip"
}

variable "user_login_handler" {
  default = "org.example.StreamLambdaHandler"
}