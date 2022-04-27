<?php
# Simplified from https://github.com/docker-library/wordpress/blob/master/wp-config-docker.php
# French explanations about this file : https://fr.wordpress.org/support/article/editing-wp-config-php/

/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * This has been slightly modified (to read environment variables) for use in Docker.
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

 // a helper function to lookup "env", then fallback
// slightly modify for this exercice
if (!function_exists('getenv_docker')) {
	// https://github.com/docker-library/wordpress/issues/588 (WP-CLI will load this file 2x)
	function getenv_docker($env, $default) {
	if (($val = getenv($env)) !== false) {
			return $val;
		}
		else {
			return $default;
		}
	}
}

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv_docker('WORDPRESS_DB_NAME', 'mariadb') );

/** Database username */
define( 'DB_USER', getenv_docker('WORDPRESS_DB_USER', 'wordpress') );

/** Database password */
define( 'DB_PASSWORD', getenv_docker('WORDPRESS_DB_PWD', '?Ran0mPa55W0Rd!') );

/** Database hostname */
define( 'DB_HOST', getenv_docker('WORDPRESS_DB_HOST', 'mariadb') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', getenv_docker('WORDPRESS_DB_CHARSET', 'utf8') );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', getenv_docker('WORDPRESS_DB_COLLATE', '') );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ' 2OS8Vk%j{VGss W2;rP?,HO1XnKC/@T{YyI F+{RQgSKY|:sjO%32L;^=MFymZ^');
define('SECURE_AUTH_KEY',  '[%n:Kxm=M@El|zOk~FT8[,|&7PF(g,bf$`.j7|<E!bGf<Jd`KkAzRHJMvylBoFwv');
define('LOGGED_IN_KEY',    'xW?xRP.~wfQeAPF3qpyhEOz3aDlG+r*+&b0%TSCRzhJ 0eC7|UbnD%+Wx9=Ns|CA');
define('NONCE_KEY',        'p5_o}&+QYB3A37.f:Y}wTyQ&%90G5p@~!>NX=A@d62B:~wEkL-y|:l)>S{O|~/yd');
define('AUTH_SALT',        'Mgv!~:|p!nI_LPVa$d3Bv,1pV4xY0$*^.Hqa_an4y^a5-R*<]39L_nj?U:*{]qtd');
define('SECURE_AUTH_SALT', 't2GD+:uqV:WA1jb-|O+BEqbO?5ZE LccgeJD%x-!J}8)TF?#5*:/$bZk+82@D|nH');
define('LOGGED_IN_SALT',   '|b:-#3*>_p$A2G1q/]dS._@>+-f|Q_.hx@-G{F%v=nP<2ZIaGlkHIVGvQNK<}t$F');
define('NONCE_SALT',       'w+x`$nY:Q;A-OSzmpHj)wUzcjX>9X2-lQo~0I7^E!0$|pgI}uwkN#Vt(l7&N_<tP');
// (See also https://wordpress.stackexchange.com/a/152905/199287)

/**
 * WordPress database table prefix.
 */
$table_prefix = getenv_docker('WORDPRESS_TABLE_PREFIX', 'wp_');

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

