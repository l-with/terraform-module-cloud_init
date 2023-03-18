locals {
  comment = ["# ${var.part}"]

  packages = join(
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
  write_files = join(
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
  rundcmd = join(
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
}
