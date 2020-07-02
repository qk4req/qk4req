<?php 
use Twig\{Environment, Loader\LoaderInterface, Loader\FilesystemLoader};

return [
	LoaderInterface::class 			=> \DI\create(FilesystemLoader::class)->constructor(ASSETS_DIR.'/templates'),
	Environment::class 				=> \DI\autowire(),
];