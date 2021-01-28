<?php
namespace Controllers\API;

use App, MVC\Controller, Models\User\Entity;
use Laminas\Diactoros\{Response};
use Doctrine\ORM\EntityManager;

class OnPublishController extends Controller {
	public function __invoke($req, $res, EntityManager $man)
	{
		$manager = App::get(EntityManager::class);
		$repo = $manager->getRepository(Entity::class);
		$user = $repo->findOneBy(['signature'=>'c902a0930c743c34d9fca93f22c57566']);
		//$jwt = App::get(JWT::class);
		//$auth = App::get(\Providers\AuthProvider::class);
		//if (!($auth->user->role instanceof Broadcaster)) return $response->withStatus(403);

		return $response->withStatus(200);
	}

	public function read() {
	}
}