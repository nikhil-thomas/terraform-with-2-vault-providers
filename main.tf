# providers.tf contents
provider "vault" {
  alias   = "dev"
  address = "http://127.0.0.1:8200"  # Address for the first Vault instance
  token   = "myroot"  # Use your Vault root token for the first instance
}

provider "vault" {
  alias   = "prod"
  address = "http://127.0.0.1:8201"  # Address for the second Vault instance
  token   = "myroot"  # Use your Vault root token for the second instance
}

provider "local" {}

# data_sources.tf contents
data "vault_generic_secret" "dev" {
  provider = vault.dev
  path     = "secret/myapp/config"
}

data "vault_generic_secret" "prod" {
  provider = vault.prod
  path     = "secret/myapp/config"
}

resource "local_file" "username_file" {
  content  = data.vault_generic_secret.dev.data["username"]
  filename = "${path.module}/username.txt"
}

resource "local_file" "prod_username_file" {
  content  = data.vault_generic_secret.prod.data["username"]
  filename = "${path.module}/prod_username.txt"
}

output "username_file_path" {
  value = local_file.username_file.filename
}

output "prod_username_file_path" {
  value = local_file.prod_username_file.filename
}
