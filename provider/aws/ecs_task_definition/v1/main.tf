resource "aws_ecs_task_definition" "main" {
  family                   = var.family
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  cpu                      = var.cpu
  memory                   = var.memory
	execution_role_arn			 = var.execution_role_arn
	task_role_arn						 = var.task_role_arn
  container_definitions    = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      essential = var.container_essential
      portMappings = [
        {
          containerPort = var.container_containerPort
          hostPort      = var.container_hostPort
        }
      ]
			logConfiguration = var.logConfiguration
    }
  ])

  runtime_platform {
    operating_system_family = var.operating_system_family
    cpu_architecture        = var.cpu_architecture
  }

	tags = "${var.tags}"
}

resource "aws_cloudwatch_log_group" "main" {
  count = var.logConfiguration != null ? 1 : 0
  name = var.container_name
}

resource "aws_cloudwatch_log_stream" "main" {
  count = var.logConfiguration != null ? 1 : 0
  name           = var.container_name
  log_group_name = aws_cloudwatch_log_group.main[0].name
}