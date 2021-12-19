data "archive_file" "lambda_hello_world" {
  type = "zip"
  # path.module is the filesystem path of the module where the expression is placed.
  source_dir  = "${path.module}/hello-world"
  output_path = "${path.module}/hello-world.zip"
}
