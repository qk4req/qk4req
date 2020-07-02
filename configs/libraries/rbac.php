<?php
use RBAC\AccessControl;

return [
	AccessControl::class => \DI\create(AccessControl::class)->constructor(\DI\get('roles'))	
];