title: How this site is created and published - Part 1
summary: Website Publishing Automation with Gitp and Python; deployed on object storage and CDN.
status: draft
category: Projects
slug: projects/website-automation2
author: dsteinke

- I originally created this website about five years ago, mostly as a technical exercise. 
- I have wanted to write an article/tutorial on it ever since to talk about how this site is craeted. 


- I originally hosted this site on a CDN that was run by a company i workted at briefly.
- They recently jacked their rates way up so I'm migrating my site to my current employer's platform on Azure. 
- This means relearning a lot of fun code I hacked out over the course of a couple months in 2019.
- Luckily, I did myself a huge favor by both creating a Makefile
- However, I did myself a couple disservices by forgetting to thoroughly document all of the features.
- Even with the Makefile, I'm not sure some of the commands would have worked as I intended (because they certainly don't work now.)
- I'm simplifying the Makefile and getting of options and paramters that are laregly superflous because this Makefile is used by one user, for a single purpose. I can always add them back later if I need.

- In the first section of the article I want to go over how the site itself is edited and managed.
- In the second section of the article I want cover how the site is published to the web.
- In the third section of the article I want to cover how the site is hosted with storage backed CDN.
- In the fourth section of the article I want to cover how the site is deployed. 

Section 1:

Section 2:
-Since I am migrating to a new hosting providing, Azure, I get to completely rewrite this upload automation. 
-After evaluating 
Section 3:
