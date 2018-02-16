#!/bin/bash

echo "Creating admin user"
cat > /var/lib/superset/admin.config <<EOF
admin
admin
admin
admin@admin.fr
admin
admin
EOF

fabmanager create-admin --app superset < /var/lib/superset/admin.config

# set up Superset
echo "Running first time setup for Superset"

echo "Initializing database"
superset db upgrade

echo "Creating default roles and permissions"
superset init

echo "Starting up Superset"
superset runserver
