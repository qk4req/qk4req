<?php
namespace RBAC\Roles;

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
			[\Controllers\OnPublishController::class]
		),
		new User(
			[\Controllers\OnPublishController::class]
		),
		new Admin(
			[\Controllers\OnPublishController::class]
		),
		new Broadcaster(
			[\Controllers\OnPublishController::class]
		)
	])
];