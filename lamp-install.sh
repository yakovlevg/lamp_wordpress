#!/bin/bash

set -xe
## Read sensityve data
source ./.env

DB_USER="wordpress"
DB_PASSWORD=$(date | md5sum | head -c 15)
WP_USER="admin"
WP_PASSWORD=$(sleep 1 && date | md5sum | head -c 15)
HOST=$(hostname)
LOCAL_IP=$(ip ro ls | grep -oP 'src \K[^ ]+')
WWW_ROOT="/var/www/html"
echo "Mysql creds:\n Username: $DB_USER\n Password: $DB_PASSWORD \n"
MESSAGE="Mysql creds:\n Username: $DB_USER\n Password: $DB_PASSWORD \n"
PHP_MODULES="php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip"
PACKAGES="apache2 default-mysql-server php libapache2-mod-php php-mysql nginx curl sendemail"


send_email () {
	sendemail -f $FROM -t $TO -u $SUBJ -s $SERVER -xu $FROM -xp "$PASSWORD" \
	-m "$1" -v -o =yes message-charset=$CHARSET
}

check_db () {
	mysqlshow $1 | grep Database | grep -o $1
}
service_check () {
	if systemctl is-active --quiet "$service_name.service" ; then
  		echo "$service_name running"
	else
  		systemctl start "$service_name"
	fi
}


deploy_wp_site() {
    cd $WWW_ROOT
    if [ -f "$WWW_ROOT/$1/wp-config.php" ]; then
       # Create backup file wp-config.php
       cp $WWW_ROOT/$1/wp-config.php $WWW_ROOT/$1/wp-config.php.bak
       cd $WWW_ROOT/$1
       # Update Database password
       wp config set DB_PASSWORD $DB_PASSWORD --allow-root
    else
        # Download the latest version of WordPress
        wp core download --allow-root --path=$1
        cd $WWW_ROOT/$1
        # Create a new wp-config.php file
        wp config create --dbname=$DB_USER --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root
        # Install WordPress 
        wp core install --url=$LOCAL_IP --title=$HOST --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=info@wp-cli.org --allow-root
     
    fi
}

############################################################################################################
##########################   Start deployment LAMP with Wordpress    #######################################
############################################################################################################

# Install dependency packges
sudo apt-get update
sudo apt-get install -y $PACKAGES $PHP_MODULES

# Configure Apache2
cp ./conf/000-default.conf.j2 /etc/apache2/sites-available/000-default.conf
sed -i 's/Listen 80$/Listen 8080/g' /etc/apache2/ports.conf
systemctl restart apache2

# Configure Nginx
cp ./conf/nginx-default.conf.j2 /etc/nginx/sites-available/default
systemctl restart nginx

# Create USER and DATABASE for Wordpress
if check_db "$DB_USER"; then
	echo "Database $DB_USER already exist"
    echo "Update password for user ${DB_USER}"
    mysql -uroot -p${rootpasswd} -e "ALTER USER ${DB_USER}@localhost IDENTIFIED BY '${DB_PASSWORD}';"
else
if [ -f /root/.my.cnf ]; then

    mysql -e "CREATE DATABASE ${DB_USER} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -e "CREATE USER ${DB_USER}@localhost IDENTIFIED BY '${DB_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${DB_USER}.* TO '${DB_USER}'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

# If /root/.my.cnf doesn't exist then it'll ask for root password   
else
    echo "Please enter root user MySQL password!"
    echo "Note: password will be hidden when typing"
    read -sp rootpasswd
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${DB_USER} /*\!40100 DEFAULT CHARACTER SET utf8 */; \
    CREATE USER ${DB_USER}@localhost IDENTIFIED BY '${DB_PASSWORD}'; \
    GRANT ALL PRIVILEGES ON ${DB_USER}.* TO '${DB_USER}'@'localhost'; \
    FLUSH PRIVILEGES;"
  fi
fi


## Install wp-cli

if [ -f "/usr/local/bin/wp" ]; then
    echo "File wp exists."
else
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
fi 

## Deploy Wordpress site

# Check installed wordpress
if [ -d "/var/www/html/wordpress" ]; then
     echo "Wordpress already installed. Create backup config file and update Database password.";
     deploy_wp_site "$DB_USER"
else
	echo "Wordpress is not installed. Start fresh install."
    deploy_wp_site "$DB_USER"
fi


printf "Wordpress has been deployed on $HOST.\nPlease visit http://$LOCAL_IP/wp-admin/ \n
        Username: $WP_USER\nPassword: $WP_PASSWORD\n"

send_email "Wordpress has been deployed on $HOST.\nPlease visit http://$LOCAL_IP/wp-admin/ \n
        Username: $WP_USER\nPassword: $WP_PASSWORD\n"



