# providers.tf contents
provider "vault" {
  address = "http://127.0.0.1:8200"  # Change based on your Vault instance
  token   = "myroot"  # Use your Vault root token
}

provider "local" {}

# data_sources.tf contents
data "vault_generic_secret" "dev" {
  path = "secret/myapp/config"
}

resource "local_file" "username_file" {
  content  = data.vault_generic_secret.dev.data["username"]
  filename = "${path.module}/username.txt"
}

output "username_file_path" {
  value = local_file.username_file.filename
}
