<?php
namespace Controllers;

use App, MVC\Controller, Views\EventsView;
use Laminas\Diactoros\{ServerRequest, Response};

class EventsController extends Controller {
	public function __invoke(ServerRequest $request, Response $response): Response
	{
		$eventsView = App::get(EventsView::class);
		$response->getBody()->write($eventsView->render());

		return $response;
	}
}