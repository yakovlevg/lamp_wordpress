# Установка LAMP (Apache, php, maria-db), nginx в качестве reverse proxy и предустановленного Wordpress.
Установка настройка wordpress производиться при помощи утилиты [wp-cli] (https://wp-cli.org)

# Требования:
  Данная установка производиться локально. На сервере должен быть установлен ansible
  ```
  apt-get update
  apt-get install python3 python3-pip
  pip install ansible

  ```

# Установка

1. Клонируйте репозиторий на сервер, где будет производиться установка Wordpress
```
    git clone https://github.com/yakovlevg/lamp_wordpress.git
    cd vizor_tz/
    git checkout task2

```

2. Отредактируйте файл 'ansible/group_vars/vars.yaml`  следующего содержания:

```
mysql_root_password: "mysql root password"
db_user: wordpress
db_pwd: "db wordpress user password"
web_user: "www-data"
wp_admin_user: "admin"
wp_admin_pwd: "dfe$$vvf"
wp_admin_email: "wp_admin_email"
smtp_username: "smtp username"
smtp_pwd: "smtp password"


```
3. Запустите скрипт:

```
ansible-playbook ansible/wordpress.yaml

или

chmod +x deploy-wordpress.sh && ./deploy-wordpress.sh

```
4. Дождитесь окончания установки. Учетные данные будут доступны после выполнения скрипта и отправлены по почте



### ToDo
 - запуск playbook на любом Linux дистрибутиве
 - Отправка уведомления об ошибке выполнения скрипта на любом из этапов установки.


