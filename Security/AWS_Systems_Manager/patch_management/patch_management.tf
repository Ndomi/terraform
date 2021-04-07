resource "aws_ssm_patch_baseline" "production" {
  name = "patch-baseline"
  operating_system = "AMAZON_LINUX"
  description = "Patch AMAZON linux"

  approval_rule {
    approve_after_days = 3
    patch_filter {
      key = "CLASSIFICATION"
      values = ["Security"]
    }
    compliance_level = "CRITICAL"
    enable_non_security = false
  }

  approval_rule {
    approve_after_days = 5
    patch_filter {
      key = "CLASSIFICATION"
      values = ["Security"]
    }
    compliance_level = "MEDIUM"
    enable_non_security = false
  }

  approval_rule {
    approve_after_days = 10
    patch_filter {
      key = "PRODUCT"
      values = ["AmazonLinux2017.09"]
    }
    compliance_level = "UNSPECIFIED"
    enable_non_security = true
  }

  rejected_patches = ["Kernel"]

  tags = {
    Name = "Patch Management"
  }
}