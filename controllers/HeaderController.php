<?php
namespace Controllers;

use App, MVC\Controller, Views\HeaderView;
use Laminas\Diactoros\{ServerRequest, Response};

class HeaderController extends Controller {
	public function __invoke(ServerRequest $request, Response $response): Response
	{
		$headerView = App::get(HeaderView::class);
		$response->getBody()->write($headerView->render());

		return $response;
	}
}