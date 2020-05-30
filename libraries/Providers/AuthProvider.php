<?php
namespace Providers;

class AuthProvider {
	public $isGuest = true;
	public $user = null;

	public function __construct($isGuest, ?StdClass $user = null) {
		$this->isGuest = $isGuest;
		$this->user = $user;
	}

	public function isGuest() {
		return $this->isGuest;
	}

	public function user () {
		return $this->user;
	}
}