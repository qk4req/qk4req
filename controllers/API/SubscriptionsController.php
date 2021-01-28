<?php
namespace Controllers\API;

use App, MVC\Controller, Models\Subscription\Entity;
use Laminas\Diactoros\{Response\JsonResponse};
use Doctrine\ORM\EntityManager;

class SubscriptionsController extends Controller {
	public function __invoke($req, $res, EntityManager $man)
	{
		return $this->read($req, $res, $man);
	}
	
	public function read($req, $res, EntityManager $man)
	{
		$repo = $man->getRepository(Entity::class);
		$a = $repo->findBy([], ['id'=>'DESC'], 3);
		$followers = [];
		foreach ($a as $b) {
			$notification = $b->getNotification();
			$followers[] = [
				'id'=>$b->getId(),
				'name'=>$b->getName(),
				'months'=>$b->getMonths(),
				'created_at'=>$b->getCreatedAt(),
				'notification'=>$notification !== null ? [
					'id'=>$notification->getId(),
					'type'=>$notification->getType(),
					'src'=>$notification->getSrc()
				] : null
			];
		}
		return new JsonResponse($followers);
	}
}