/*  This is for testing parameter store.
    In the real world, a DB instance belonds to a private subnet.
*/

resource "aws_db_instance" "test_db" {
  instance_class       = var.db_instance
  allocated_storage    = var.allocation
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  name                 = "mydb"
  username             = "test"
  password             = var.db_parameter
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}