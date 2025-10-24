# AWS Deployment Integration ☁️

A comprehensive guide for implementing scalable, secure AWS deployments using Claude Code Tresor utilities. This integration demonstrates infrastructure as code, CI/CD automation, and enterprise-grade cloud architecture patterns.

## 📋 Overview

This integration covers complete AWS deployment implementation from infrastructure setup to production deployment, utilizing Claude Code Tresor's specialized utilities for architecture design, security, and automation.

### 🎯 Integration Goals

- **Infrastructure as Code**: Fully automated infrastructure provisioning
- **Scalable Architecture**: Auto-scaling and high availability
- **Security Best Practices**: AWS Well-Architected Framework compliance
- **Cost Optimization**: Resource efficiency and cost monitoring
- **Disaster Recovery**: Multi-region backup and recovery
- **Monitoring & Observability**: Comprehensive application and infrastructure monitoring

### 🔧 Utilities Used

- **Commands**: `/scaffold`, `/review`, `/test-gen`, `/docs-gen`
- **Agents**: `@architect`, `@security-auditor`, `@performance-tuner`, `@code-reviewer`

## 🏗️ Phase 1: Architecture Design & Infrastructure Setup

### Step 1: AWS Architecture Design

```bash
@architect Design AWS cloud architecture for a scalable web application with the following requirements:
- Auto-scaling web application tier (ECS/Fargate)
- Database tier with read replicas (RDS)
- Caching layer (ElastiCache)
- Content delivery (CloudFront + S3)
- Load balancing (Application Load Balancer)
- Container orchestration (ECS with Fargate)
- CI/CD pipeline (CodePipeline + CodeBuild)
- Monitoring and logging (CloudWatch + X-Ray)
- Security (WAF, Security Groups, IAM)
- Multi-AZ deployment for high availability
- Cost optimization strategies

Consider:
- AWS Well-Architected Framework pillars
- Security best practices
- Performance optimization
- Cost-effective resource sizing
- Disaster recovery planning
```

**Architecture Output:**
```mermaid
graph TB
    Internet([Internet]) --> CF[CloudFront CDN]
    Internet --> WAF[AWS WAF]
    WAF --> ALB[Application Load Balancer]
    CF --> S3[S3 Static Assets]

    ALB --> ECS1[ECS Fargate AZ-1a]
    ALB --> ECS2[ECS Fargate AZ-1b]
    ALB --> ECS3[ECS Fargate AZ-1c]

    ECS1 --> Cache[ElastiCache Redis]
    ECS2 --> Cache
    ECS3 --> Cache

    ECS1 --> RDS_Primary[RDS Primary]
    ECS2 --> RDS_Primary
    ECS3 --> RDS_Primary

    RDS_Primary --> RDS_Read1[RDS Read Replica AZ-1b]
    RDS_Primary --> RDS_Read2[RDS Read Replica AZ-1c]

    subgraph Monitoring
        CW[CloudWatch]
        XRay[X-Ray Tracing]
        SNS[SNS Alerts]
    end

    subgraph CI/CD
        CP[CodePipeline]
        CB[CodeBuild]
        ECR[ECR Container Registry]
    end
```

### Step 2: Infrastructure Scaffolding

```bash
/scaffold aws-infrastructure cloud-deployment --services ecs,rds,elasticache,cloudfront,alb,waf --iac terraform --cicd codepipeline --monitoring cloudwatch --security comprehensive
```

**Generated Structure:**
```
aws-deployment/
├── infrastructure/
│   ├── terraform/
│   │   ├── modules/
│   │   │   ├── vpc/
│   │   │   ├── ecs/
│   │   │   ├── rds/
│   │   │   ├── elasticache/
│   │   │   ├── cloudfront/
│   │   │   └── monitoring/
│   │   ├── environments/
│   │   │   ├── dev/
│   │   │   ├── staging/
│   │   │   └── production/
│   │   └── shared/
│   └── cloudformation/
├── applications/
│   ├── web-app/
│   ├── api/
│   └── worker/
├── scripts/
│   ├── deploy/
│   ├── backup/
│   └── monitoring/
├── ci-cd/
│   ├── buildspec.yml
│   ├── pipeline.yml
│   └── scripts/
└── docs/
```

### Step 3: Terraform Infrastructure Modules

