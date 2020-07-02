<?php
use Doctrine\ORM;

return [
	ORM\EntityManager::class => function() {
		$isDevMode = true;
		$proxyDir = null;
		$cache = null;
		$useSimpleAnnotationReader = false;
		$config = ORM\Tools\Setup::createAnnotationMetadataConfiguration(array(__DIR__."/src"), $isDevMode, $proxyDir, $cache, $useSimpleAnnotationReader);
		return ORM\EntityManager::create(App::get('db'), $config);
	},
	ORM\Configuration::class => \DI\create(ORM\Configuration::class)
];