from fabric.api import *
from fabric.exceptions import NetworkError
from scripts.helper import add_post_run_hook

# listas que guardan los resultados de ejecucion
success = []
failed = []

# autoexplicativa...
def results():
  print "Ejecucion finalizada"
  print "Fallidos: " + str(failed)
  print "Exitosos: " + str(success)
  del success[:]
  del failed[:]

# @task define que la funcion que sigue es una tarea de fabric
# @add_post_run_hook ejecuta la funcion una vez finalizada la misma
@task
@add_post_run_hook(results)
def ejecutar(com):
  with hide("debug"):
    try:
      run(com)
    except NetworkError:
      failed.append(env.host)
    else:
      success.append(env.host)

@task
@add_post_run_hook(results)
def copiar(archivo, destino):
  with hide("debug"):
    try:
      put(archivo, destino)
    except NetworkError:
      failed.append(env.host)
    else:
      success.append(env.host)