```hcl
# infrastructure/terraform/modules/vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-${count.index + 1}"
    Environment = var.environment
    Type        = "public"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.project_name}-private-${count.index + 1}"
    Environment = var.environment
    Type        = "private"
  }
}

# Database Subnets
resource "aws_subnet" "database" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.project_name}-db-${count.index + 1}"
    Environment = var.environment
    Type        = "database"
  }
}

# NAT Gateways
resource "aws_eip" "nat" {
  count = length(var.availability_zones)

  domain = "vpc"
  depends_on = [aws_internet_gateway.main]

  tags = {
    Name        = "${var.project_name}-nat-eip-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "${var.project_name}-nat-${count.index + 1}"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.main]
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route_table" "private" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name        = "${var.project_name}-private-rt-${count.index + 1}"
    Environment = var.environment
  }
}

# Route Table Associations
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
```

### Step 4: ECS Fargate Configuration

```hcl
# infrastructure/terraform/modules/ecs/main.tf
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "${var.project_name}-cluster"
    Environment = var.environment
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

# Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "app"
      image = "${var.ecr_repository_url}:latest"

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "NODE_ENV"
          value = var.environment
        },
        {
          name  = "PORT"
          value = tostring(var.container_port)
        }
      ]

      secrets = [
        {
          name      = "DATABASE_URL"
          valueFrom = aws_ssm_parameter.database_url.arn
        },
        {
          name      = "REDIS_URL"
          valueFrom = aws_ssm_parameter.redis_url.arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }

      healthCheck = {
        command = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}/health || exit 1"]
        interval = 30
        timeout = 5
        retries = 3
        startPeriod = 60
      }
    }
  ])

  tags = {
    Name        = "${var.project_name}-task-definition"
    Environment = var.environment
  }
}

# ECS Service
resource "aws_ecs_service" "app" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = var.container_port
  }

  # Auto Scaling
  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [var.lb_listener]

  tags = {
    Name        = "${var.project_name}-service"
    Environment = var.environment
  }
}

# Auto Scaling
resource "aws_appautoscaling_target" "ecs" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_cpu" {
  name               = "${var.project_name}-cpu-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 70.0
  }
}

resource "aws_appautoscaling_policy" "ecs_memory" {
  name               = "${var.project_name}-memory-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80.0
  }
}
```

### Step 5: RDS Database Configuration

```hcl
# infrastructure/terraform/modules/rds/main.tf
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.database_subnet_ids

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_parameter_group" "main" {
  family = "postgres14"
  name   = "${var.project_name}-db-params"

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000" # Log queries taking longer than 1 second
  }

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  tags = {
    Name        = "${var.project_name}-db-params"
    Environment = var.environment
  }
}

# Primary Database
resource "aws_db_instance" "primary" {
  allocated_storage           = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  storage_type               = "gp3"
  storage_encrypted          = true
  kms_key_id                = var.kms_key_id

  engine              = "postgres"
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  db_name            = var.database_name
  username           = var.master_username
  password           = var.master_password
  port               = 5432

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  parameter_group_name   = aws_db_parameter_group.main.name

  backup_retention_period   = var.backup_retention_period
  backup_window            = "03:00-04:00"
  maintenance_window       = "Sun:04:00-Sun:05:00"
  auto_minor_version_upgrade = true

  # Performance Insights
  performance_insights_enabled = true
  performance_insights_retention_period = 7

  # Monitoring
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  # Deletion protection
  deletion_protection = var.environment == "production" ? true : false
  skip_final_snapshot = var.environment == "production" ? false : true
  final_snapshot_identifier = var.environment == "production" ? "${var.project_name}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}" : null

  tags = {
    Name        = "${var.project_name}-primary-db"
    Environment = var.environment
    Type        = "primary"
  }
}

# Read Replicas
resource "aws_db_instance" "read_replica" {
  count = var.create_read_replicas ? length(var.availability_zones) - 1 : 0

  identifier             = "${var.project_name}-read-replica-${count.index + 1}"
  replicate_source_db    = aws_db_instance.primary.identifier
  instance_class         = var.read_replica_instance_class
  publicly_accessible    = false
  auto_minor_version_upgrade = true

  # Performance Insights
  performance_insights_enabled = true

  # Monitoring
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  tags = {
    Name        = "${var.project_name}-read-replica-${count.index + 1}"
    Environment = var.environment
    Type        = "read-replica"
  }
}

# Security Group
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
    description     = "PostgreSQL access from ECS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name        = "${var.project_name}-rds-sg"
    Environment = var.environment
  }
}
```

