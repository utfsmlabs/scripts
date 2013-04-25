from fabric.api import *
from scripts import helper

@task
@parallel
def reiniciar():
  reboot()