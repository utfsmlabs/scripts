from fabric.api import *
from scripts.helper import *

@task
@parallel
def reiniciar():
  if _is_host_up(env.host, int(env.port)) is True:
    reboot()