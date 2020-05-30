<?php
namespace Controllers;

use App, MVC\Controller, Views\OlezhaView;
use Laminas\Diactoros\{ServerRequest, Response};

class OlezhaController extends Controller {
	public function __invoke(ServerRequest $request, Response $response): Response
	{
		$olezhaView = App::get(OlezhaView::class);
		$response->getBody()->write($olezhaView->render());

		return $response;
	}
}