MCReventBooker
==============

The scripts hosted within this repository are for the automation of booking Clare College MCR Formal tickets.
There are two script procedures for booking tickets. The first uses *booker_getevent.sh*, *bookevent.sh* and *queueevent.sh*. 
This method is fast, avoiding network traffic on the system, however it is completely time dependent, if the bookevent queue is late going live, then this method will FAIL.
The second method uses the script *booker.sh*. This script is more robust, refreshing the bookevent page until the queue goes live. However, it is much slower as it can get stuck in network traffic.
The event name may need updated weekly, in the crontab, to reflect the name given on the [website](http://mcr.clare.cam.ac.uk/events/mealbooker.py).  


Script Usage
-------------

To use these scripts, access to a UNIX commandline is necessary. A free account is available from the [SRCF](http://www.srcf.net/). 

After Downloading and unpacking the distribution, go to the file directory <pre><code>cd MCReventBooker</code></pre> and make the scripts executable <pre><code>chmod 770 *</code></pre>. 
Move the scripts to your bin. <pre><code>mkdir ~/bin; mv * ~/bin/</code></pre> 

Now create a passwordFile (.my.cnf) containing your raven password.  
This file must be of the form password=[raven.password]  

You can create the file with the command <pre><code>nano ~/.my.cnf</code></pre>  
Use Ctrl-X to save and exit nano

E.g. The .my.cnf file should look like this 
<pre><code>password="P4SSW0RD"</code></pre>

Next set the file to be readable only by the user
<pre><code>chmod 600 ~/.my.cnf</code></pre>

create a new folder if you want both the fast and robust scripts to run simultaneously
<pre><code>mkdir ~/bookdir</code></pre>  

Now Call the scripts using crontab
Add the following lines to your crontab <pre><code>crontab -e</code></pre>

<pre><code>## Formal Dinner Booker Sunday
# Fast script
59 20 * * 0 booker_getevent.sh -p ~/[passwordFile] -t 1 -u [raven.username] -e "[Event.Name]"
00 21 * * 0 bookevent.sh
00 21 * * 0 queueevent.sh 
# Robust script
59 20 * * 0 (cd bookdir; sleep 30; booker.sh -t 1 -u [raven.username] -p ~/[passwordFile] -e "[Event.Name]")
</code></pre>

*booker_getevent.sh* and *booker.sh* should be called before the queue goes live, i.e. at 20:59.
*bookevent.sh* and *queueevent.sh* are called simultaneously as the queue goes live, i.e. at 21:00.

# example
<pre><code>59 20 * * ) booker_getevent.sh -p ~/.my.cnf -t 1 -u rjg70 -e "Formal Dinner"</code></pre>

#Command Line Options
-t : number of tickets [1-2]  
-p : passwordFile e.g. ~/.my.cnf  
-e : event name  
-u : raven username  



