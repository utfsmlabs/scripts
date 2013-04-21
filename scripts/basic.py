from fabric.api import *

@task
def ejecutar(com):
  run(com)

@task
def copiar(archivo, destino):
  put(archivo, destino)