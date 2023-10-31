<?php
/**
 * Основные параметры WordPress.
 *
 * Скрипт для создания wp-config.php использует этот файл в процессе установки.
 * Необязательно использовать веб-интерфейс, можно скопировать файл в "wp-config.php"
 * и заполнить значения вручную.
 *
 * Этот файл содержит следующие параметры:
 *
 * * Настройки базы данных
 * * Секретные ключи
 * * Префикс таблиц базы данных
 * * ABSPATH
 *
 * @link https://ru.wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Параметры базы данных: Эту информацию можно получить у вашего хостинг-провайдера ** //
/** Имя базы данных для WordPress */
define( 'DB_NAME', 'wp' );

/** Имя пользователя базы данных */
define( 'DB_USER', 'root' );

/** Пароль к базе данных */
define( 'DB_PASSWORD', 'root' );

/** Имя сервера базы данных */
define( 'DB_HOST', 'mysqldb' );

/** Кодировка базы данных для создания таблиц. */
define( 'DB_CHARSET', 'utf8mb4' );

/** Схема сопоставления. Не меняйте, если не уверены. */
define( 'DB_COLLATE', '' );

/**#@+
 * Уникальные ключи и соли для аутентификации.
 *
 * Смените значение каждой константы на уникальную фразу. Можно сгенерировать их с помощью
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ сервиса ключей на WordPress.org}.
 *
 * Можно изменить их, чтобы сделать существующие файлы cookies недействительными.
 * Пользователям потребуется авторизоваться снова.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '<p(+IG>9P8T/g/PNt>T4#;y.i!)*Xg3?SAtpOl&VU}#,t*?+a_bw:E}`(LK.8*Dd' );
define( 'SECURE_AUTH_KEY',  'KksR.W,8bdAJ!3>lehF))<4vj}D6?NMyL4my|Yr~u4|h#5qeC$s8C+=KIkjgGmz}' );
define( 'LOGGED_IN_KEY',    'WmEp~EQ|Fo JX^ojE@xs^y9L5B2 NTq 7@A!W6p0?9<]CM$1w)2(qIrd#%lg,;c0' );
define( 'NONCE_KEY',        'Bv$POlVJi?{sqp*y.9f;7[OoaHD]V,($-47vFpp.2v0QH{p(P,&]wT,L1]vM9^F=' );
define( 'AUTH_SALT',        '{F!(!!RhX=/RAaHmVJCgd/`d~y_ZcG%e7q@dL@R>Q&H=yf(9rx%__]JMge+iE3Ek' );
define( 'SECURE_AUTH_SALT', '.a:1sJi(pGet}cJR}9oVF9Zg6|_V>%csU):/ckF}CQ/!m>-Ktm,rIY795m;YL2N0' );
define( 'LOGGED_IN_SALT',   'n)~6Sj~=-qw&?LB%UgSTm;I5vz}b>-B1/%E}PyO&L)LZNK>TSJhv@#3hTO]E-sOR' );
define( 'NONCE_SALT',       '>&DCeVKGfn:(m87]&qC_@Uo6CI@ g8dJfp|*2SOt9GWJ.N=.j}}sW{%tO>Apl @^' );

/**#@-*/

/**
 * Префикс таблиц в базе данных WordPress.
 *
 * Можно установить несколько сайтов в одну базу данных, если использовать
 * разные префиксы. Пожалуйста, указывайте только цифры, буквы и знак подчеркивания.
 */
$table_prefix = 'wp_';

/**
 * Для разработчиков: Режим отладки WordPress.
 *
 * Измените это значение на true, чтобы включить отображение уведомлений при разработке.
 * Разработчикам плагинов и тем настоятельно рекомендуется использовать WP_DEBUG
 * в своём рабочем окружении.
 *
 * Информацию о других отладочных константах можно найти в документации.
 *
 * @link https://ru.wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Произвольные значения добавляйте между этой строкой и надписью "дальше не редактируем". */



/* Это всё, дальше не редактируем. Успехов! */

/** Абсолютный путь к директории WordPress. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Инициализирует переменные WordPress и подключает файлы. */
require_once ABSPATH . 'wp-settings.php';
