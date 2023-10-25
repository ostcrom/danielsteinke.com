PY?=python3
PELICAN?=pelican
PELICANOPTS=

OUTPUTDIRNAME=www
BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/$(OUTPUTDIRNAME)
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py
SECRETS_ENV=$(DS_SECRETS)


DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

RELATIVE ?= 0
ifeq ($(RELATIVE), 1)
	PELICANOPTS += --relative-urls
endif

help:
	@echo 'Makefile for a pelican Web site                                           '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make docker-base                   Generate Docker container requesites'
	@echo '   make docker-build          Updates docker container with latest content'
	@echo '   make docker-html      User docker build image to render content to HTML'
	@echo '   make docker-publish             Uses Docker to upload generated content'
	@echo '   make deploy                      Calls python script to upload website,' 
	@echo '                                   requires secrets to be loaded into ENV.'
	@echo '   make html                           (re)generate the web site          '
	@echo '   make clean                          remove the generated files         '
	@echo '   make regenerate                     regenerate files upon modification '
	@echo '   make publish                        generate using production settings '
	@echo '   make serve [PORT=8000]              serve site at http://localhost:8000'
	@echo '   make serve-global [SERVER=0.0.0.0]  serve (as root) to $(SERVER):80    '
	@echo '   make devserver [PORT=8000]          serve and regenerate together      '
	@echo '   make ssh_upload                     upload the web site via SSH        '
	@echo '   make rsync_upload                   upload the web site via rsync+ssh  '
	@echo '                                                                          '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html   '
	@echo 'Set the RELATIVE variable to 1 to enable relative urls                    '
	@echo '                                                                          '

init-base:
	docker build --no-cache -t danielsteinke/dscom-base docker-base/.

init-build:
	docker build --no-cache -t danielsteinke/dscom-build docker-build/.
init-publish:
	docker build --no-cache -t daniesteinke/dscom-publish docker-publish/.

docker-html:
	docker run -v $(OUTPUTDIR):/code/danielsteinke.com/$(OUTPUTDIRNAME) danielsteinke/dscom-build make html

docker-dns-sync:
	docker run danielsteinke/dscom-base make dns-sync GD_API_KEY=$(GD_API_KEY) GD_API_SECRET=$(GD_API_SECRET) \
		GD_SHOPPER_ID=$(GD_SHOPPER_ID) TARGET_DOMAIN=$(TARGET_DOMAIN) NS_DATA=$(NS_DATA)

docker-serve:
	docker run -p 8080:8080 -v $(OUTPUTDIR):/code/danielsteinke.com/$(OUTPUTDIRNAME) danielsteinke/dscom-build pelican -lr content -o $(OUTPUTDIRNAME) -p 8080 -b 0.0.0
docker-serve-d:
	docker run -d -p 8080:8080 -v $(OUTPUTDIR):/code/danielsteinke.com/$(OUTPUTDIRNAME) danielsteinke/dscom-build pelican -lr content -o $(OUTPUTDIRNAME) -p 8080 -b 0.0.0

html:
	rm -rf $(OUTPUTDIR)/*
	ls -lhar $(INPUTDIR)
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
	chmod o+rwx -R $(OUTPUTDIR)/*
	
dns-sync:
	python dns-sync.py $(GD_API_KEY) $(GD_API_SECRET) $(GD_SHOPPER_ID) $(TARGET_DOMAIN) $(NS_DATA)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

regenerate:
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve:
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIRNAME) -p 8080 -b 0.0.0.0


devserver:
ifdef PORT
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)


.PHONY: html help clean regenerate serve serve-global devserver publish 
