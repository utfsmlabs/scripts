from fabric.api import env
from scripts.basic import *
from scripts.power import *

# creamos las categorias de hosts
core2 = []
with open('pcs/core2', 'r') as f:
  for line in f:
    core2.append(line)

i5 = []
with open('pcs/i5', 'r') as f:
  for line in f:
    i5.append(line)

lds = []
with open('pcs/lds', 'r') as f:
  for line in f:
    lds.append(line)

# ahora podemos ejecutar tareas en:
# los pcs core2, i5 y en los labs lpa y lds

env.roledefs = {
  'core2': core2,
  'i5': i5,
  'lpa': core2 + i5,
  'lds': lds
}

# seteamos para usar ssh-agent (ejecutar ssh-add antes!)
env.forward_agent = True

# seteamos user para ejecutar
env.user = 'root'

# seteamos timeouts para servidores
env.connection_attempts = 1
env.timeout = 3

# seteamos saltarse los hosts que no responden, para no tirar errores
env.skip_bad_hosts = True