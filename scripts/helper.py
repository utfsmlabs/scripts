import paramiko
import socket

def ignore_offline(fn):
    original_timeout = getdefaulttimeout()
    setdefaulttimeout(3)
    try:
        Transport((env.host, int(env.port)))
        return fn()
    except:
        print "The following host appears to be offline: " + env.host
    setdefaulttimeout(original_timeout)
    return wrapped