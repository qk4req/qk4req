<?php
namespace Controllers\Widgets;

use App, MVC\Controller, Views\Widgets\HeaderView;

class HeaderController extends Controller {
	public function __invoke($req, $res)
	{
		$headerView = App::get(HeaderView::class);
		$res->getBody()->write($headerView->render());

		return $res;
	}
}