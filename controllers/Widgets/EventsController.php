<?php
namespace Controllers\Widgets;

use App, MVC\Controller, Views\Widgets\EventsView;

class EventsController extends Controller {
	public function __invoke($req, $res)
	{
		$eventsView = App::get(EventsView::class);
		$res->getBody()->write($eventsView->render());

		return $res;
	}
}