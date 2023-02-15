data "aws_iam_policy_document" "dummy_lambda_cloudwatch_policy_document" {
  statement {

    actions = ["logs:CreateLogGroup"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }

  statement {

    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.dummy_lambda_name}:*"
    ]
  }
}

data "aws_iam_policy_document" "ingestion_lambda_cloudwatch_policy_document" {
  statement {

    actions = ["logs:CreateLogGroup"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }

  statement {

    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.ingestion_lambda_name}:*"
    ]
  }
}

data "aws_iam_policy_document" "processing_lambda_cloudwatch_policy_document" {
  statement {

    actions = ["logs:CreateLogGroup"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }

  statement {

    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.processing_lambda_name}:*"
    ]
  }
}

data "aws_iam_policy_document" "population_lambda_cloudwatch_policy_document" {
  statement {

    actions = ["logs:CreateLogGroup"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }

  statement {

    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.population_lambda_name}:*"
    ]
  }
}

resource "aws_iam_policy" "dummy_lambda_cloudwatch_policy" {
  name_prefix = "cw-policy-${var.dummy_lambda_name}"
  policy      = data.aws_iam_policy_document.dummy_lambda_cloudwatch_policy_document.json
}

resource "aws_iam_role_policy_attachment" "dummy_lambda_cloudwatch_policy_attachment" {
  role       = aws_iam_role.ingest-lambda-role.name
  policy_arn = aws_iam_policy.dummy_lambda_cloudwatch_policy.arn
}
