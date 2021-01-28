<?php
use Laminas\Diactoros\{
	Response,
	ServerRequest,
	StreamFactory,
	HttpHandlerRunner\Emitter\SapiEmitter
};
use WoohooLabs\Harmony\Harmony;
use WoohooLabs\Harmony\Middleware\{
	//FastRouteMiddleware,
	//DispatcherMiddleware,
	HttpHandlerRunnerMiddleware
};
use Middlewares\{
	ErrorHandler,
	PhpSession,
	AuthMiddleware,
	FastRouteMiddleware,
	DispatcherMiddleware
};
use Lcobucci\ContentNegotiation\{
	ContentTypeMiddleware,
	Formatter\StringCast as SCFormat,
	Formatter\Json as JFormat
};

return [
	Harmony::class 							=> function () {
		$harmony = new Harmony(App::get(ServerRequest::class), App::get(Response::class));
		$middlewares = App::get('middlewares');
		foreach ($middlewares as $middleware) {
			$harmony->addMiddleware(App::get($middleware));
		};
		return $harmony;
	},
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