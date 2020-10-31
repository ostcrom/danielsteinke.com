#!/bin/bash -e
read -p "Commit message: " COMMSG
git add . &&\
	git add -u && \
	git commit -m "$COMMSG" && \
	git push origin master

COMMITHASH=$(git rev-parse HEAD)
./deploy.sh

##Sleep for a bit to allow cache to clear...

sleep 30
##Check if our current commit hash is on
if $(curl https://danielsteinke.com/index.html | grep $COMMITHASH); then
	echo Publish successfull!
else
	echo Something went wrong, new commit hash not present.