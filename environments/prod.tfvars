project_name    = "buridogs"
environment     = "prod"
location        = "eastus2"
custom_domain   = "api.buridogs.com.br"
ssl_cert_path   = "../certificates/buridogs.pfx"
ssl_cert_password = "your-certificate-password"

tags = {
  Environment = "Production"
  Project     = "Buridogs"
  ManagedBy   = "Terraform"
}