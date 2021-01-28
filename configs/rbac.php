<?php
namespace RBAC\Roles;

use Controllers\{
	EventsController
};
use Controllers\Widgets\{
	HeaderController as HeaderWidgetController,
	EventsController as EventsWidgetController,
	OlezhaController as OlezhaWidgetController,
	StakanController as StakanWidgetController
};
use Controllers\API\{
	DonationsController as DonationsAPIController,
	FollowersController as FollowersAPIController,
	SubscriptionsController as SubscriptionsAPIController,
	VotingsController as VotingsAPIController,
	VotingPointsController as VotingPointsAPIController,
	VoteController as VoteAPIController,
	//OnPublishController as OnPublishAPIController
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
				DonationsAPIController::class,
				FollowersAPIController::class,
				SubscriptionsAPIController::class,
				VotingsAPIController::class,
				VotingPointsAPIController::class,
				VoteAPIController::class,

				//OnPublishAPIController:class,
				HeaderWidgetController::class,
				EventsWidgetController::class,
				OlezhaWidgetController::class,
				StakanWidgetController::class,

				EventsController::class
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