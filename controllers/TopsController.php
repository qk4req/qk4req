<?php
namespace Controllers;

use App, MVC\Controller, Views\TopsView;
use Laminas\Diactoros\{ServerRequest, Response};

class TopsController extends Controller {
	public function __invoke(ServerRequest $request, Response $response): Response
	{
		$topsView = App::get(TopsView::class);
		$response->getBody()->write($topsView->render());

		return $response;
	}
}