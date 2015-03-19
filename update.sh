#!/usr/bin/env bash

# ==============================================================================
# avoid permission conflicts for the commandline user
# ------------------------------------------------------------------------------
sudo chmod 777 app/cache -R
# ==============================================================================

# ==============================================================================
# Remove generated files
# ------------------------------------------------------------------------------
rm -rdf src/Demo/UserBundle/Form/
rm -rdf src/Demo/UserBundle/Controller/UserController.php src/Demo/UserBundle/Resources/views/User/
rm -rdf src/Demo/UserBundle/Controller/PhoneNumberController.php src/Demo/UserBundle/Resources/views/PhoneNumber/
# ==============================================================================

# ==============================================================================
# Update the Database Schema
# ------------------------------------------------------------------------------
php app/console doctrine:schema:update --force
# ==============================================================================

# ==============================================================================
# Generate new CRUD - Controllers, Forms, Views
# ------------------------------------------------------------------------------
php app/console jordillonch:generate:crud --entity=DemoUserBundle:User --route-prefix=user --with-write --format=annotation --no-interaction --overwrite
php app/console jordillonch:generate:crud --entity=DemoUserBundle:PhoneNumber --route-prefix=phonenumbers --with-write --format=annotation --no-interaction --overwrite
# ==============================================================================

# ==============================================================================
# Clear the cache
# ------------------------------------------------------------------------------
php app/console cache:clear --no-warmup
php app/console cache:clear --no-warmup --env=prod
# ==============================================================================

# ==============================================================================
# Dump web assets
# ------------------------------------------------------------------------------
php app/console assets:install
php app/console assets:install --env=prod
# ==============================================================================

# ==============================================================================
# avoid permission conflicts for the web user
# ------------------------------------------------------------------------------
sudo chmod 777 app/cache -R
# ==============================================================================

#EOF
