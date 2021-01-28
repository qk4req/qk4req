<?php
use Lcobucci\ContentNegotiation\{
	ContentTypeMiddleware,
	Formatter\StringCast,
	Formatter\Json
};

use Laminas\HttpHandlerRunner\Emitter\SapiEmitter;
use Laminas\Diactoros\{
	StreamFactory,
	ResponseFactory
};
use WoohooLabs\Harmony\Middleware\{
	//FastRouteMiddleware,
	//DispatcherMiddleware,
	HttpHandlerRunnerMiddleware
};
use Middlewares\{
	FastRouteMiddleware,
	ErrorHandler,
	PhpSession,
	AuthMiddleware,
	DispatcherMiddleware
};

return [
	'middlewares'=>[
		HttpHandlerRunnerMiddleware::class,
		ErrorHandler::class,
		FastRouteMiddleware::class,
		PhpSession::class,
		AuthMiddleware::class,
		DispatcherMiddleware::class,
		ContentTypeMiddleware::class
	]
];
