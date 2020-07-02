<?php
namespace Middlewares;

use App;
use Middlewares\Exceptions\ForbiddenException;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Twig\Environment;
use RBAC\{
	AccessControl,
	Roles\Guest
};
use Providers\JWTProvider as JWT;
use Providers\AuthProvider as Auth;

class AuthMiddleware implements MiddlewareInterface
{
	protected $action;
	private $jwt;
	private $rbac;

	public function __construct($action = "__action", JWT $jwt, AccessControl $rbac) {
		$this->action = $action;
		$this->jwt = $jwt;
		$this->rbac = $rbac;

	}
	
	public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface {
		$authorized = isset($_SESSION['jwt']) && $this->jwt->verify($_SESSION['jwt']);
		$renderer = App::get(Environment::class);
		$auth = new Auth(!$authorized);
		$renderer->addGlobal('authorized', $authorized);
		if ($authorized) {
			$payload = $this->jwt->de($_SESSION['jwt']);
			$renderer->addGlobal('user', $payload);
			$auth->user = $payload;
			if (isset($auth->user->role) && $this->rbac->hasRole($auth->user->role)) {
				$role = $this->rbac->role($auth->user->role);
				$auth->user->role = $role;
			}
		} else {
			$role = $this->rbac->role(Guest::class);
		}

		App::set(Environment::class, $renderer);
		App::set(Auth::class, $auth);
		if (!$role->hasPermission($request->getAttribute($this->action))) throw new ForbiddenException;
		return $handler->handle($request);
	}
}