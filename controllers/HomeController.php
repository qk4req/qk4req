<?php
namespace Controllers;

use App, MVC\Controller, Views\HomeView;
use Laminas\Diactoros\{ServerRequest, Response};

class HomeController extends Controller {
	public function __invoke($req, $res)
	{
		$homeView = App::get(HomeView::class);
		$res->getBody()->write($homeView->render());

		return $res;
	}
}