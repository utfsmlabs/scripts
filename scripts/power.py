from fabric.api import *
from scripts import helper

@task
@parallel
@helper.ignore_offline
def reiniciar():
  reboot()