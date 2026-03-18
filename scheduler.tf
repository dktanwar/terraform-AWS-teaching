############################################
# AWS EventBridge Scheduler - EC2 start/stop
# Automatically uses instance ID from aws_instance.train
############################################

############################################
# Start EC2 - Tuesday 11:23 Europe/Zurich
############################################
resource "aws_scheduler_schedule" "start_ec2_tuesday" {
  name                       = "start-ec2-tue-1030"
  description                = "Start training instance Tuesday 11:45 CET"
  state                      = "ENABLED"

  schedule_expression        = "cron(59 11 ? * TUE *)"
  schedule_expression_timezone = "Europe/Zurich"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = "arn:aws:iam::412296094200:role/ec2-scheduler-role"

    input = jsonencode({
      InstanceIds = [aws_instance.train.id]
    })

    retry_policy {
      maximum_event_age_in_seconds = 3600   # 1 hour
      maximum_retry_attempts       = 3
    }
  }
}

############################################
# Stop EC2 - Tuesday 11:30 Europe/Zurich
############################################
resource "aws_scheduler_schedule" "stop_ec2_tuesday" {
  name                       = "stop-ec2-tue-1035"
  description                = "Stop training instance Tuesday 11:30 CET"
  state                      = "ENABLED"

  schedule_expression        = "cron(02 12 ? * TUE *)"
  schedule_expression_timezone = "Europe/Zurich"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = "arn:aws:iam::412296094200:role/ec2-scheduler-role"

    input = jsonencode({
      InstanceIds = [aws_instance.train.id]
    })

    retry_policy {
      maximum_event_age_in_seconds = 3600   # 1 hour
      maximum_retry_attempts       = 3
    }
  }
}
