---
layout: page
title: Archive
permalink: /archive
---
{% for post in site.posts %}
  {{ post.date | date: "%b %-d, %Y" }}: [{{ post.title }}]({{ post.url }})
{% endfor %}
