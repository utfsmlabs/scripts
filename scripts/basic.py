from fabric.api import *
from fabric.exceptions import NetworkError
from scripts import helper

@task
@parallel
def ejecutar(com):
  success = []
  failed  = []

  with hide('commands'):
    try:
      run(com)
    except NetworkError:
      failed.append(env.host)
    else:
      success.append(env.host)
  
  helper._output_status(failed, success)


@task
@parallel
def copiar(archivo, destino):
  put(archivo, destino)