#!/bin/bash

# Set the shell to exit immediately if any command exits with a non-zero status
set -e

# Check if the PASSWORD_FILE environment variable is set
if [ -v PASSWORD_FILE ]; then
    # If set, read the content of the file specified in PASSWORD_FILE and assign it to the variable PASSWORD
    PASSWORD="$(< $PASSWORD_FILE)"
fi

# Database Configuration
# Set default values for PostgreSQL database host, port, user, and password
# If corresponding environment variables are not set, fall back to default values
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='odoo'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='odoo'}}}

# Define an array to store database connection parameters
DB_ARGS=()

# Function to check configuration values from the Odoo configuration file
function check_config() {
    param="$1"
    value="$2"
    if grep -q -E "^\s*\b${param}\b\s*=" "$ODOO_RC" ; then
        # If the parameter exists in the configuration file, extract its value and store it in the 'value' variable
        value=$(grep -E "^\s*\b${param}\b\s*=" "$ODOO_RC" | cut -d " " -f3 | sed 's/["\n\r]//g')
    fi
    # Add parameter and its value to the DB_ARGS array
    DB_ARGS+=("--${param}")
    DB_ARGS+=("${value}")
}

# Check and store configuration values for database host, port, user, and password
check_config "db_host" "$HOST"
check_config "db_port" "$PORT"
check_config "db_user" "$USER"
check_config "db_password" "$PASSWORD"

# Case statement to handle different execution scenarios
case "$1" in
    -- | odoo)
        shift
        if [[ "$1" == "scaffold" ]]; then
            # If the first argument is 'scaffold', execute the Odoo process with arguments
            exec odoo "$@"
        else
            # Wait for PostgreSQL to be ready using wait-for-psql.py and then execute the Odoo process with arguments
            wait-for-psql.py ${DB_ARGS[@]} --timeout=30
            exec odoo "$@" "${DB_ARGS[@]}"
        fi
        ;;
    -*)
        # If the first argument starts with '-', wait for PostgreSQL to be ready using wait-for-psql.py
        wait-for-psql.py ${DB_ARGS[@]} --timeout=30
        # Execute the Odoo process with arguments
        exec odoo "$@" "${DB_ARGS[@]}"
        ;;
    *)
        # If none of the above cases match, execute the provided command
        exec "$@"
        ;;
esac

# Exit with status code 1 (indicating an error) if the script reaches this point
exit 1
