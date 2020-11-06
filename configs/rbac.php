<?php
namespace RBAC\Roles;

use Controllers\Widgets\{
	HeaderController,
	EventsController,
	OlezhaController
};
use Controllers\API\{
	DonationsController,
	FollowersController,
	SubscriptionsController,
	OnPublishController
};

use RBAC\Roles\{
	Role,
	Guest,
	Collection as Roles,
};
use RBAC\Roles\Permissions\{
	Permission,
	Collection as Permissions
};

class User extends Role {
	protected $synonyms = ['u', 'user'];
}

class Admin extends User {
	protected $synonyms = ['a', 'admin'];
}

class Broadcaster extends Admin {
	protected $synonyms = ['b', 'broadcaster'];
}

return [
	'roles' => new Roles([
		new Guest(
			[
				DonationsController::class,
				FollowersController::class,
				SubscriptionsController::class,
				//OnPublishController::class,
				HeaderController::class,
				EventsController::class,
				OlezhaController::class,
				\Controllers\EventsController::class
			]
		),
		new User(
			[]
		),
		new Admin(
			[]
		),
		new Broadcaster(
			[]
		)
	])
];