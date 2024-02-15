data "archive_file" "init" {
  type        = "zip"
  source_dir = "./script/"
  output_path = "main.py.zip"
}

resource "aws_lambda_function" "lambda_cria_db" {
  function_name = "${var.cliente}-lambda"
  role          = "${aws_iam_role.role.arn}"
  filename      = "main.py.zip"
  handler       = "main.handler"
  runtime       = "python3.12"
}

