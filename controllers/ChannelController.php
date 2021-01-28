<?php
namespace Controllers;

use App, MVC\Controller, Views\ChannelView;
use Laminas\Diactoros\{ServerRequest, Response};
use Providers\JWTProvider as JWT;

class ChannelController extends Controller {
	public function __invoke($req, $res)
	{
		$jwt = App::get(JWT::class);
		$channelView = App::get(ChannelView::class);
		$res->getBody()->write($channelView->render(['token'=> $jwt->en(['user'=>'test'])]));

		return $res;
	}
}