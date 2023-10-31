# Установка LAMP (Apache, php, maria-db), nginx в качестве reverse proxy и предустановленного Wordpress.
Установка настройка wordpress производиться при помощи утилиты [wp-cli] (https://wp-cli.org)

# Требования:
  Скрипт в данный момент работает только дистрибутивах Linux, основанные на Debian (тестирование проводилось на Debian 11)
  На машине долже быть установлен docker и docker-compose

# Установка

1. Клонируйте репозиторий на сервер, где будет производиться установка Wordpress
```
    git clone https://github.com/yakovlevg/vizor_tz.git
    cd vizor_tz/
    git checkout task3
    docker-compose up

```

# Важно
 Данная БД и сайт ТЕСТОВЫЕ!
 
Данное решение можно использовать для локальной разработки.




