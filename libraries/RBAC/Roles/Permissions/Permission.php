<?php 
namespace RBAC\Roles\Permissions;

use RBAC\Synonyms;

class Permission {
	use Synonyms;
	
	public function __construct($synonyms = null) {
		$this->synonyms = $synonyms;
	}
}