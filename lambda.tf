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

resource "null_resource" "build_lambda_layers" {
  triggers {
    layer_build = "${md5(file("${local.layers_path}/package.json"))}"
  }

  provisioner "local-exec" {
    working_dir = "${var.layer_path}"
    #command     = "npm install --production && cd ../ && zip -9 -r --quiet ${var.layer_name}.zip *"
    command     = "python3 -m venv venv_pyodbc  && source venv_pyodbc/bin/activate && mkdir python && python -m pip install pyodbc -t script && zip -9 -r --quiet ${var.layer_name}.zip *"
  }
}

resource "aws_lambda_layer_version" "this" {
  filename    = "${var.layer_path}/../${var.layer_name}.zip"
  layer_name  = "${var.layer_name}"
  description = "joi: 14.3.1, moment: 2.24.0"

  compatible_runtimes = ["${var.runtime}"]

  depends_on = ["null_resource.build_lambda_layers"]
}