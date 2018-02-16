#!/bin/bash

# set up Superset
echo "Running first time setup for Superset"

echo "Initializing database"
superset db upgrade

echo "Creating default roles and permissions"
superset init

echo "Starting up Superset"
superset runserver
