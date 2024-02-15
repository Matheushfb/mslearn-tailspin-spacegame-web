data "archive_file" "init" {
  type        = "zip"
  source_dir = "./script/"
  output_path = "main.py.zip"
}

resource "aws_lambda_function" "lambda_cria_db" {
  function_name = "${var.cliente}-lambda"
  role          = "${aws_iam_role.role.arn}"
  filename      = "lambda_handler.py.zip"
  handler       = "lambda_handler.lambda_handler"
  runtime       = "python3.12"
}

