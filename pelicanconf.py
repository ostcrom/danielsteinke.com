#!/usr/bin/env python
# -*- coding: utf-8 -*- #

from __future__ import unicode_literals
import os
import subprocess
AUTHOR = 'Dan Steinke'
SITENAME = 'DanielSteinke.com'
SITEURL = 'www.danielsteinke.com'

PATH = os.path.abspath('content')
THEME = os.path.abspath('theme')

TIMEZONE = 'America/Chicago'

DEFAULT_LANG = 'en'
DEFAULT_DATE_FORMAT = '%a %d %B %Y'
DEFAULT_DATE = "fs"
# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (('home', '/index.html'),
        ('about', '/pages/about.html'),
        ('posts', '/categories.html'))

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = 5

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True


COMMITHASH = subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").rstrip()
print(f"COMMITHASH: {COMMITHASH}")
