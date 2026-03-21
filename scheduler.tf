############################################
# AWS EventBridge Scheduler - EC2 + Docker
# Timezone: Europe/Zurich
############################################

############################################
# START EC2 - Weekdays (08:00)
############################################
resource "aws_scheduler_schedule" "start_ec2_weekdays" {
  name = "start-ec2-weekdays-0800"

  schedule_expression          = "cron(00 8 ? * MON-FRI *)"
  schedule_expression_timezone = "Europe/Zurich"

  flexible_time_window { mode = "OFF" }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = "arn:aws:iam::412296094200:role/ec2-scheduler-role"

    input = jsonencode({
      InstanceIds = [aws_instance.train.id]
    })
  }
}

############################################
# START EC2 - Saturday (08:00)
############################################
resource "aws_scheduler_schedule" "start_ec2_sat" {
  name = "start-ec2-sat-0800"

  schedule_expression          = "cron(0 8 ? * SAT *)"
  schedule_expression_timezone = "Europe/Zurich"

  flexible_time_window { mode = "OFF" }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = "arn:aws:iam::412296094200:role/ec2-scheduler-role"

    input = jsonencode({
      InstanceIds = [aws_instance.train.id]
    })
  }
}


############################################
# STOP EC2 - Weekdays (19:00)
############################################
resource "aws_scheduler_schedule" "stop_ec2_weekdays" {
  name = "stop-ec2-weekdays-1900"

  schedule_expression          = "cron(0 19 ? * MON-FRI *)"
  schedule_expression_timezone = "Europe/Zurich"

  flexible_time_window { mode = "OFF" }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = "arn:aws:iam::412296094200:role/ec2-scheduler-role"

    input = jsonencode({
      InstanceIds = [aws_instance.train.id]
    })
  }
}

############################################
# STOP EC2 - Saturday (10:00)
############################################
resource "aws_scheduler_schedule" "stop_ec2_sat" {
  name = "stop-ec2-sat-1000"

  schedule_expression          = "cron(0 12 ? * SAT *)"
  schedule_expression_timezone = "Europe/Zurich"

  flexible_time_window { mode = "OFF" }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = "arn:aws:iam::412296094200:role/ec2-scheduler-role"

    input = jsonencode({
      InstanceIds = [aws_instance.train.id]
    })
  }
}
