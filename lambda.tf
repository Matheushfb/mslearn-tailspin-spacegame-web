data "archive_file" "init" {
  type        = "zip"
  source_dir = "./script/"
  output_path = "lambda_handler.py.zip"
}

resource "aws_lambda_function" "lambda_cria_db" {
  function_name = "${var.cliente}-lambda"
  role          = "${aws_iam_role.role.arn}"
  filename      = "lambda_handler.py.zip"
  handler       = "lambda_handler.lambda_handler"
  runtime       = "${var.runtime}"
}


resource "aws_lambda_layer_version" "this" {
  filename    = "${var.layer_name}.zip"
  layer_name  = "${var.layer_name}"
  description = "pyodbc"

  compatible_runtimes = ["${var.runtime}"]

  depends_on = ["null_resource.build_lambda_layers"]
}