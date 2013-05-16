from fabric.api import *
from fabric.exceptions import NetworkError
from scripts.helper import add_post_run_hook

success = []
failed = []

@task
@add_post_run_hook(results)
def ejecutar(com):
  try:
    run(com)
  except NetworkError:
    failed.append(env.host)
  else:
    success.append(env.host)

@task
def copiar(archivo, destino):
  put(archivo, destino)

def results():
  print "Ejecucion finalizada"
  print "Fallidos: " + str(failed)
  print "Exitosos: " + str(success)