#!/bin/bash
if [ "`docker ps -a -q -f status=exited | wc -l`" -gt "0" ] ; then
	docker rm -v $(docker ps -a -q -f status=exited)
fi

if [ "`docker ps -q --format "{{.ID}}\t{{.Status}} ago" | grep 'hours\|weeks\|months ago' | wc -l`" -gt "0" ] ; then
  docker rm -f $(docker ps --format "{{.ID}}\t{{.Status}} ago" | grep 'hours\|weeks\|months ago' | awk '{print $1'})
fi

if [ "`docker images -f dangling=true -q | wc -l`" -gt "0" ] ; then
	docker rmi $(docker images -f dangling=true -q)
fi

if [ "`docker images --format "{{.Repository}}:{{.Tag}}\t{{.CreatedSince}} ago" | grep 'days\|weeks\|months ago' | awk '{print $1'} | grep 'registry.securityscorecard.io' | wc -l`" -gt "0" ] ; then
	docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}\t{{.CreatedSince}} ago" | grep 'days\|weeks\|months ago' | awk '{print $1'} | grep 'registry.securityscorecard.io')
fi

if [ "`docker volume ls -qf dangling=true | wc -l`" -gt "0" ] ; then
	docker volume rm $(docker volume ls -qf dangling=true)
fi
