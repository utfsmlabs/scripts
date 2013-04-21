from fabric.api import *
from scripts.helper import *

@task
@parallel
def reiniciar():
  if helper._is_host_up(env.host, int(env.port)) is True:
    reboot()