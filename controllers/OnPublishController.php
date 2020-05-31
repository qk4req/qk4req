<?php
namespace Controllers;

use App, MVC\Controller;
use Laminas\Diactoros\{ServerRequest, Response};
use RBAC\Roles\Broadcaster;

class OnPublishController extends Controller {
	public function __invoke(ServerRequest $request, Response $response): Response
	{
		//$auth = App::get(\Providers\AuthProvider::class);
		//if (!($auth->user->role instanceof Broadcaster)) return $response->withStatus(403);
		return $response->withStatus(200);
	}
}