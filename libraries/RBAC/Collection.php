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

	public function g($key) {
		return $this->offsetGet($this->getIndex($key));
	}

	public function u($key) {
		$this->offsetUnset($this->getIndex($key));
		return $this;
	}

	public function e($key) {
		return $this->offsetExists($this->getIndex($key));
	}

	private function root($key) {
		if (strpos($key, '::')) {
			list($className, $method) = explode('::', $key);
			foreach ($this->getIterator() as $i => $el) {
				if ($i === $className) return $i;
			}
			return false;
		} else return false;
	}

	private function synonym($synonym, $def = null) {
		if (strpos($synonym, '\\') === false) {
			foreach ($this->getIterator() as $i => $el) {
				if ($el->hasSynonym($synonym)) return $i;
			}
			return $def;
		} else return $def;
	}

	private function getIndex($key) {
		$key = $this->normalizeKey($key);
		return ($i = $this->root($key)) ? $i : $this->synonym($key, $key);
	}

	private function normalizeKey($key) {
		if (is_array($key)) {
			list($className, $method) = $key;
			$key = $className.'::'.$method;
		} elseif (is_string($key)) {
		}
		return $key;
	}
}