## 🔐 Phase 2: Security & Compliance

### Step 6: Security Configuration

```bash
@security-auditor Design comprehensive AWS security architecture including:
- IAM roles and policies with least privilege
- VPC security groups and NACLs
- WAF rules for application protection
- AWS Config for compliance monitoring
- CloudTrail for audit logging
- KMS for encryption at rest and in transit
- Secrets Manager for credential management
- Security Hub for centralized security findings
- GuardDuty for threat detection
- AWS Organizations and SCPs for account governance
```

### Step 7: IAM Roles and Policies

```hcl
# infrastructure/terraform/modules/iam/main.tf
# ECS Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.project_name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-ecs-execution-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Custom policy for accessing secrets and parameters
resource "aws_iam_policy" "ecs_secrets_policy" {
  name        = "${var.project_name}-ecs-secrets-policy"
  description = "Policy for ECS to access secrets and parameters"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
        ]
        Resource = [
          "arn:aws:ssm:${var.aws_region}:${var.account_id}:parameter/${var.project_name}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          "arn:aws:secretsmanager:${var.aws_region}:${var.account_id}:secret:${var.project_name}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          var.kms_key_arn
        ]
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-ecs-secrets-policy"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs_secrets_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_secrets_policy.arn
}

# ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-ecs-task-role"
    Environment = var.environment
  }
}

# Application-specific permissions
resource "aws_iam_policy" "app_policy" {
  name        = "${var.project_name}-app-policy"
  description = "Policy for application runtime permissions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.app_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "ses:FromAddress" = var.ses_from_address
          }
        }
      },
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-app-policy"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "app_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.app_policy.arn
}

# CodeBuild Service Role
resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_name}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-codebuild-role"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "${var.project_name}-codebuild-policy"
  description = "Policy for CodeBuild service"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:/aws/codebuild/${var.project_name}*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.artifacts.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-codebuild-policy"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}
```

### Step 8: WAF Configuration

```hcl
# infrastructure/terraform/modules/waf/main.tf
resource "aws_wafv2_web_acl" "main" {
  name  = "${var.project_name}-waf"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  # AWS Managed Rules - Core Rule Set
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        # Exclude specific rules if needed
        excluded_rule {
          name = "SizeRestrictions_BODY"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  # AWS Managed Rules - Known Bad Inputs
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  # Rate Limiting Rule
  rule {
    name     = "RateLimitRule"
    priority = 3

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = var.rate_limit
        aggregate_key_type = "IP"

        scope_down_statement {
          geo_match_statement {
            country_codes = var.allowed_countries
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitRuleMetric"
      sampled_requests_enabled   = true
    }
  }

  # IP Reputation List
  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 4

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAmazonIpReputationListMetric"
      sampled_requests_enabled   = true
    }
  }

  # Custom SQL Injection Rule
  rule {
    name     = "SQLInjectionRule"
    priority = 5

    action {
      block {}
    }

    statement {
      sqli_match_statement {
        field_to_match {
          all_query_arguments {}
        }

        text_transformation {
          priority = 0
          type     = "URL_DECODE"
        }

        text_transformation {
          priority = 1
          type     = "HTML_ENTITY_DECODE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "SQLInjectionRuleMetric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project_name}-waf"
    sampled_requests_enabled   = true
  }

  tags = {
    Name        = "${var.project_name}-waf"
    Environment = var.environment
  }
}

# CloudWatch Dashboard for WAF
resource "aws_cloudwatch_dashboard" "waf" {
  dashboard_name = "${var.project_name}-waf-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/WAFV2", "AllowedRequests", "WebACL", aws_wafv2_web_acl.main.name],
            [".", "BlockedRequests", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "WAF Requests"
          period  = 300
        }
      }
    ]
  })
}
```

## 🚀 Phase 3: CI/CD Pipeline Implementation

### Step 9: CodePipeline Configuration

