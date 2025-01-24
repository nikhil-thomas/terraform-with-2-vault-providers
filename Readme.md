## Local Testing Steps

1. **Run the development Vault container:**

   ```bash
   podman run -d --name vault-dev -e 'VAULT_DEV_ROOT_TOKEN_ID=myroot' -p 8200:8200 hashicorp/vault
   ```

2. **Set Vault address and root token for development:**

   ```bash
   export VAULT_ADDR='http://127.0.0.1:8200'
   export VAULT_TOKEN='myroot'
   ```

3. **Push values to the development Vault:**

   ```bash
   vault kv put secret/dev username=admin-dev password=password-dev
   ```

4. **Run the production Vault container:**

   ```bash
   podman run -d --name vault-prod -e 'VAULT_DEV_ROOT_TOKEN_ID=myroot' -p 8201:8200 hashicorp/vault
   ```

5. **Set Vault address and root token for production:**

   ```bash
   export VAULT_ADDR='http://127.0.0.1:8201'
   export VAULT_TOKEN='myroot'
   ```

6. **Push values to the production Vault:**

   ```bash
   vault kv put secret/prod username=admin-prod password=password-prod
   ```

7. **Initialize Terraform:**

   ```bash
   terraform init
   ```

8. **Apply Terraform configuration:**

   ```bash
   terraform apply
   ```

9. **Output files:**

   - `dev_username.txt` containing `admin-dev`
   - `prod_username.txt` containing `admin-prod`
