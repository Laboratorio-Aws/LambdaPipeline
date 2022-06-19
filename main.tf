
provider "aws" {
  region  = "sa-east-1"
  shared_credentials_file = "/home/igor/.aws/credentials"
  profile = "default"
}


resource "aws_codepipeline" "codepipeline" {
  name     = var.CodePipelineName
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["git_artifacts"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = " Laboratorio-Aws/Lambda"
        BranchName       = "main"
      }
    }
  }

   stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["git_artifacts"]

       configuration = {
        ProjectName = aws_codebuild_project.lambda-codebuild.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["git_artifacts"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.lambda-codebuild-infra.name
      }
    }
  }
}

terraform {
  backend "s3" {
    bucket = "state-file-terraform-bucket"
    key    = "state/statefile-pipeline-lambda"
    region = "sa-east-1"
  }
}