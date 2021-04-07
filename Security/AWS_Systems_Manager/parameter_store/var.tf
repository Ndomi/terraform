variable "secret_type" {
  default = "SecureString"
}

variable "db_instance" {
  default = "db.t2.micro"
}

variable "allocation" {
  type = number
  default = 10
}

variable "storage_type" {
  default = "gp2"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7.16"
}

variable "db_parameter" {
  default = "password"
}