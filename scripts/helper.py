import paramiko
import socket

def _is_host_up(host, port):
    # Set the timeout
    original_timeout = socket.getdefaulttimeout()
    new_timeout = 1
    socket.setdefaulttimeout(new_timeout)
    host_status = False
    try:
        transport = paramiko.Transport((host, port))
        host_status = True
    except:
        print('***Warning*** Host {host} on port {port} is down.'.format(
            host=host, port=port)
        )
    socket.setdefaulttimeout(original_timeout)
    return host_status