```yaml
# ci-cd/buildspec.yml
version: 0.2

phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      - aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
      - REPOSITORY_URI=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME
      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
      - IMAGE_TAG=${COMMIT_HASH:=latest}

  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...

      # Security scanning
      - echo "Running security scans..."
      - npm audit --audit-level high
      - docker run --rm -v "$PWD":/app securecodewarrior/docker-image-scanner /app

      # Run tests
      - echo "Running tests..."
      - npm test
      - npm run test:security
      - npm run test:performance

      # Build application
      - docker build -t $IMAGE_REPO_NAME:$IMAGE_TAG .
      - docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG
      - docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $REPOSITORY_URI:latest

  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker images...
      - docker push $REPOSITORY_URI:$IMAGE_TAG
      - docker push $REPOSITORY_URI:latest
      - echo Writing image definitions file...
      - printf '[{"name":"app","imageUri":"%s"}]' $REPOSITORY_URI:$IMAGE_TAG > imagedefinitions.json

      # Generate security report
      - echo "Generating security report..."
      - aws s3 cp security-report.json s3://$ARTIFACTS_BUCKET/security-reports/$CODEBUILD_BUILD_ID/

artifacts:
  files:
    - imagedefinitions.json
    - infrastructure/terraform/**/*
  name: BuildArtifact
```

### Step 10: Multi-Environment Deployment

```hcl
# infrastructure/terraform/environments/production/main.tf
terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "production"
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
  account_id         = data.aws_caller_identity.current.account_id
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  project_name             = var.project_name
  environment             = "production"
  vpc_cidr                = "10.0.0.0/16"
  availability_zones      = local.availability_zones
  public_subnet_cidrs     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs    = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  database_subnet_cidrs   = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
}

# Security Module
module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  environment  = "production"
  vpc_id       = module.vpc.vpc_id
}

# RDS Module
module "rds" {
  source = "../../modules/rds"

  project_name           = var.project_name
  environment           = "production"
  vpc_id                = module.vpc.vpc_id
  database_subnet_ids   = module.vpc.database_subnet_ids
  ecs_security_group_id = module.ecs.security_group_id

  # Production configuration
  instance_class               = "db.r6g.large"
  allocated_storage           = 100
  max_allocated_storage       = 1000
  backup_retention_period     = 30
  create_read_replicas        = true
  read_replica_instance_class = "db.r6g.large"

  database_name    = var.database_name
  master_username  = var.master_username
  master_password  = var.master_password
  kms_key_id      = module.kms.key_id
}

# ElastiCache Module
module "elasticache" {
  source = "../../modules/elasticache"

  project_name        = var.project_name
  environment        = "production"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  # Production configuration
  node_type               = "cache.r6g.large"
  num_cache_clusters      = 3
  automatic_failover_enabled = true
  multi_az_enabled        = true
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
}

# Application Load Balancer
module "alb" {
  source = "../../modules/alb"

  project_name       = var.project_name
  environment       = "production"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = var.ssl_certificate_arn
}

# ECS Module
module "ecs" {
  source = "../../modules/ecs"

  project_name          = var.project_name
  environment          = "production"
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  target_group_arn     = module.alb.target_group_arn
  lb_listener          = module.alb.listener

  # Production configuration
  desired_count    = 3
  min_capacity     = 2
  max_capacity     = 20
  task_cpu         = 1024
  task_memory      = 2048
  container_port   = 3000

  ecr_repository_url = var.ecr_repository_url
  aws_region        = var.aws_region
}

# CloudFront Distribution
module "cloudfront" {
  source = "../../modules/cloudfront"

  project_name           = var.project_name
  environment           = "production"
  alb_domain_name       = module.alb.dns_name
  s3_bucket_domain_name = module.s3.bucket_domain_name
  waf_web_acl_id        = module.waf.web_acl_id
  ssl_certificate_arn   = var.cloudfront_certificate_arn
}

# Monitoring Module
module "monitoring" {
  source = "../../modules/monitoring"

  project_name = var.project_name
  environment  = "production"

  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  rds_instance_id  = module.rds.instance_id
  alb_arn_suffix   = module.alb.arn_suffix

  sns_topic_arn = var.alert_sns_topic_arn
}
```

## 📊 Phase 4: Monitoring & Observability

### Step 11: CloudWatch Monitoring

