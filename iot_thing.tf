resource "random_id" "id" {
	byte_length = 8
}

resource "aws_iot_thing" "thing" {
	name = "thing_${random_id.id.hex}"
}

output "thing_name" {
	value = aws_iot_thing.thing.name
}
