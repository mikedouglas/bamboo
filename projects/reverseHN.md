---
title: reverseHN
date: 2011 July 10
author: Mike Douglas
---

If you’re at all like me, you’ve probably got 16+ browser tabs open at
the moment, some of which you haven’t touched in days. Whenever I get
around to triage these links, I always find a few interesting articles
or projects that (more likely than not) I originally found through
Hacker News.

What I’m missing is the original discussion thread. By now, the
submission has fallen off the front page, and (if you’re lucky enough
for the submitter to not have changed the title) you need to google some
combination of the title, domain and “site:news.ycombinator.com” to
locate it again. Hacker News maps discussion threads to unique urls, but
there was no obvious way to invert that function.

Luckily, with the [new search api], it’s possible to get 95%[^95] of the
way there. Introducing, the <a class="bookmarklet" href="javascript:(function(e,a,g,h,f,c,b,d){if(!(f=e.jQuery)||g%3Ef.fn.jquery||h(f)){c=a.createElement(%22script%22);c.type=%22text/javascript%22;c.src=%22http://ajax.googleapis.com/ajax/libs/jquery/%22+g+%22/jquery.min.js%22;c.onload=c.onreadystatechange=function(){if(!b&amp;&amp;(!(d=this.readyState)||d==%22loaded%22||d==%22complete%22)){h((f=e.jQuery).noConflict(1),b=1);f(c).remove()}};a.documentElement.childNodes[0].appendChild(c)}})(window,document,%221.2.6%22,function($,L){$.getJSON('http://api.thriftdb.com/api.hnsearch.com/items/_search?filter[fields][url]='%20+%20location.href%20+%20'&amp;callback=?',%20function(res)%20{%20%20var%20url%20=%20res[%22results%22][0][%22item%22][%22url%22];%20%20if%20(url%20===%20location.href%20||%20url%20+%20%22/%22%20===%20location.href)%20{%20%20%20%20location.href='http://news.ycombinator.com/item?id='%20+%20res[%22results%22][0][%22item%22][%22id%22];%20%20}});});">reverseHN</a> bookmarklet.

[new search api]: http://hnsearch.com/

[^95]: The page must be indexed by the
[hnsearch.com](http://hnsearch.com) first, so brand new submissions will
not work.
