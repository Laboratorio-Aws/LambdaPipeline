
resource "aws_codestarconnections_connection" "github" {
  name          = "conexao_github"
  provider_type = "GitHub"
}