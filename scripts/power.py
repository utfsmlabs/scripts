from fabric.api import *
from scripts import helper
from scripts.helper import add_post_run_hook

success = []
failed = []

def results():
  print "Ejecucion finalizada"

  f = ""
  s = ""
  for fail in failed:
    f += fail + " "
  for exito in success:
    s += exito + " "

  print "Fallidos: "
  print f
  print "Exitosos: "
  print s
  
  del success[:]
  del failed[:]

@task
@add_post_run_hook(results)
def reiniciar():
  with hide("debug"):
    try:
      reboot()
    except NetworkError:
      failed.append(env.host)
    else:
      success.append(env.host)