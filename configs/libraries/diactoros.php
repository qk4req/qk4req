<?php
use Psr\Http\Message\ServerRequestInterface;
use Laminas\Diactoros\{
	ServerRequest,
	ServerRequestFactory,
	Response,
	//Response\EmptyResponse,
	//Response\HtmlResponse,
	//Response\JsonResponse,
	//Response\RedirectResponse,
};

return [
	ServerRequest::class 	=> function () {
		return ServerRequestFactory::fromGlobals();
	},
	Response::class 				=> \DI\create(Response::class),
	//EmptyResponse::class 			=> \DI\create(EmptyResponse::class),
	//HtmlResponse::class 			=> \DI\create(HtmlResponse::class),
	//JsonResponse::class 			=> \DI\create(JsonResponse::class),
	//RedirectResponse::class 		=> \DI\create(RedirectResponse::class)
];