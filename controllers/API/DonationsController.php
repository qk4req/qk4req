<?php
namespace Controllers\API;

use App, MVC\Controller, Models\Donation\Entity;
use Laminas\Diactoros\{ServerRequest, Response\JsonResponse};
use Doctrine\ORM\EntityManager;
use Carbon\Carbon;
//use Symfony\Component\Serializer\Serializer;

class DonationsController extends Controller {
	public function __invoke(EntityManager $man)
	{
		return $this->last($man);
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
	
	public function top(ServerRequest $req, EntityManager $man)
	{
		$start = !($s = $req->getQueryParams()['start']) ? Carbon::parse($s, 'UTC')->subCentury()->format('Y-m-d H:i:s') : Carbon::parse($s, 'UTC')->format('Y-m-d H:i:s');
		$end = Carbon::parse($req->getQueryParams()['end'], 'UTC')->format('Y-m-d H:i:s');
		return new JsonResponse(
			$man->getRepository(Entity::class)->makeTop($start, $end)
		);
	}
}