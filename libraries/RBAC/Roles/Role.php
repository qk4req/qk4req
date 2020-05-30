<?php 
namespace RBAC\Roles;

use RBAC\{
	Synonyms,
	Roles\Permissions\Permission,
	Roles\Permissions\Collection
};

abstract class Role {
	use Synonyms;
	private $permissions;

	public function __construct($permissions) {
		if (is_array($permissions)) {
			$this->permissions = new Collection($permissions);
		} elseif ($permissions instanceof Collection) {
			$this->permissions = $permissions;
		}
	}

	public function getPermissions() {
		return $this->permissions;
	}

	public function hasPermission($permission) {
		return $this->permissions->e($permission);
	}

	public function addPermission(Permission $permission) {
		$this->permissions->s($permission);
		return $this;
	} 

	public function permission($name) {
		return $this->permissions->g($name);
	}
}