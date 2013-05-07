from fabric.api import *
from scripts import helper

@task
def reiniciar():
  reboot()