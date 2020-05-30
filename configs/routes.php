<?php
use \FastRoute\RouteCollector;
use \Controllers\API;

return [
	'routes'=>\FastRoute\simpleDispatcher(function(RouteCollector $r) {
		$r->get('/', \Controllers\HomeController::class);
		$r->get('/events', \Controllers\EventsController::class);
		$r->addRoute('GET', '/anal', \Controllers\ChannelController::class);
		$r->addGroup('/channel', function (RouteCollector $r) {
			$r->addRoute('GET', '', \Controllers\ChannelController::class);
		});
		$r->addGroup('/on', function (RouteCollector $r) {
			$r->addRoute('GET', '/publish', \Controllers\OnPublishController::class);
			$r->addRoute('GET', '/play', \Controllers\OnPlayController::class);
		});
		$r->get('/tops', \Controllers\TopsController::class);
		$r->get('/olezha', \Controllers\OlezhaController::class);
	})
];