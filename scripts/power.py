from fabric import *

@task
@parallel
def reiniciar():
  reboot()