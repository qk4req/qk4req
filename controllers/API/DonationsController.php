<?php
namespace Controllers\API;

use App, MVC\Controller, Models\Donation\Entity;
use Laminas\Diactoros\{Response\JsonResponse};
use Doctrine\ORM\EntityManager;
use Carbon\Carbon;

class DonationsController extends Controller {
	public function read($req, $res, EntityManager $man) {
		return $this->{$req->getAttribute('what')}($req, $res, $man);
	}

	private function last($req, $res, EntityManager $man)
	{
		$repo = $man->getRepository(Entity::class);
		$a = $repo->findBy([], ['id'=>'DESC'], 3);
		$donations = [];
		foreach ($a as $b) {
			$notification = $b->getNotification();
			$ee = $b->getEasterEgg();
			$donations[] = [
				'id'=>$b->getId(),
				'from'=>$b->getFrom(),
				'amount'=>$b->getAmount(),
				'currency'=>$b->getOriginalCurrency(),
				'comment'=>$b->getComment(),
				'created_at'=>$b->getCreatedAt(),
				'notification'=>$notification !== null ? [
					'id'=>$notification->getId(),
					'type'=>$notification->getType(),
					'src'=>$notification->getSrc()
				] : null,
				'easter_egg'=>$ee !== null ? [
					'id'=>$ee->getId(),
					'src'=>$ee->getSrc()
				] : null
			];
		}
		return new JsonResponse($donations);
	}
	
	private function top($req, $res, EntityManager $man)
	{
		$start = Carbon::parse($req->getQueryParams()['start'], 'UTC')->format('Y-m-d H:i:s');
		$end = Carbon::parse($req->getQueryParams()['end'], 'UTC')->format('Y-m-d H:i:s');
		return new JsonResponse(
			$man->getRepository(Entity::class)->makeTop($start, $end)
		);
	}
}