##Juniorlab Easter 2016
###Minecraft, Arduino and LittleBits
http://www.juniorlab.de

This year we'll teach kids at the Easter Juniorlab in Berlin how to create experimental interfaces and controllers for Minecraft with Processing.

![Littlebits](http://ixd-hof.de/wp-content/uploads/2016/03/LittleBits_Minecraft_500.jpg)

We're using zhuowei's (RaspberryJuice)[https://github.com/zhuowei/RaspberryJuice/tree/master/src/main/resources/mcpi/api/java] Java Library in Processing. @bitcraftlab is currently writing a Processing library.

###Examples:
####(JL01_LittleBits_HID_Minecraft)[https://github.com/ixd-hof/Processing/tree/master/JuniorlabEaster2016/Arduino/JL01_LittleBits_HID_Minecraft]
Using LittleBits Android as Mouse / Keyboard and control Minecraft (jump, turn)

####(JL01_LittleBits_Arduino_Basic)[https://github.com/ixd-hof/Processing/tree/master/JuniorlabEaster2016/Processing/JL01_LittleBits_Arduino_Basic]
Write Firmata Basic (Examples) on the LittleBits Arduino (Leonardo) and access inputs and outputs from Processing.

####(JL02_LittleBits_Arduino_Minecraft)[https://github.com/ixd-hof/Processing/tree/master/JuniorlabEaster2016/Processing/JL02_LittleBits_Arduino_Minecraft]
Catapult player by pressing a button and create blocks above the player from within Processing

####(JL03_LittleBits_Arduino_Minecraft_Math)[https://github.com/ixd-hof/Processing/tree/master/JuniorlabEaster2016/Processing/JL03_LittleBits_Arduino_Minecraft_Math]
Simple math exmaples: Create circles of blocks while rotating a knob and draw sinus curves.

####(JL04_LittleBits_Minecraft_Painter)[https://github.com/ixd-hof/Processing/tree/master/JuniorlabEaster2016/Processing/JL04_LittleBits_Minecraft_Painter]
Painting with the mouse in a Processing sketch creates blocks in Minecraft.


###Minecraft
We are using MinecraftEdu on OS X and Windows. MinecraftEdu's server runs on Forge mod. In order to send commands from Processing to Miecraft (like on Raspberry Pi) we are using [https://github.com/kbsriram/mcpiapi](mcpiapi mod).

Here's a tutorial that shows some of the commands:
http://www.stuffaboutcode.com/2013/04/minecraft-pi-edition-api-tutorial.html

####Tips:
In order to prevent Minecraft from sleeping when you're editing in Processing:
Set in Minecraft's options.txt pauseOnLostFocus:false

Copy mcpiapi mod in your Minecraft server and client mod folder.
