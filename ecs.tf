resource "aws_ecs_cluster" "rails2-cluster" {
  name = "rails2-cluster"
}

resource "aws_ecs_service" "rails2-service" {
  name            = "rails2-service"
  cluster         = aws_ecs_cluster.rails2-cluster.id
  task_definition = aws_ecs_task_definition.rails2-task.arn
  desired_count   = 1
  launch_type     = "EC2"
}

resource "aws_ecs_task_definition" "rails2-task" {
  family                = "rails2-task"
  container_definitions = file("./container_definitions/service.json")
  task_role_arn         = module.ecs_task_role.iam_role_arn
  network_mode          = "bridge"
}
