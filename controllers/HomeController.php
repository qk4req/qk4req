<?php
namespace Controllers;

use App, MVC\Controller, Views\HomeView;
use Laminas\Diactoros\{ServerRequest, Response};


class HomeController extends Controller {
	public function __invoke(ServerRequest $request, Response $response): Response
	{
		$homeView = App::get(HomeView::class);
		$response->getBody()->write($homeView->render());

		return $response;
	}
}