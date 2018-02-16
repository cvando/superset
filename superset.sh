# set up Superset
if [ ! -f /var/lib/superset/.setup-complete ]; then
  echo "Running first time setup for Superset"

  echo "Creating admin user"
  cat > /var/lib/superset/admin.config <<EOF
admin
admin
admin
admin@admin.fr
admin
admin
EOF

  /bin/sh -c '/usr/local/bin/fabmanager create-admin --app superset < /var/lib/superset/admin.config'

  rm /var/lib/superset/admin.config

  echo "Initializing database"
  superset db upgrade

  echo "Creating default roles and permissions"
  superset init

  touch /var/lib/superset/.setup-complete
else
  # always upgrade the database, running any pending migrations
  superset db upgrade
fi

echo "Starting up Superset"
superset runserver
