locals {
  python3_pip = !local.parts_active.python3_pip ? {} : {
    runcmd = concat(
      [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
          vars = {
            packages = join(" ", ["python3-pip"]),
          }
        },
      ],
      [
        for python3_pip_module in local.python3_pip_modules :
        {
          template = "${path.module}/templates/python3-pip/${local.yml_runcmd}_install_module.tpl",
          vars = {
            python3_pip_module = python3_pip_module,
          }
        }
      ]
    ),
  }
}
