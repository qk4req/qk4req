<?php
namespace Controllers\API;

use App, MVC\Controller, Models\Follower\Entity;
use Laminas\Diactoros\{ServerRequest, Response\JsonResponse};
use Doctrine\ORM\EntityManager;
//use Symfony\Component\Serializer\Serializer;

class FollowersController extends Controller {
	public function __invoke(EntityManager $man)
	{
		return $this->read($man, $ser);
	}
	
	public function read(EntityManager $man)
	{
		$repo = $man->getRepository(Entity::class);
		$a = $repo->findBy([], ['id'=>'DESC'], 3);
		$followers = [];
		foreach ($a as $b) {
			$notification = $b->getNotification();
			$followers[] = [
				'id'=>$b->getId(),
				'name'=>$b->getName(),
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