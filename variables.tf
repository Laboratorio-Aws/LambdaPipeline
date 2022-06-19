variable "BucketName" {
  type = string
  description = "Nome do bucket"
}

variable "BucketKey" {
  type = string
  description = "diretorio dos artefatos"
}

variable "RoleCodeBuildName" {
  type = string
  description = "Nome role para o servico codebuild"
}

variable "PoliceCodebuildName" {
  type = string
  description = "Nome police para o servico codebuild"
}

variable "RoleCodePipelinedName" {
  type = string
  description = "Nome role para o servico codepipeline"
}

variable "PoliceCodePipelineName" {
  type = string
  description = "Nome police para o servico codepipeline"
}

variable "CodeBuildProjectLambdaName" {
  type = string
  description = "Nome projeto codebuild"
}

variable "CodeBuildProjectLambdaInfraName" {
  type = string
  description = "Nome projeto codebuild"
}

variable "CodePipelineName" {
  type = string
  description = "Nome da pipeline"
}