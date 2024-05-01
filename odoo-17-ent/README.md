# README #
## Odoo Container Project ##

This repository contains the files and configurations for setting up a development environment for Odoo using Docker containers. Below is a description of the file structure and the purpose of each file:
File Structure

ODOO-17-ent
	├── README.md
	├── docker-compose.yml
	└── .devcontainer
	│	└── devcontainer.json
	│	└── docker-compose.extend.yml
	└── config
	│	 └── odoo.conf
	└── odoo_modules
	│	└── .vscode
	│	│	└── launch.json
	│	│	└── settings.json
	│	└── .gitignore
	└── odoo-17
		└── .gitattributes
		└── Dockerfile
		└── entrypoint.sh
		└── odoo_17.0+e.latest_all.deb
		└── wait-for_psql.py


### README.md: ###
You're currently reading this file, which provides an overview of the project.

### docker-compose.yml: ### 
Defines services, networks, and volumes for Docker Compose. Specifies services for the web and database (db), sets up ports, volumes, and environment variables for each service.

## .devcontainer: ##
This directory contains configuration files for the development container settings.
### devcontainer.json: ### 
Configures the development container settings for the Odoo project. It specifies Docker Compose files to use, extensions to install, VS Code settings, workspace folder, service to use, and shutdown action.
### docker-compose.extend.yml: ### 
Extends the Docker Compose configuration for the project. It specifies environment variables for the web service, including database host, port, user, and password. It also includes a command override to prevent the container from shutting down after the process ends.

## config: ##
Contains configuration files for Odoo.
### odoo.conf:###  
Specifies configuration options for Odoo, including addons_path, data_dir, and admin_passwd.

## odoo_modules: ##
Directory for storing additional Odoo modules or addons.

### .vscode: ### 
Contains Visual Studio Code configuration files.
### launch.json: ###  
Configures debugging launch configurations for Odoo. Defines two configurations: one for launching Odoo and another for launching Odoo with a debug log handler.
### settings.json: ### 
Contains Visual Studio Code settings specific to the project, including terminal profiles, default terminal profile, automation shell, and default Python interpreter path.

### .gitignore: ### 
Specifies patterns to ignore when Git considers changes. It ignores everything except .gitignore and .vscode.

## odoo-17: ##
Directory containing files related to Odoo version 17.
### .gitattributes: ### 
Specifies attributes for paths and files in the repository. It sets attributes for handling .deb files with Git LFS (Large File Storage).
### Dockerfile: ### 
Defines the build steps for creating the Odoo container. It installs dependencies, sets environment variables, copies Odoo files, and specifies the entry point.
###  entrypoint.sh: ### 
Entry point script for the Odoo container. Sets up environment variables for PostgreSQL connection, waits for PostgreSQL to be ready, and executes the Odoo process with appropriate arguments.
### odoo_17.0+e.latest_all.deb: ### 
Debian package file for Odoo version 17.0+e.
### wait-for_psql.py: ### 
Python script that waits for PostgreSQL to be available.

