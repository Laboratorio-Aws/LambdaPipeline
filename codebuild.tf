resource "aws_codebuild_project" "lambda-codebuild" {
  name          = var.CodeBuildProjectLambdaName
  description   = "codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "S3"
    location = aws_s3_bucket.codepipeline_bucket.id
    packaging = "ZIP"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "access_key"
      value = "access_key"
      type = "PARAMETER_STORE"
    }

    environment_variable {
      name  = "secret_key"
      value = "secret_key"
      type  = "PARAMETER_STORE"
    }

     environment_variable {
      name  = "bucket_pipe"
      value = var.BucketName
    }

    environment_variable {
      name  = "key_pipe"
      value = var.BucketKey
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.codepipeline_bucket.id}/build-log"
    }
  }

  source {
    type = "S3"
    location = "${aws_s3_bucket.codepipeline_bucket.id}/git_artifacts"
    buildspec = "buildspec.yml"
  }

}

resource "aws_codebuild_project" "lambda-codebuild-infra" {
  name          = var.CodeBuildProjectLambdaInfraName
  description   = "codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "S3"
    location = aws_s3_bucket.codepipeline_bucket.id
    packaging = "ZIP"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "access_key"
      value = "access_key"
      type = "PARAMETER_STORE"
    }

    environment_variable {
      name  = "secret_key"
      value = "secret_key"
      type  = "PARAMETER_STORE"
    }

     environment_variable {
      name  = "bucket_pipe"
      value = var.BucketName
    }

    environment_variable {
      name  = "key_pipe"
      value = var.BucketKey
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.codepipeline_bucket.id}/build-log"
    }
  }

  source {
    type = "S3"
    location = "${aws_s3_bucket.codepipeline_bucket.id}/git_artifacts"
    buildspec = file("${path.module}/buildspec/buildspec.txt")
  }

}