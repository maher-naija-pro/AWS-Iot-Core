resource "aws_iot_topic_rule" "rule" {
  name        = "MyRule"
  description = "Example rule"
  enabled     = true
  sql         = "SELECT * FROM 'sdk/test/python'"
  sql_version = "2016-03-23"

  kinesis {
    stream_name= aws_kinesis_stream.test_stream.name
    role_arn=aws_iam_role.iot.arn
  }

}
