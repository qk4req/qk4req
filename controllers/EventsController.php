<?php
namespace Controllers;

use App, MVC\Controller, Views\EventsView;
use Laminas\Diactoros\{ServerRequest, Response};

class EventsController extends Controller {
	public function __invoke($req, $res)
	{
		$eventsView = App::get(EventsView::class);
		$res->getBody()->write($eventsView->render());

		return $res;
	}
}