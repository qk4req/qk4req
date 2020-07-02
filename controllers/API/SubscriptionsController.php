<?php
namespace Controllers\API;

use App, MVC\Controller, Models\SubscriptionModel;
use Laminas\Diactoros\{ServerRequest, Response\JsonResponse};
use Doctrine\ORM\EntityManager;
use Symfony\Component\Serializer\Serializer;

class SubscriptionsController extends Controller {
	public function __invoke(EntityManager $man, Serializer $ser)
	{
		return $this->read($man, $ser);
	}
	
	public function read(EntityManager $man, Serializer $ser)
	{
		$repo = $man->getRepository(SubscriptionModel::class);
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
					'volume'=>$notification->getVolume(),
					'src'=>$notification->getSrc()
				] : null
			];
		}
		return new JsonResponse($followers);
	}
}