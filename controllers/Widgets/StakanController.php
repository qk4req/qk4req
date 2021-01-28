<?php
namespace Controllers\Widgets;

use App, MVC\Controller, Views\Widgets\StakanView;

class StakanController extends Controller {
	public function __invoke($req, $res)
	{
		$stakanView = App::get(StakanView::class);
		$res->getBody()->write($stakanView->render());

		return $res;
	}
}