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
			$r->addRoute('GET', '/publish', API\OnPublishController::class);
			$r->addRoute('POST', '/play', API\OnPlayController::class);
		});
		$r->addGroup('/api', function (RouteCollector $r) {
			$r->addGroup('/donations', function(RouteCollector $rr) {
				$rr->addRoute('GET', '/last', [API\DonationsController::class, 'last']);
				$rr->addRoute('GET', '/top', [API\DonationsController::class, 'top']);
			});
			$r->addRoute('GET', '/followers', API\FollowersController::class);
			$r->addRoute('GET', '/subscriptions', API\SubscriptionsController::class);
		});
		$r->get('/header', \Controllers\HeaderController::class);
		$r->get('/olezha', \Controllers\OlezhaController::class);
	})
];