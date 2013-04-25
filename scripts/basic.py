from fabric.api import *
from scripts import helper

@task
@parallel
#@helper.ignore_offline
def ejecutar(com):
  run(com)

@task
@parallel
#@helper.ignore_offline
def copiar(archivo, destino):
  put(archivo, destino)