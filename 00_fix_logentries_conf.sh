#!/bin/sh

if [ ! -z "${LOGENTRIES_TOKEN}" ]; then
	destination=/etc/syslog-ng/conf.d/logentries.conf
	template=/var/logentries/logentries-conf-template
	template_line="`cat /var/logentries/logentries-message-template`"

	t=$(tempfile)
	sed "s/LOGENTRIES_TOKEN/${LOGENTRIES_TOKEN}/g" $template >> $t

	line=LOGENTRIES_TEMPLATE
	sed -i.bak "s/LOGENTRIES_TEMPLATE/${template_line}/g" $t

	if [ -f $destination ]; then
		lsha=$(openssl sha1 $t | awk '{print $2}')
		rsha=$(openssl sha1 $destination | awk '{print $2}')
		if [ $lsha == $rsha ]; then
			exit 0
		fi
		rm -f $destination
	fi
	mv $t $destination
	# failure above could leave this file hanging around.
	rm -f ${t}.bak
fi
