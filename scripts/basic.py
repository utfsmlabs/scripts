from fabric.api import *
from scripts.helper import *

@task
def ejecutar(com):
  if _is_host_up(env.host, int(env.port)) is True:
    run(com)

@task
def copiar(archivo, destino):
  if _is_host_up(env.host, int(env.port)) is True:
    put(archivo, destino)