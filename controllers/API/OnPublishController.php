<?php
namespace Controllers\API;

use App, MVC\Controller, Models\UserModel;
use Laminas\Diactoros\{ServerRequest, Response};
use Doctrine\ORM\EntityManager;

class OnPublishController extends Controller {
	public function read() {
	}

	public function __invoke(ServerRequest $request, Response $response, EntityManager $man): Response
	{
		$manager = App::get(EntityManager::class);
		$repo = $manager->getRepository(UserModel::class);
		$user = $repo->findOneBy(['signature'=>'c902a0930c743c34d9fca93f22c57566']);
		//$jwt = App::get(JWT::class);
		//$auth = App::get(\Providers\AuthProvider::class);
		//if (!($auth->user->role instanceof Broadcaster)) return $response->withStatus(403);

		return $response->withStatus(200);
	}
}