from fabric.api import *
from fabric.exceptions import NetworkError
from scripts import helper

@task
@parallel
def ejecutar(com):
  try:
    run(com)
  except NetworkError:
    print "No se pudo conectar"

@task
@parallel
def copiar(archivo, destino):
  put(archivo, destino)