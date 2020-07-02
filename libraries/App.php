<?php
use WoohooLabs\Harmony\Harmony;

class App
{
	private static $container;

	public static function run() {
		$containerBuilder = new \DI\ContainerBuilder;
		$dir = new \RecursiveDirectoryIterator(CONFIGS_DIR);
		$ite = new \RecursiveIteratorIterator($dir);
		$fileList = [];
		foreach($ite as $file) {
			if (is_file($p = $file->getPathname())) $containerBuilder->addDefinitions($p);
		}
		self::$container = $containerBuilder->build();

		App::get(Harmony::class)->run();
	}

	public static function getContainer() {
		return self::$container;
	}

	public static function get($k) {
		return self::$container->get($k);
	}

	public static function set($k, $v) {
		self::$container->set($k, $v);
	}

	public static function has($k) {
		return self::$container->has($k, $v);
	}

	public function __get($k) {
		return self::get($k);
	}

	public function __set($k, $v) {
		return self::set($k, $v);
	}

	public function __isset($k) {
		return self::has($k);
	}
}