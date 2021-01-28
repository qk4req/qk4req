<?php
namespace MVC\Model;

abstract class Entity {
	public function toArray() {
		return get_object_vars($this);
	}
}