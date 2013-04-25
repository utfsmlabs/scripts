from fabric.api import *
from fabric.exceptions import NetworkError
from scripts import helper

@task
@parallel
def ejecutar(com):
  success = []
  failed  = []

  with hide('everything'):
    try:
      run(com)
    except NetworkError:
      failed.append(env.host)
    else:
      success.append(env.host)
    finally:
      helper._output_status(failed, success)


@task
@parallel
def copiar(archivo, destino):
  put(archivo, destino)