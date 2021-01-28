<?php
declare(strict_types=1);

namespace Middlewares;

use Psr\Container\ContainerInterface;
use Psr\Http\Message\{
	ServerRequestInterface,
	ResponseInterface
};
use Psr\Http\Server\{
	RequestHandlerInterface,
	MiddlewareInterface
};
use WoohooLabs\Harmony\Exception\DispatcherException;
use function is_array;
use function is_callable;
use function is_string;

class DispatcherMiddleware implements MiddlewareInterface
{
	private $restMethodsMap = [
		'GET'=>'read',
		'POST'=>'create',
		'PUT'=>'update',
		'PATCH'=>'update',
		'DELETE'=>'delete'
	];
	protected $restEntries = [
		'Controllers\\API'
	];
	protected $container;
	protected $actionAttributeName;


	public function __construct(?ContainerInterface $container, string $actionAttributeName = "__action")
	{
		$this->container = $container;
		$this->actionAttributeName = $actionAttributeName;
	}

	public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
	{
		list($status, $action, $params) = $request->getAttribute($this->actionAttributeName);

		if ($action === null) {
			throw new DispatcherException(
				"Please set the '{$this->action}' attribute as a callable in the request object in " .
				"order to be able dispatch it!"
			);
		}

		$response = $handler->handle($request);
		if (!is_array($action)) {
			foreach ($this->restEntries as $entry) {
				if (strpos($action, $entry) !== false && array_key_exists($method = $request->getMethod(), $this->restMethodsMap)) {
					$action = [$action, $this->restMethodsMap[$method]];
				}
				break;
			}
		}
		$action = is_string($action) ? [$action, '__invoke'] : $action;
		$response = $this->container->call($action, [$request, $response]);

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

	public function getActionAttributeName(): string
	{
		return $this->actionAttributeName;
	}

	public function setActionAttributeName(string $actionAttributeName): void
	{
		$this->actionAttributeName = $actionAttributeName;
	}
}
