<?php 
namespace RBAC\Roles;

use RBAC\{
	Roles\Role,
	Collection as RBACCollection
};

class Collection extends RBACCollection {
	public function s(Role $role) {
		$this->offsetSet(get_class($role), $role);
		return $this;
	}
}