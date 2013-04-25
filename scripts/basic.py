from fabric.api import *
from scripts import helper

@task
@parallel
def ejecutar(com):
  try:
    run(com)
  except NetworkException:
    print "No se pudo conectar"

@task
@parallel
def copiar(archivo, destino):
  put(archivo, destino)