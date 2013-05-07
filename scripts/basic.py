from fabric.api import *
from fabric.exceptions import NetworkError
from scripts import helper

@task
def ejecutar(com):
  with hide('commands'):
    try:
      run(com)
    except NetworkError:
      failed.append(env.host)
    else:
      success.append(env.host)

@task
def copiar(archivo, destino):
  put(archivo, destino)