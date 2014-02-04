MCReventBooker
==============

MCR event booker Readme


Script Usage
-------------

## Crontab file
Add the following lines to your crontab <pre><code>crontab -e<\pre><\code>

<pre><code>## Formal Dinner Booker Sunday
\# Fast script
59 20 * * 0 booker_getevent.sh -p ~/.my.cnf -t 1 -u [raven.username] -e "[Event.Name]"
00 21 * * 0 bookevent.sh
00 21 * * 0 queueevent.sh 
\# Robust script
59 20 * * 0 (sleep 30; booker.sh -t 1 -u [raven.username] -p ~/.my.cnf -e "[Event.Name]")</pre></code>

# example
<pre><code>59 20 * * ) booker_getevent.sh -p ~/.my.cnf -t 1 -u rjg70 -e "Formal Dinner"<\pre><\code>

