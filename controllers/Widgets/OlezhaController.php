<?php
namespace Controllers\Widgets;

use App, MVC\Controller, Views\Widgets\OlezhaView;

class OlezhaController extends Controller {
	public function __invoke($req, $res)
	{
		$olezhaView = App::get(OlezhaView::class);
		$res->getBody()->write($olezhaView->render());

		return $res;
	}
}