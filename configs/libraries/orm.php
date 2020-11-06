<?php
use Doctrine\ORM;
use Doctrine\DBAL\Types\Type;
use Extensions\Doctrine\DBAL\Types\UTCDateTimeType;

Type::overrideType('datetime', UTCDateTimeType::class);
Type::overrideType('datetimetz', UTCDateTimeType::class);

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