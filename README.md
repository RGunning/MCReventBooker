MCReventBooker
==============

MCR event booker Readme


Script Usage
-------------


<pre><code>## Formal Dinner Booker Sunday
# Fast script
59 20 * * 0 booker_getevent.sh -p ~/.my.cnf -t 1 -u [raven.username] -e "[Event.Name]"
00 21 * * 0 bookevent.sh
00 21 * * 0 queueevent.sh 

# Robust script
59 20 * * 0 (sleep 30; booker.sh -t 1 -u [raven.username] -p ~/.my.cnf -e "[Event.Name]")</pre></code>

