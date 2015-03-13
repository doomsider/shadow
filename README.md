shadow
======

General:
Shadow is a script that works with Mysql to gather data and interact with game servers

Shadow is written and tested with StarMade in mind but will be flexible enough to use with other game servers as well.  It is designed to allow modification to game servers without changing or modifying the server.  It works by collecting the standard and error outputs of a server and issuing admin commands to the console.


Current Goals (feel free to edit/add):

Finish Mysql libraries so that there are functions for all database needs

Move all old text files to tables inside the database

Create am easy way to edit the database

Create some sort of web interface, for editing player data and maybe display things like players stats; kills etc


Install:
Copy shadow files to the parent directory of Starmade and make shadow.dtsd executable.  Run shadow.dtsd setup to create the initial configuration file.  Typing shadow.dtsd will display the available commands.
