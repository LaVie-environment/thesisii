output "ack-env_private_ip" {
    value = aws_instance.ack-env.private_ip
}

output "ack-env_public_ipv4" {
    value = aws_instance.ack-env.public_ip
}

output "ack-env_id" {
    value = aws_instance.ack-env.id
}