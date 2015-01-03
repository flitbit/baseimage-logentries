# baseimage-logentries

Docker image that configures [baseimage](https://github.com/phusion/baseimage-docker)'s syslog-ng to send log messages to Logentries.com.

If you don't already know how [baseimage](https://github.com/phusion/baseimage-docker) _fixes_ Ubuntu for Docker you should [read about it](http://phusion.github.io/baseimage-docker/).

## Use

To use this image you'll need to already have a log set up on [LogEntries.com for Token-based Logging](https://logentries.com/doc/syslog-ng/).

Set an environment variable `LOGENTRIES_TOKEN` on your container when you `docker run`, that's it.

To see it in work, launch a container from this image using the following command (replace the invalid GUID with your LogEntries token):

```bash
> docker run --rm -i -t -e "LOGENTRIES_TOKEN=00000000-0000-0000-0000-000000000000" flitbit/baseimage-logentries /sbin/my_init -- /bin/bash
```

The baseimage will initialize Ubuntu and after a moment place you at a bash shell inside the container, use logger to send some test messages and see that they arrive in your log at Logentries:

```bash
> logger -t test -p info Hello there Logentries
> logger -t test -p info Everything is ready on my end
```

### As a Base Image

To base your image on `baseimage-logentries` simply use it in your Dockerfile's FROM line:

```
FROM flitbit/baseimage-logentries:<VERSION>

# ... any other Dockerfile instructions
```

### Customizing the syslog-ng Template

The default template should serve most needs; it translates to a syslog-ng config of:

```
template("`LOGENTRIES_TOKEN` $ISODATE $HOST $FACILITY $PRIORITY $MSG\n")
```

Take a look at [`logentries-message-template`](https://github.com/flitbit/baseimage-logentries/blob/master/logentries-message-template) and [`logentries-conf-template`](https://github.com/flitbit/baseimage-logentries/blob/master/logentries-conf-template) to see the simplistic way the template gets built.

Basically, the contents of `logentries-message-template` becomes the template line that determines how messages look to LogEntries.

You can override the `logentries-message-template` in your derived container by supplying your own _logentries-message-template_ file to overwrite the default:

```
FROM flitbit/baseimage-logentries:<VERSION>

ADD logentries-message-template /var/logentries/logentries-message-template

# ... any other Dockerfile instructions
```

## Feedback

Hopefully you find this image useful.

If you find issues [post it here](https://github.com/flitbit/baseimage-logentries/issues)  -- we also welcome pull requests.
