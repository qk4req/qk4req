<?php
use Providers\{
	JWTProvider as JWT,
	AssetterProvider as Assetter
};

return [
	JWT::class 		=> function() {
		list($key, $alg) = array_values(App::get('jwt'));
		return new JWT($key, $alg);
	},
	Assetter::class => \DI\autowire()->constructor(ASSETS_DIR, '.assets', 788823223)->method('registerNamespace', '{ROOT}', '/assets')
];