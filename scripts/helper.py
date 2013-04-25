import paramiko
import socket
from fabric.api import *

def ignore_offline(fn):
    original_timeout = socket.getdefaulttimeout()
    socket.setdefaulttimeout(3)
    try:
        paramiko.Transport((env.host, int(env.port)))
        return fn()
    except:
        print "The following host appears to be offline: " + env.host
    socket.setdefaulttimeout(original_timeout)
    return wrapped