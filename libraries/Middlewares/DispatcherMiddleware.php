<?php
declare(strict_types=1);

namespace Middlewares;

use Psr\Container\ContainerInterface;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use WoohooLabs\Harmony\Exception\DispatcherException;
use function is_array;
use function is_callable;
use function is_string;

class DispatcherMiddleware implements MiddlewareInterface
{
	protected $restMethodMap = [
		'GET'=>'read',
		'POST'=>'create',
		'PUT'=>'update',
		'PATCH'=>'update',
		'DELETE'=>'delete'
	];
	protected $restHeaders = [
		'application/json'
	];
	protected $container;
	protected $action;

	public function __construct(?ContainerInterface $container, string $action = "__action")
	{
		$this->container = $container;
		$this->action = $action;
	}

	public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
	{
		$action = $request->getAttribute($this->action);

		if ($action === null) {
			throw new DispatcherException(
				"Please set the '{$this->action}' attribute as a callable in the request object in " .
				"order to be able dispatch it!"
			);
		}

		$action = is_string($action) ? [$action, '__invoke'] : $action;

		$acceptHeader = strtolower($request->getHeader('Accept')[0]);

		if (in_array($acceptHeader, $this->restHeaders)) {
			$method = strtoupper(\Laminas\Diactoros\marshalMethodFromSapi($request->getServerParams()));
			$action[1] = $this->methodMap[$method];
		}

		$response = $handler->handle($request);

		/*if (is_array($action) && is_string($action[0]) && is_string($action[1])) {
			$action = $this->container->get($action[0]);
		} else {
			if (is_callable($action) === false) {
				$action = $this->container->get($action);
			}
		}*/
		$response = $this->container->call($action);

		return $response;
	}

	public function getContainer(): ContainerInterface
	{
		return $this->container;
	}

	public function setContainer(ContainerInterface $container): void
	{
		$this->container = $container;
	}

	public function getaction(): string
	{
		return $this->action;
	}

	public function setaction(string $action): void
	{
		$this->action = $action;
	}
}
