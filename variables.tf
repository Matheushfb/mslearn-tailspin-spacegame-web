variable "cliente" {
  type = string
  default = ""
  description = "Nome do cliente para identificar a função Lambda"
}

variable "role" {
  description = " IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  type        = string
  default     = ""
}


