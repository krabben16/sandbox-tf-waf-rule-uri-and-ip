resource "aws_wafv2_web_acl" "example" {
  name = "web-acl-association-example"
  scope = "REGIONAL"

  rule {
    name     = "web-acl-association-example-rule"
    priority = 0
    
    # リクエストURIパスが特定のパターン かつ クライアントIPが特定の値「ではない」場合にブロック
    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.example.arn

            field_to_match {
              uri_path {}
            }

            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }

        statement {
          not_statement {
            statement {
              ip_set_reference_statement {
                arn = aws_wafv2_ip_set.example.arn
              }
            }
          }
        }
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-metric-name"
      sampled_requests_enabled   = false
    }
  }

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_ip_set" "example" {
  name               = "web-acl-association-example-ip-set"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = [
    "127.0.0.1/32",
  ]
}

resource "aws_wafv2_regex_pattern_set" "example" {
  name        = "web-acl-association-example-regex-pattern-set"
  scope       = "REGIONAL"

  dynamic "regular_expression" {
    for_each = [
      "^\\/example\\/path1$",
    ]

    content {
      regex_string = regular_expression.value
    }
  }
}

resource "aws_wafv2_web_acl_association" "example" {
  resource_arn = var.api_gateway_stage_arn
  web_acl_arn  = aws_wafv2_web_acl.example.arn
}
