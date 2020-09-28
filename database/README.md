Setting up a new Database in a Docker instance

# install Docker

install Docker Desktop for Windows version **2.3.0.3**, or higher from stable channel

change docker settings:
- share C drive
- memory 4Gb (minimum, upwards of 8Gb)

pull base images using the terminal:
- docker pull mcr.microsoft.com/mssql/server:2017-latest-ubuntu

# ports

Should you want to run the solutions using different ports, search and replace the following exposed ports in the docker-compose.yml
- hmcr-db: 1466

# abbreviations used in this file

- Tx: terminal window
- Tx*: terminal inside a running container, started for example with: ```docker exec -it hmcr-db bash```
- WS: Workstation, for example to access website via http://localhost:8777

Note: in a powershell terminal > $host.UI.RawUI.WindowTitle = "T1" will change the title of the window to T1

## build sqlserver image (5 minutes)
- Edit the create-user.sql file with values with your IDIR/UserId and IDIR/UserGUID
- T1: docker-compose up hmcr-db
- T2: docker-compose exec hmcr bash
- T2*: run ./initial-build.sh
- T2*: exit
- T2: docker commit hmcr-db hmcr-db:ready
