resource "aws_kinesis_stream" "test_stream" {
  name             = "terraform-kinesis-test"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = {
    Environment = "test"
  }
}


resource "aws_kinesis_stream_consumer" "example" {
  name       = "example-consumer"
  stream_arn = aws_kinesis_stream.test_stream.arn
}
