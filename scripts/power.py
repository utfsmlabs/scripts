from fabric import task, parallel, reboot

@task
@parallel
def reiniciar():
  reboot()