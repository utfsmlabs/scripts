from fabric import task, run, put, parallel

@task
@parallel
def ejecutar(com):
  run(com)

@task
@parallel
def copiar(archivo, destino):
  put(archivo, destino)