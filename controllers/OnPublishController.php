<?php
namespace Controllers;

use App, MVC\Controller, Models\UserModel;
use Laminas\Diactoros\{ServerRequest, Response};
use Doctrine\ORM\EntityManager;

class OnPublishController extends Controller {
	public function __invoke(ServerRequest $request, Response $response): Response
	{
		$auth = App::get(\Providers\AuthProvider::class);
		$model = App::get(UserModel::class);
		$entityManager = App::get(EntityManager::class);
		$repo = $entityManager->getRepository(get_class($model));
		//var_dump($repo->findAll());
		return $response;
	}
}