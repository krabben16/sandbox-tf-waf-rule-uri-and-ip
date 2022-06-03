module "api_gateway" {
  source = "../modules/api_gateway"
}

module "waf" {
  source                = "../modules/waf"
  api_gateway_stage_arn = module.api_gateway.api_gateway_stage_arn
}
