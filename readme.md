# SpeedyEXsimple
A acceleration solution about project [Exsimple](https://github.com/XenoAmess/EXsimple),

using nginx to handle the download part of the netdisk.

It also handles https.

nginx is far faster than my program(of course).
	
# how to use:
Basically this project is for showing off.

In usual use cases of Exsimple, people want to get a fast way to deploy a nedisk.

And deploy a nginx middleware sounds crazy, and unacceptable.

If you really want to use it anyway:
 
1. You MUST clone this project at folder /SpeedyExsimple/

2. You MUST add http keys into the pki folder, or delete the https server of SpeedyExsimple.conf

You CAN see ./pki/readme.md for more details.

3. you MUST change all dailypaste thing in the codes to your site name.

4. then you run ./make to build

5. when you want to start, you run ./startup

6. when you want to stop, you run ./shutdown
  