# baseimage-logentries

Configures baseimage's syslog-ng to send log messages to Logentries.com, to the log associated with your token.

If you don't know about [baseimage-docker](https://github.com/phusion/baseimage-docker) you should [read about it](http://phusion.github.io/baseimage-docker/).

## Use

Set an environment variable `LOGENTRIES_TOKEN` on your container when you `docker run`, that's it.

To see it in work, create a new logentries token and put it in the following command in place of the 000s:

```bash
> docker run --rm -i -t -e "LOGENTRIES_TOKEN=00000000-0000-0000-0000-000000000000" flitbit/baseimage-logentries /sbin/my_init -- /bin/bash
```

The baseimage will initialize ubuntu and after a moment place you at a bash shell inside the container, use logger to send some log test messages and see that they arrive in your log at Logentries:

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

