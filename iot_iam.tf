resource "aws_iam_role" "iot" {
  name = format(
        "iot-role",
      )
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { "Service" = "iot.amazonaws.com" }
   }]
  })


}

resource "aws_iam_role_policy_attachment" "iot-attach" {
  role       = aws_iam_role.iot.name
  policy_arn = aws_iam_policy.iot_policy.arn
}

resource "aws_iam_policy" "iot_policy" {

   name =format(
        "iot-iam-policy",
      )

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
   {

            "Effect": "Allow",
            "Action": [
                "kinesis:*"
            ],
            "Resource": [
                "*"
            ]
 }
   ]
}
EOF
}
