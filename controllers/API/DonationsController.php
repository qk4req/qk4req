<?php
namespace Controllers\API;

use App, MVC\Controller, Models\Donation\Entity;
use Laminas\Diactoros\{ServerRequest, Response\JsonResponse};
use Doctrine\ORM\EntityManager;
//use Symfony\Component\Serializer\Serializer;

class DonationsController extends Controller {
	public function __invoke(EntityManager $man)
	{
		return $this->read($man, $ser);
	}

	public function read(EntityManager $man) {
		return $this->last($man, $ser);
	}
	
	public function last(EntityManager $man)
	{
		$repo = $man->getRepository(Entity::class);
		$a = $repo->findBy([], ['id'=>'DESC'], 3);
		$donations = [];
		foreach ($a as $b) {
			$notification = $b->getNotification();
			$ee = $b->getEasterEgg();
			$donations[] = [
				'id'=>$b->getId(),
				'name'=>$b->getName(),
				'amount'=>$b->getAmount(),
				'currency'=>$b->getCurrency(),
				'comment'=>$b->getComment(),
				'created_at'=>$b->getCreatedAt(),
				'notification'=>$notification !== null ? [
					'id'=>$notification->getId(),
					'type'=>$notification->getType(),
					'volume'=>$notification->getVolume(),
					'src'=>$notification->getSrc()
				] : null,
				'easter_egg'=>$ee !== null ? [
					'id'=>$ee->getId(),
					'volume'=>$ee->getVolume(),
					'src'=>$ee->getSrc()
				] : null
			];
		}
		return new JsonResponse($donations);
	}
	
	public function top(ServerRequest $req, EntityManager $man)
	{
		return new JsonResponse(
			$man->getRepository(Entity::class)->makeTop($req->getQueryParams()['period'])
		);
	}
}