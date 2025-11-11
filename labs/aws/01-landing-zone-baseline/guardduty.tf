resource "aws_guardduty_detector" "this" {
  enable = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    owner      = "Olagoldstx"
    env        = "lab"
    system     = "securethecloud"
    data_class = "audit"
  }
}
