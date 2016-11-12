#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: LookBack
# Email: admin#dwhd.org
# Version:
# Created Time: 2016年11月08日 星期二 23时08分12秒
#########################################################################

set -e
[[ $DEBUG == true ]] && set -x
ACTIVEMQ_ENV=/opt/activemq/bin/env

if [ "$1" = 'activemq' -a "$(id -u)" = '0' ]; then
	if [[ -d /opt/activemq/data ]] || [[ "`ls -ld data|awk '{print $3,$4}'`" == "activemq activemq" ]];then
		{ chown -R activemq.activemq data; } || { echo >&2 "Can't change 'data' directory permissions" && exit 1; }
	fi
	exec su-exec activemq "$0" "$@"
fi

[[ -n ${ACTIVEMQ_OPTS_MEMORY} ]] && sed -ri "s/^(ACTIVEMQ_OPTS_MEMORY=).*/\1\"${ACTIVEMQ_OPTS_MEMORY}\"/" ${ACTIVEMQ_ENV}

exec "$@"
