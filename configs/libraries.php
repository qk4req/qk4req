<?php
use Laminas\Diactoros\{Response, ServerRequestFactory};
use WoohooLabs\Harmony\Harmony;
use Twig\{Environment, Loader\LoaderInterface, Loader\FilesystemLoader};
use Doctrine\ORM;
use inouet\FileCache;
use Curl\Curl;
use KHerGe\JSON\JSON;
use RBAC\AccessControl;

//PROVIDERS
use Providers\{
	JWTProvider as JWT,
	AssetterProvider as Assetter
};

//MIDDLEWARES
use Lcobucci\ContentNegotiation\{
	ContentTypeMiddleware,
	Formatter\StringCast as SCFormat,
	Formatter\Json as JFormat
};

use Laminas\HttpHandlerRunner\Emitter\SapiEmitter;
use Laminas\Diactoros\{
	StreamFactory,
	ResponseFactory
};
use WoohooLabs\Harmony\Middleware\{
	FastRouteMiddleware,
	DispatcherMiddleware,
	HttpHandlerRunnerMiddleware
};
use Middlewares\{
	ErrorHandler,
	PhpSession,
	AuthMiddleware
};

return [
	Harmony::class 					=> function () {
		$harmony = new Harmony(App::get(ServerRequest::class), App::get(Response::class));
		$middlewares = App::get('middlewares');
		foreach ($middlewares as $middleware) {
			$harmony->addMiddleware(App::get($middleware));
		};
		return $harmony;
	},
	ServerRequest::class 			=> function () {
		return ServerRequestFactory::fromGlobals();
	},
	Response::class 				=> \DI\create(Response::class),
	LoaderInterface::class 			=> \DI\create(FilesystemLoader::class)->constructor(ASSETS_DIR.'/templates'),
	Environment::class 				=> \DI\autowire(),
	JWT::class 						=> function() {
		list($key, $alg) = array_values(App::get('jwt'));
		return new JWT($key, $alg);
	},
	Assetter::class 				=> \DI\autowire()->constructor(ASSETS_DIR, '.assets', 6767222322222222222222222222222222222222222222222222222222)->method('registerNamespace', '{ROOT}', '/assets'),

	JSON::class 					=> \DI\create(JSON::class),
	ORM\EntityManager::class 		=> function() {
		$isDevMode = true;
		$proxyDir = null;
		$cache = null;
		$useSimpleAnnotationReader = false;
		$config = ORM\Tools\Setup::createAnnotationMetadataConfiguration(array(__DIR__."/src"), $isDevMode, $proxyDir, $cache, $useSimpleAnnotationReader);
		return ORM\EntityManager::create(App::get('db'), $config);
	},
	//ORM\EntityManager::class 		=> \DI\factory([EntityManager::class, 'create'])->parameter('connection', \DI\get('db')),
																					//->parameter('config', \DI\get('')),
	ORM\Configuration::class 		=> \DI\create(ORM\Configuration::class),
	//DBAL\Connection::class 			=> function() {
	//	return DBAL\DriverManager::getConnection(App::get('db'), App::get(DBAL\Configuration::class));
	//},
	//DBAL\Query\QueryBuilder::class 			=> \DI\autowire(),
	AccessControl::class 					=> \DI\create(AccessControl::class)->constructor(\DI\get('roles')),
	SapiEmitter::class 						=> \DI\create(SapiEmitter::class),
	HttpHandlerRunnerMiddleware::class 		=> \DI\autowire(),
	ContentTypeMiddleware::class 			=> function () {
		return ContentTypeMiddleware::fromRecommendedSettings(
		[
			'json',
			'html' => [
				'extension' => ['html', 'htm', 'php'],
				'mime-type' => ['text/html', 'application/xhtml+xml'],
				'charset' => true
			],
		],
		[
			'application/json' => new JFormat,
			'text/html'		=> new SCFormat
		],
		new StreamFactory);
	},
	ErrorHandler::class 					=> \DI\create(ErrorHandler::class),
	FastRouteMiddleware::class 				=> \DI\create(FastRouteMiddleware::class)->constructor(\DI\get('routes')),
	PhpSession::class 						=> \DI\create(PhpSession::class),
	AuthMiddleware::class 					=> \DI\autowire(),
	DispatcherMiddleware::class 			=> function () {
		return new DispatcherMiddleware(App::getContainer());
	}
];
