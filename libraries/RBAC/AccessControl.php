<?php
namespace RBAC;

use RBAC\Roles\{
	Role,
	Collection
};

class AccessControl {
	private $roles;

	public function __construct(Collection $roles) {
		$this->roles = $roles;
	}

	public function getRoles() {
		return $this->roles;
	}

	public function hasRole($name) {
		if (is_object($name)) $name = get_class($name);
		return $this->roles->e($name);
	}

	public function addRole(Role $role) {
		$this->roles->s($role);
		return $this;
	}

	public function role($name) {
		return $this->roles->g($name);
	}
}