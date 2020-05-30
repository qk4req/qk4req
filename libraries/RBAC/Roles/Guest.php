<?php 
namespace RBAC\Roles;

use RBAC\{
	Roles\Role
};

final class Guest extends Role {
	protected $synonyms = ['g', 'guest'];
}