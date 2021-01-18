<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en « wp-config.php » et remplir les
 * valeurs.
 *
 * Ce fichier contient les réglages de configuration suivants :
 *
 * Réglages MySQL
 * Préfixe de table
 * Clés secrètes
 * Langue utilisée
 * ABSPATH
 *
 * @link https://fr.wordpress.org/support/article/editing-wp-config-php/.
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define( 'DB_NAME', 'wordpress' );

/** Utilisateur de la base de données MySQL. */
define( 'DB_USER', 'wordpress_user' );

/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'password' );

/** Adresse de l’hébergement MySQL. */
define( 'DB_HOST', 'localhost' );

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define( 'DB_CHARSET', 'utf8' );

/**
 * Type de collation de la base de données.
 * N’y touchez que si vous savez ce que vous faites.
 */
define( 'DB_COLLATE', '' );

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clés secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'lZ!J}m#)R;K2wnd&@SuKwljT6RQ64^-+ikmoJe(!eN?7bRMC.9m0hNn,}|Pg%E~l');
define('SECURE_AUTH_KEY',  ';bQ%A;+j-/OJ-*K,-<UDF(~Fs:YJNN9AX|-OH l{gkjK!V%ASqD|iI^65?!S[?ky');
define('LOGGED_IN_KEY',    'zXdj[g{Q?~5ubF<.`<U/j~v~YKs6YYEYz%qA^UV]m)Ay`Jm^A^o]zk^Maz.*t@`c');
define('NONCE_KEY',        'cYuc6ro+oB2G]+Gm%fr+4*5|9!yU/+&W`)WUix{}y!?c@(.+rZqf_]pWfMb?=+KR');
define('AUTH_SALT',        'UNC~Umj=*x-9FgeXEBf]yGbUOp6hs_%d-J_7nO8>B1Cz1}lc+jwxo_Nt|BcIAG`|');
define('SECURE_AUTH_SALT', 'RvEf|D#q`/<rX|1~1DT>V:+-/^Ko^<Kh7Gpn-y*b-2?2T+XCQ$);xMu)FADN<L$f');
define('LOGGED_IN_SALT',   'NNaDc+SOA-nk?&ossN4YOW{jTQl}K GoCH6uEDSQbw]oGco}FQq0t.Fs=<XFmj|F');
define('NONCE_SALT',       '7K.e=0|p^:hZZ TvGdmPj79h1e0}BDW&23[<Rr]wjf[~U]TK>u:5Qzlfb(#0{G>&');
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortement recommandé que les développeurs d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur le Codex.
 *
 * @link https://fr.wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( ! defined( 'ABSPATH' ) )
  define( 'ABSPATH', dirname( __FILE__ ) . '/' );

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once( ABSPATH . 'wp-settings.php' );
