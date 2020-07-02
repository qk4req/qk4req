<?php
namespace RBAC\Roles;

use Controllers\API;

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
				API\DonationsController::class,
				API\FollowersController::class,
				API\SubscriptionsController::class,
				API\OnPublishController::class,
				\Controllers\ChannelController::class
			]
		),
		new User(
			[\Controllers\ChannelController::class]
		),
		new Admin(
			[\Controllers\ChannelController::class]
		),
		new Broadcaster(
			[
				\Controllers\OnPublishController::class,
				\Controllers\ChannelController::class
			]
		)
	])
];