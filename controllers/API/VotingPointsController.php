<?php
namespace Controllers\API;

use App, MVC\Controller, Models\VotingPoint\Entity;
use Laminas\Diactoros\{Response\JsonResponse};
use Doctrine\ORM\EntityManager;

class VotingPointsController extends Controller {
	public function __invoke($req, $res, EntityManager $man)
	{
		return new JsonResponse([]);
	}
}