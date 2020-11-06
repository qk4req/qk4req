<?php
require_once __DIR__.'/vendor/autoload.php';

class Autoloader extends \Composer\Autoload\ClassLoader
{
	public function __construct() {
		$this->addClassmap(['App'=>LIBRARIES_DIR.'App.php']);
		$psr4 = [
			'Controllers\\'=>[CONTROLLERS_DIR],
			'Models\\'=>[MODELS_DIR],
			'Views\\'=>[VIEWS_DIR],
			'MVC\\'=>[LIBRARIES_DIR.'MVC'],
			'RBAC\\'=>[LIBRARIES_DIR.'RBAC'],
			'Middlewares\\'=>[LIBRARIES_DIR.'Middlewares'],
			'Providers\\'=>[LIBRARIES_DIR.'Providers'],
			'Extensions\\'=>[LIBRARIES_DIR.'Extensions'],
		];
		foreach ($psr4 as $ns=> $p) $this->setPsr4($ns, $p);
		$this->register();
	}
}

new Autoloader;