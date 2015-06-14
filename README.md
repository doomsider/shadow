shadow
======

General:
Shadow is a script that works with Mysql to gather data and interact with game servers that have console input and output

Shadow is written and tested with StarMade in mind but will be flexible enough to use with other game servers as well.  It is designed to allow modification to game servers without changing or modifying the server.  It works by collecting the standard and error outputs of a server and issuing admin commands to the console.


Development:
Adding useful modifications and testing towards an Alpha release


Install:

Shadow is in testing mode only at the moment.  The current target test system is Ubuntu 14.04.  If you want to test shadow on other operating systems or configurations I cannot offer support during testing.  

Due to issues related to formatting between Windows and Linux and the high number of problems we have had we now use dos2unix on all related .dstd files.  Please issue dos2unix shadow.dtsd command if any formatting issues are seen by shell.

To download a current copy of StarMade if you are doing a fresh install ./shadows.dtsd download

Copy shadow files to the parent directory of Starmade and make shadow.dtsd executable.  Run ./shadow.dtsd setup to create the initial configuration file.  Typing ./shadow.dtsd will display the available commands.

To set initial rank for a player ./shadow.dtsd changerank player rank (example: ./shadow.dtsd changerank Doomsider Admiral)

Many of the commands are for debugging purposes right now and will be removed later after testing is complete 

Future Goals (feel free to edit/add):

Enhance server web pages with information from the database

Add a web admin panel to control the game server remotely


Ideas (feel free to edit/add):

Create classes/professions for SM:
Classes or professions based on goal related to profession.  For example a miner gains experience mining asteroids.  Classes would have special abilities after certain levels.  For example a bounty hunter could detect bounties close by.

Scripted events upon entering sectors:
Basic missions given by NPCs.  Script would spawn entities related to the script when the player enters with a check in change_sector

More control over universe generation:
Ability to reduce database by removing unused sectors by cross checking player creations with sectors and resetting sectors that are not being used

Auto restocking of shops

Removal of shops and replacement with something else

Script to simulate a universe generation combined with alien race stations and ships 
