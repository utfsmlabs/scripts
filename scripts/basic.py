from fabric.api import *
from scripts import helper

@task
def ejecutar(com):
  if helper._is_host_up(env.host, int(env.port)) is True:
    run(com)

@task
def copiar(archivo, destino):
  if helper._is_host_up(env.host, int(env.port)) is True:
    put(archivo, destino)