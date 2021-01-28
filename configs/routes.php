<?php
use \FastRoute\RouteCollector;
use \Controllers\API;
use \Controllers\Widgets;

return [
	'routes'=>\FastRoute\simpleDispatcher(function(RouteCollector $a) {
		$a->addGroup('/api', function (RouteCollector $b) {
			$b->addRoute('GET', '/donations[/{what:last|top}]', API\DonationsController::class);
			$b->addRoute('GET', '/followers', API\FollowersController::class);
			$b->addRoute('GET', '/subscriptions', API\SubscriptionsController::class);


			$b->addGroup('/votings', function(RouteCollector $c) {
				$c->addRoute('GET', '/', [API\VotingsController::class, 'last']);
				$c->addRoute('GET', '/points[/{votingID:\d+}]', API\VotingPointsController::class);
				$c->addRoute('GET', '/vote[/{votingID:\d+}]', API\VoteController::class);
			});
		});
		$a->addGroup('/widgets', function (RouteCollector $b) {
			$b->addRoute('GET', '/header', Widgets\HeaderController::class);
			$b->addRoute('GET', '/events', Widgets\EventsController::class);
			$b->addRoute('GET', '/olezha', Widgets\OlezhaController::class);
			$b->addRoute('GET', '/banner', Widgets\OlezhaController::class);
			$b->addRoute('GET', '/stakan', Widgets\StakanController::class);
		});
		$a->get('/events', \Controllers\EventsController::class);
	})
];