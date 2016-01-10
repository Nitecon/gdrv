#gDrv

## About gDrv
The idea behind gDrv came about when I started switching more frequently between mac / windows and linux (arch).
To date there is no open source version of google drive that still works and this project aims to solve that issue.

Contributors are welcome.

## Getting started with the project
Once you have cloned the project you need npm/node installed and then run the intial bootstrapper to get your dependencies,
available and ready to be used: `./bin/upgrade-deps.sh`

That will upgrade you to the revision that we currently use for the program.

## Why electron / some webkit garbage?
Answer to this is simple, it's easy to support multiple OS's which is obviously missing from the official clients.
Second and probably most importantly it will allow us an easy way to do non intrusuve updates as the frontend is
disconnected from teh backend that actually does the work etc.  The frontend in this case electron is only responsible for
spawning the application and eventually to check and do updates, downloads of the updates and respawn of the newly downloaded
go binary.  This greatly simplifies things and simplicity is very dear to me, so live with it.  Finally this allows us the ability
to build a cross OS app that can be deployed on windows / mac and perhaps in the future support more than just file syncing or at 
the very least make an application with the same functionality across all distros instead of having to jump through hoops between 
OS's to get the same functionality as what generally does happen with most software that *tries* to be cross platform.

## How the application is structured / works and how I can contribute.
There is a couple of different ways you can help.
- Electron frontend to check a location for updates and downlaod / respawn
  - See the `app/main.js` file if you are interested in binary names / where it will be stored.
- If you are a go developer, think of this as a web app
- Which means we need both GUI / Backend help to interface with the drive api's etc.

More questions beyond reading the entry points (`app/main.js`) for electron and (`main.go`) for golang feel free to ask / create an issue.

## How does gDrv essentially work?
gDrv design is based on a frontend / backend setup.  The frontend is handled by electron (chromium) as it already has window management etc solved and reduces our need to deal with native gui implementations across multiple OS's.  Node.js is responsible for spawning the OS specific golang binary application, and go into listening mode.  The go application upon startup responds to the electron application with a random port location that the application is listening to locally, and then redirects to that location for the actual "main" or homepage whatever you want to call it.  Beyond the redirection electron will have a couple of menu items over time for getting general application help / checking for updates, downloading updates / respawning the app and exit etc and thats just about it.
