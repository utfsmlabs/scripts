from fabric.api import *
from scripts import helper

@task
@parallel
def reiniciar():
  if helper._is_host_up(env.host, int(env.port)) is True:
    reboot()