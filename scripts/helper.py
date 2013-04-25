from fabric.state import default_channel

def ignore_offline(fn):
    def wrapped(*args, **kwargs):
        try:
            default_channel()
        except:
            print "Host offline"
            return
        return fn(*args, **kwargs)
    wrapped.__name__ = fn.__name__
    wrapped.__doc__ = fn.__doc__
    return wrapped