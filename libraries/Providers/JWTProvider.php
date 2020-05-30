<?php
namespace Providers;

use Firebase\JWT\JWT;

class JWTProvider {
	const ALGORITHM = 'HS384';
	protected $key;
	protected $alg;

	public function __construct($key, $alg = self::ALGORITHM) {
		$this->key = $key;
		$this->alg = $alg;
	}

	public function en ($payload) {
		return JWT::encode($payload, $this->key, $this->alg);
	}

	public function de ($jwt, $assoc = false) {
		$data = JWT::decode($jwt, $this->key, [$this->alg]);
		return $assoc ? $data : (object) $data;
	}

	public function verify ($jwt) {
		try {
			JWT::decode($jwt, $this->key, [$this->alg]);
			return true;
		} catch (\Exception $e) {
			return false;
		}
	}
}