```hcl
# infrastructure/terraform/modules/monitoring/main.tf
# CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "${var.project_name}-app-logs"
    Environment = var.environment
  }
}

# Custom Metrics
resource "aws_cloudwatch_log_metric_filter" "error_rate" {
  name           = "${var.project_name}-error-rate"
  log_group_name = aws_cloudwatch_log_group.app.name
  pattern        = "[timestamp, request_id, \"ERROR\"]"

  metric_transformation {
    name      = "ErrorRate"
    namespace = "${var.project_name}/Application"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "response_time" {
  name           = "${var.project_name}-response-time"
  log_group_name = aws_cloudwatch_log_group.app.name
  pattern        = "[timestamp, request_id, \"INFO\", method, url, status_code, response_time]"

  metric_transformation {
    name      = "ResponseTime"
    namespace = "${var.project_name}/Application"
    value     = "$response_time"
  }
}

# CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ecs cpu utilization"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    ServiceName = var.ecs_service_name
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    Name        = "${var.project_name}-high-cpu-alarm"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name          = "${var.project_name}-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This metric monitors ecs memory utilization"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    ServiceName = var.ecs_service_name
    ClusterName = var.ecs_cluster_name
  }

  tags = {
    Name        = "${var.project_name}-high-memory-alarm"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "database_cpu" {
  alarm_name          = "${var.project_name}-database-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "75"
  alarm_description   = "This metric monitors RDS CPU utilization"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }

  tags = {
    Name        = "${var.project_name}-database-cpu-alarm"
    Environment = var.environment
  }
}

# X-Ray Tracing
resource "aws_xray_sampling_rule" "main" {
  rule_name      = "${var.project_name}-sampling-rule"
  priority       = 9000
  version        = 1
  reservoir_size = 1
  fixed_rate     = 0.1
  url_path       = "*"
  host           = "*"
  http_method    = "*"
  service_type   = "*"
  service_name   = "*"
  resource_arn   = "*"

  tags = {
    Name        = "${var.project_name}-xray-sampling"
    Environment = var.environment
  }
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ServiceName", var.ecs_service_name, "ClusterName", var.ecs_cluster_name],
            [".", "MemoryUtilization", ".", ".", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "ECS Service Metrics"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.rds_instance_id],
            [".", "DatabaseConnections", ".", "."],
            [".", "ReadLatency", ".", "."],
            [".", "WriteLatency", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "RDS Metrics"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn_suffix],
            [".", "TargetResponseTime", ".", "."],
            [".", "HTTPCode_Target_2XX_Count", ".", "."],
            [".", "HTTPCode_Target_4XX_Count", ".", "."],
            [".", "HTTPCode_Target_5XX_Count", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Load Balancer Metrics"
          period  = 300
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 18
        width  = 24
        height = 6

        properties = {
          query   = "SOURCE '${aws_cloudwatch_log_group.app.name}' | fields @timestamp, @message | filter @message like /ERROR/ | sort @timestamp desc | limit 100"
          region  = var.aws_region
          title   = "Recent Errors"
          view    = "table"
        }
      }
    ]
  })
}
```

## 🧪 Phase 5: Testing & Validation

### Step 12: Infrastructure Testing

```bash
/test-gen --infrastructure terraform --framework terratest --type unit,integration --scenarios deployment,security,performance,disaster-recovery

@test-engineer Create comprehensive infrastructure tests including:
- Terraform plan validation
- Security group rule testing
- Load balancer health checks
- Database connectivity tests
- Auto-scaling behavior validation
- Backup and restore procedures
- Disaster recovery testing
- Performance benchmarking
- Cost optimization validation
```

### Step 13: Generated Infrastructure Tests

