# SpeedyEXsimple
A acceleration solution about project [Exsimple](https://github.com/XenoAmess/EXsimple),

using nginx to handle the download part of the netdisk.

It also handles https.

nginx is far faster than my program(of course).
	
# notice:
This program is only tested on Ubuntu 18.04.4 LTS

I do think newer versions of Ubuntu MIGHT also be capable but I haven't found time to test it out.

The make script is using apt, so if you are not using ubuntu you shall handle it yourself.

The make script is using python 3.5 for nuitka, if it cannot run correctly on your machine then You must change it.
A common way is to use PyPy instead of nuitka. It will work, PyPy is faster than python, but nuitka is always faster.

# how to use:
Basically this project is for showing off and benchmark.

In usual use cases of Exsimple, people want to get a fast way to deploy a nedisk.

And deploy a nginx middleware sounds crazy, and unacceptable in such situations.

If you really want to use it anyway:
 
1. You MUST clone this project at folder /SpeedyExsimple/

2. You MUST add http keys into the pki folder, or delete the https server of SpeedyExsimple.conf

You CAN see ./pki/readme.md for more details.

3. you MUST change all dailypaste thing in the codes to your site name.

4. then you run ./make to build

5. when you want to start, you run ./startup

6. when you want to stop, you run ./shutdown
  