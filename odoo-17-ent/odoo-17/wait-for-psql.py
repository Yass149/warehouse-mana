#!/usr/bin/env python3

# Importing necessary modules
import argparse  # For parsing command-line arguments
import psycopg2  # For interacting with PostgreSQL database
import sys       # For accessing system-specific parameters and functions
import time      # For time-related functions

# Main entry point of the script
if __name__ == '__main__':
    # Creating an ArgumentParser object to handle command-line arguments
    arg_parser = argparse.ArgumentParser()
    # Defining command-line arguments for database connection parameters
    arg_parser.add_argument('--db_host', required=True)        # Database host
    arg_parser.add_argument('--db_port', required=True)        # Database port
    arg_parser.add_argument('--db_user', required=True)        # Database username
    arg_parser.add_argument('--db_password', required=True)    # Database password
    arg_parser.add_argument('--timeout', type=int, default=5)  # Timeout for database connection (default: 5 seconds)

    # Parsing command-line arguments
    args = arg_parser.parse_args()

    # Recording the start time to calculate elapsed time
    start_time = time.time()
    # Looping until the timeout is reached
    while (time.time() - start_time) < args.timeout:
        try:
            # Attempting to connect to the PostgreSQL database
            conn = psycopg2.connect(user=args.db_user, host=args.db_host, port=args.db_port, password=args.db_password, dbname='postgres')
            error = ''  # Resetting error variable
            break      # Breaking out of the loop if connection is successful
        except psycopg2.OperationalError as e:
            error = e  # Storing the error message if connection fails
        else:
            conn.close()  # Closing the connection if it was opened successfully
        time.sleep(1)     # Waiting for 1 second before retrying the connection

    # Checking if there was an error during the connection attempt
    if error:
        # Printing the error message to the standard error stream
        print("Database connection failure: %s" % error, file=sys.stderr)
        # Exiting the script with a status code of 1 to indicate failure
        sys.exit(1)
