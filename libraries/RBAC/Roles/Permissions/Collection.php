<?php
namespace RBAC\Roles\Permissions;

use RBAC\{
	Roles\Permissions\Permission,
	Collection as RBACCollection
};

class Collection extends RBACCollection {
	public function s($permission) {
		if (is_string($permission)) {
			$this->offsetSet($permission, new Permission);
		} elseif (is_array($permission)) {
			list($className, $method) = $permission;
			$this->offsetSet($className.'::'.$method, new Permission);
		}
		elseif ($permission instanceof Permission) {
			$this->offsetSet(get_class($permission), $permission);
		}
		return $this;
	}
}