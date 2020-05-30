<?php 
namespace RBAC;

use ArrayObject;

abstract class Collection extends ArrayObject {
	public function __construct(array $arr) {
		if (!empty($arr)) {
			foreach ($arr as $value) {
				$this->s($value);
			}
		}
	}

	public function g($name) {
		return $this->offsetGet($this->getIndexBySynonym($name, $name));
	}

	public function u($name) {
		$this->offsetUnset($this->getIndexBySynonym($name, $name));
		return $this;
	}

	public function e($name) {
		return $this->offsetExists($this->getIndexBySynonym($name, $name));
	}

	public function getIndexBySynonym($synonym, $def = null) {
		if (strpos($synonym, '\\') === false) {
			foreach ($this->getIterator() as $i=>$el) {
				if ($el->hasSynonym($synonym)) return $i;
			}
			return $def;
			;
		} else return $def;
	}
}