```go
// tests/infrastructure/vpc_test.go
package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVPCInfrastructure(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../infrastructure/terraform/modules/vpc",
		Vars: map[string]interface{}{
			"project_name":             "test-project",
			"environment":              "test",
			"vpc_cidr":                 "10.0.0.0/16",
			"availability_zones":       []string{"us-east-1a", "us-east-1b", "us-east-1c"},
			"public_subnet_cidrs":      []string{"10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"},
			"private_subnet_cidrs":     []string{"10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"},
			"database_subnet_cidrs":    []string{"10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"},
		},
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Validate VPC creation
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotEmpty(t, vpcId)

	// Validate subnets
	publicSubnetIds := terraform.OutputList(t, terraformOptions, "public_subnet_ids")
	assert.Len(t, publicSubnetIds, 3)

	privateSubnetIds := terraform.OutputList(t, terraformOptions, "private_subnet_ids")
	assert.Len(t, privateSubnetIds, 3)

	databaseSubnetIds := terraform.OutputList(t, terraformOptions, "database_subnet_ids")
	assert.Len(t, databaseSubnetIds, 3)

	// Validate NAT gateways
	natGatewayIds := terraform.OutputList(t, terraformOptions, "nat_gateway_ids")
	assert.Len(t, natGatewayIds, 3)
}

func TestSecurityGroups(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../infrastructure/terraform/modules/security",
		Vars: map[string]interface{}{
			"project_name": "test-project",
			"environment":  "test",
			"vpc_id":       "vpc-12345678",
		},
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Validate ALB security group
	albSecurityGroupId := terraform.Output(t, terraformOptions, "alb_security_group_id")
	assert.NotEmpty(t, albSecurityGroupId)

	// Validate ECS security group
	ecsSecurityGroupId := terraform.Output(t, terraformOptions, "ecs_security_group_id")
	assert.NotEmpty(t, ecsSecurityGroupId)

	// Validate RDS security group
	rdsSecurityGroupId := terraform.Output(t, terraformOptions, "rds_security_group_id")
	assert.NotEmpty(t, rdsSecurityGroupId)
}
```

### Step 14: Performance Testing

```bash
@performance-tuner Design AWS infrastructure performance tests:
- Load testing for ECS auto-scaling
- Database performance under load
- CDN cache hit ratio optimization
- Network latency measurements
- Cost-performance optimization
- Resource utilization analysis
- Scaling behavior validation
- Disaster recovery time testing
```

## 📚 Phase 6: Documentation & Best Practices

### Step 15: Comprehensive Documentation

```bash
/docs-gen aws-deployment --format comprehensive --include architecture-guide,deployment-guide,security-guide,monitoring-guide,troubleshooting

@docs-writer Create complete AWS deployment documentation including:
- Architecture overview and design decisions
- Step-by-step deployment instructions
- Environment configuration guide
- Security best practices and compliance
- Monitoring and alerting setup
- Disaster recovery procedures
- Cost optimization strategies
- Troubleshooting common issues
- Scaling and performance tuning
- Migration guides and rollback procedures
```

## 🎯 Best Practices Implemented

### Architecture
- **Well-Architected Framework**: Following all 6 pillars
- **Multi-AZ Deployment**: High availability across zones
- **Auto Scaling**: Responsive to load changes
- **Microservices Ready**: Container-based architecture
- **Infrastructure as Code**: Version-controlled infrastructure

### Security
- **Defense in Depth**: Multiple security layers
- **Least Privilege**: Minimal required permissions
- **Encryption**: At rest and in transit
- **Network Segmentation**: Isolated subnets and security groups
- **Compliance**: SOC 2, PCI DSS, GDPR ready

### Performance
- **CDN Integration**: Global content delivery
- **Caching Strategy**: Multi-layer caching
- **Database Optimization**: Read replicas and indexing
- **Container Optimization**: Right-sized resources
- **Load Balancing**: Efficient traffic distribution

### Cost Optimization
- **Right Sizing**: Appropriate instance types
- **Auto Scaling**: Scale down during low usage
- **Reserved Instances**: Cost savings for predictable workloads
- **Spot Instances**: Cost-effective for non-critical workloads
- **Cost Monitoring**: Real-time cost tracking

### Reliability
- **High Availability**: 99.99% uptime target
- **Disaster Recovery**: Multi-region backup
- **Health Checks**: Proactive monitoring
- **Auto Recovery**: Self-healing infrastructure
- **Backup Strategy**: Regular automated backups

## 📈 Success Metrics

### Performance Metrics
- **Response Time**: <100ms for 95% of requests
- **Availability**: 99.99% uptime
- **Throughput**: 10,000+ requests per second
- **Scale Time**: <5 minutes to double capacity

### Security Metrics
- **Zero Breaches**: No security incidents
- **Compliance Score**: 100% compliance rating
- **Vulnerability Response**: <24 hours to patch
- **Audit Trail**: 100% event logging

### Cost Metrics
- **Cost Optimization**: 30% reduction vs traditional hosting
- **Resource Utilization**: >80% average utilization
- **Scaling Efficiency**: 50% cost savings during low traffic
- **ROI**: 200% return on cloud investment

This comprehensive AWS deployment integration demonstrates enterprise-grade cloud architecture using Claude Code Tresor utilities for maximum automation, security, and scalability.