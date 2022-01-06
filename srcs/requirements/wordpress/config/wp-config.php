<?php
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('MARIADB_DB'));

/** MySQL database username */
define( 'DB_USER', getenv('MARIADB_USER') );

/** MySQL database password */
define( 'DB_PASSWORD', getenv('MARIADB_PWD'));

/** MySQL hostname */
define( 'DB_HOST', getenv('MARIADB_HOST') );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'A}EG$1$2(0eOwmdLbjd=v!=;BZow[gM*/>V M!%NeRZ!$WJm3$aDr(-KM}KmM[|q' );
define( 'SECURE_AUTH_KEY',  'm&}dz^YR@ anx<IC<D8c1{!h4%LF:L58l>&D@H;=U9I;WAyNn0SX-1duw`+H>gOP' );
define( 'LOGGED_IN_KEY',    'Jh:(b0w~,SXk}YynD`Xguw0+`b5?vw@+*a6:Y~2@5LMR[^CMCQ_: rZp+LnWn|i}' );
define( 'NONCE_KEY',        'Lp$Q/SM|,o2[ac[[CP=j/3R|5 !!jlyRYp5Dq={*xRZumbHK!D&I7ntka*V$}cm?' );
define( 'AUTH_SALT',        'kFTLZ}Z>Tf%gh:vPX7UHcy=nO}7}^b2v.lr>tv;n$F&e+lnoWKN_w|kDXtCVc24{' );
define( 'SECURE_AUTH_SALT', 'I/`[q:bOuC/<*(73)eIH?7zjkpjqd<8-{]%/zRLtq,,#Qmcl}OHV|li0[_y{lgJ(' );
define( 'LOGGED_IN_SALT',   'A`F|uO.8F9m%w=1.vaQc@U:OL*g!lMfX>zthNO7Wz~KpbR=ITm.D8:=F,5H#Nd]2' );
define( 'NONCE_SALT',       'IRtcL-1#1<3pK2[bqs<tV6yc&sqKq_OC<bE@Hc-sWU_S<gCk9j!Kp(INc47!HIcX' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
