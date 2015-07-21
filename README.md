shadow
======

General:
Shadow is a script that works with Mysql to gather data and interact with game servers that have console input and output

Shadow is written and tested with StarMade in mind but will be flexible enough to use with other game servers as well.  It is designed to allow modification to game servers without changing or modifying the server.  It works by collecting the standard and error outputs of a server and issuing admin commands to the console.


Development:
Adding useful modifications and testing towards an Alpha release

Install Easy:

	Download https://drive.google.com/file/d/0B519td3ku8G1dVVPNURCbzBJcGM/view?usp=sharing and copy to the directory you wish to install StarMade to.
	
	or
	
	wget http://104.223.107.159/forum/uploads/local/install.sh in the directory Starmade is or will be.
	
	chmod +x install.sh
	
	./install.sh
	
	Follow the on screen instructions and be sure to go through all the steps
	

Install Manual:

Shadow is in testing mode only at the moment.  The current target test system is Ubuntu 14.04 and Mysql 5.5.  If you want to test shadow on other operating systems or configurations I cannot offer support during testing.  

Step1 - Get Shadow's files and directories from Github then copy shadow files/dirs to the parent directory of Starmade if it exists.  If it doesn't exist put them in the same directory you plan to install StarMade to.

Step2 - Prerequisites must be installed for the script to function properly.  For Ubuntu you must install Java, Mysql, Zip, Dos2unix, Curl, and Screen if they are not installed already 
	
	EXAMPLE INSTALL COMMANDS FOR UBUNTU 14.04
	
	sudo apt-get install screen
	
	sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql
	
	sudo apt-get install default-jre
	
	sudo apt-get install zip
	
	sudo apt-get install dos2unix
	
	sudo apt-get install curl
	
	sudo apt-get install git
	
	SPECIAL NOTE:  You must set a root password for Mysql for Shadow to function, do not leave this blank.
	
Step3 - Make shadow.dtsd executable with a chmod +x shadow.dtsd.

Step4 - Run ./shadow.dtsd to see if there are formatting errors.  If you get this error -bash: ./shadow.dtsd: /bin/bash^M: bad interpreter: No such file or directory then you must run dos2unix shadow.dtsd.

Step5 - Download or copy over an existing install of Starmade.  To download with Shadow issue a ./shadow.dtsd download.  This command will also update the server.  

	SPECIAL NOTE: Due to a bug in the Starmade starter file the install or upgrade/update will hang on the last file and the user with have to ctrl-c to break out.
	
Step6 - Run setup with ./shadow.dtsd setup.  Go through the configuration completely before attempting to run Starmade.  This will create a file in /core called config.dtsd that can be edited later.

	SPECIAL NOTE:  When setting minimum or max memory it must have a m after it.  For example 1024m.

Step7 - Verify everything is working.  Run the server with ./shadow.dtsd start and then check the Starmade server screen with screen -r screename_youpicked or try to connect with a client.

Additional Configuration and Notes for Shadow:

Typing ./shadow.dtsd will display the available commands.

To update StarMade issue a ./shadows.dtsd download.

To set initial rank for a player ./shadow.dtsd changerank player rank (example: ./shadow.dtsd changerank Doomsider Admiral).

You can edit what ranks can use what chat commands in /modules/rank.dtsd under COMMANDLIST_RANK1 through COMMANDLIST_RANK5.  To rebuild ranks database do a ./shadow.dtsd setranks.

Writing Modules:

Writing you own module is what Shadow was designed for.  There are several functions that allow building of modules to be independent of the existing scripts.  This means you can just drop in your own script into /modules.  For instance mymodule.dtsd.

MYSQL - Mysql is used heavily in Shadow and you will have to become somewhat familiar with it depending on what you wish to do.  Basic examples of interacting with Mysql can be seen in /core/lib_mysql.dtstd and throughout the other scripts.
	
	Creating a database is as easy as including MYSQLDTSD_TABLENANE_COLUMNNAME="Mysql information for column".  
	
	Here is an example from the script that creates the Name column for Players MYSQLDTSD_PLAYERDB_NAME="VARCHAR(25)".

Naming Conventions - Shadow looks at its own functions' names to determine special circumstances for the script.
	
	Any function that starts with core_ will be available for execution for the ./shadow.dtsd command line and be listed as an available function.  
	
	Any function that starts with chatcommand_ will be available to be executed through chatcommands in the client.  Please put function name in all caps and don't forget to add it to the ranks database for the proper rank or you wont be able to see or execute it from the client.
	
	Any function that starts with lib_ is a library function.  In this context this means it is an internal function expected to be used by several other functions.  The lib_ designation is only for ease of identification of heavily used functions.
	
	Any variable that starts with LOGSEARCH_ will automatically entered into the search database and then the result will be returned to the specified function.  The format is LOGSEARCH_functioname="String match in log".

	Any variable that starts with MYSQLEVENT_ will be added to the running Mysql events.  Mysql event manager must be turned on for these to work.  The format is MYSQLEVENT_FREQUENCY_TIMEVALUE_TIMEQUANTITY_EVENTNAME="EVENT_FUNCTION_NAME".
	

Known Issues:
	Mysql 5.6+ is not compatible with this script at this time
	
Future Goals (feel free to edit/add):

Enhance server web pages with information from the database.

Add a web admin panel to control the game server remotely.

Current Worklist(no particular order):
	
	AI Guards
	Reduce the size of the universe by deleting unused sectors
	Faction Bank Accounts for credits and faction points
	Tooltips
	Shop Restock automated
	Shop replace default shops
	Cool down for user chat commands
	Ship quarantine for going over block size or other set parameters
	Faction DB and tracking faction statistics
	Basic PHP connection examples to extract information with a web page
	Duelling
	Arena

Ideas (feel free to edit/add):

Create classes/professions for SM:
Classes or professions based on goal related to profession.  For example a miner gains experience mining asteroids.  Classes would have special abilities after certain levels.  For example a bounty hunter could detect bounties close by.

Scripted events upon entering sectors:
Basic missions given by NPCs.  Script would spawn entities related to the script when the player enters with a check in change_sector.

More control over universe generation:
Ability to reduce database by removing unused sectors by cross checking player creations with sectors and resetting sectors that are not being used.

Faction Maintenance:
Be able to tax factions based on their total block count (all ships combined) as a system to prevent build-up and also to keep factions active

Alient Races:
Script to simulate a universe generation combined with alien race stations and ships.
