<?php
define('BASE_DIR', __DIR__.'/');
define('ASSETS_DIR', BASE_DIR.'assets/');
define('LIBRARIES_DIR', BASE_DIR.'libraries/');
define('CONTROLLERS_DIR', BASE_DIR.'controllers/');
define('MODELS_DIR', BASE_DIR.'models/');
define('VIEWS_DIR', BASE_DIR.'views/');
define('CONFIGS_DIR', BASE_DIR.'configs/');
define('DATA_DIR', BASE_DIR.'data/');



require_once(LIBRARIES_DIR.'Autoloader.php');
App::run();
?>