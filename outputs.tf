output "webpagetest-server-public-ip" {
  value = aws_instance.webpagetest-server.public_ip
}
output "webpageest-agent-public-ip" {
  value = aws_instance.webpagetest-agent.public_ip
}
resource "local_file" "ansible_inventory_hosts" {
    content = templatefile("inventory.template",
    {
        webpagetest_server              = aws_instance.webpagetest-server.public_dns,
        webpagetest_agent               = aws_instance.webpagetest-agent.public_dns,
    })
    filename = "inventory"
}
resource "local_file" "ansible_vars" {
    content = templatefile("vars.template",
    {
        webpagetest_server_private_ip   = aws_instance.webpagetest-server.private_ip,
    })
    filename = "vars.yml"
}
resource "aws_s3_bucket_object" "inventry_object" {
    depends_on  = [
      local_file.ansible_inventory_hosts,
    ]
    bucket      = var.bucket
    key         = "ansible/inventory"
    source      = "inventory"
}
resource "aws_s3_bucket_object" "vars_object" {
    depends_on  = [
      local_file.ansible_vars,
    ]
    bucket      = var.bucket
    key         = "ansible/vars.yml"
    source      = "vars.yml"
}