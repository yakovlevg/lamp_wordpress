# Установка LAMP (Apache, php, maria-db), nginx в качестве reverse proxy и предустановленного Wordpress.
Установка настройка wordpress производиться при помощи утилиты [wp-cli] (https://wp-cli.org)

# Требования:
  Скрипт в данный момент работает только дистрибутивах Linux, основанные на Debian (тестирование проводилось на Debian 11)

# Установка

1. Клонируйте репозиторий на сервер, где будет производиться установка Wordpress
```
    git clone https://github.com/yakovlevg/vizor_tz.git
    cd vizor_tz/
    git checkout task1

```

2. Создайте файл .env в данной директории следующего содержания:

```
SERVER="smtp.example.com"
FROM="sender@example.com"
TO="reciever@example.com"
SUBJ="Wordpress install"
CHARSET="utf-8"
PASSWORD="smtp_password"
```
3. Запустите скрипт:

```
bash lamp-install.sh

или 

chmod +x lamp-install.sh && ./lamp-install.sh

```
4. Дождитесь окончания установки. Учетные данные будут доступны после выполнения скрипта и отправлены по почте

## Или можно запустить скрипт непосредственно с гит репозитория, предварительно выполнив п.2 в директории, откуда будет выполняться скрипт.

```
wget -O - https://raw.githubusercontent.com/yakovlevg/vizor_tz/feature/task1/lamp-install.sh | bash

```
### Важно
Пароли для базы данных и админ панели меняются при каждом запуске скрипта!

### ToDo
 - запуск скрипта на любом Linux дистрибутиве
 - Отправка уведомления об ошибке выполнения скрипта на любом из этапов установки.


