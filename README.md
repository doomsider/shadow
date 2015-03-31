shadow
======

General:
Shadow is a script that works with Mysql to gather data and interact with game servers

Shadow is written and tested with StarMade in mind but will be flexible enough to use with other game servers as well.  It is designed to allow modification to game servers without changing or modifying the server.  It works by collecting the standard and error outputs of a server and issuing admin commands to the console.



Current Goals (feel free to edit/add):

Finish Mysql libraries so that there are functions for all database needs

Move all old text files to tables inside the database

Create an easy way to edit the database

Create some sort of web interface, for editing player data and maybe display things like players stats; kills etc



Install:

Shadow is in testing mode only at the moment.  The current target test system is Ubuntu 14.04.  If you want to test shadow on other operating systems or configurations I cannot offer support during testing.  

Copy shadow files to the parent directory of Starmade and make shadow.dtsd executable.  Run ./shadow.dtsd setup to create the initial configuration file.  Typing ./shadow.dtsd will display the available commands.

To download a current copy of StarMade if you are doing a fresh install ./shadows.dtsd download

Manual setup of mysql tables and columns is ./shadow.dtsd mycreate

Manual setup for rank system is ./shadow.dtsd setranks

Many of the commands are for debugging purposes right now and will be removed later after testing is complete 





Random Thoughts:  

Need to come up with a way to allow script to handle running programs/function at intervals or at the start


Ideas:

Create classes/professions for SM:

Make a web map:

Scripted events upon entering sectors:


More control over universe generation:

Abiliry to reduce database by removing unused sectors
