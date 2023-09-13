locals {
  comment = ["## ${var.part}"]

  write_files = length(var.write_files) == 0 ? "" : join(
    "\n",
    local.comment,
    [
      for write_files in var.write_files :
      templatefile(
        write_files.template,
        {
          for var, value in write_files.vars : var => value
        }
      )
    ]
  )

  users = length(var.users) == 0 ? "" : join(
    "\n",
    local.comment,
    [
      for users in var.users :
      templatefile(
        users.template,
        {
          for var, value in users.vars : var => value
        }
      )
    ]
  )

  rundcmd = length(var.runcmd) == 0 ? "" : join(
    "\n",
    local.comment,
    [
      for runcmd in var.runcmd :
      templatefile(
        runcmd.template,
        {
          for var, value in runcmd.vars : var => value
        }
      )
    ]
  )

  packages = length(var.packages) == 0 ? "" : join(
    "\n",
    local.comment,
    [
      for packages in var.packages :
      templatefile(
        packages.template,
        {
          for var, value in packages.vars : var => value
        }
      )
    ]
  )
}
