<?php
namespace MVC;

use DIRECTORY_SEPARATOR;
use Twig\Environment;
use Providers\AssetterProvider as Assetter;

abstract class View
{
	private $renderer;
	private $assetManager;
	protected $themeName = 'master';
	protected $assetPath = '/assets/themes';
	protected $assetCollection = [];
	protected $assets = [];
	protected $viewSuffix = 'View';
	protected $viewPath = '';
	protected $templateExtension = '.phtml';
	protected $templateName;

	public function __construct(Environment $renderer, Assetter $assetManager) {
		$this->renderer = $renderer;
		$this->assetManager = $assetManager;
		$this->init();
		$renderer->addGlobal('assetter', $assetManager);
	}

	public function init() {
		$this->normalizeTemplateName();
		$this->normalizeAssetCollection();
		$this->assetManager->setCollection($this->assetCollection);
		if (is_array($this->assets) && !empty($this->assets))
			foreach ($this->assets as $asset) {
				$this->assetManager->load($asset);
			}
	}

	public function normalizeTemplateName() {
		$fullClassName = get_class($this);
		$className = substr($fullClassName, strrpos($fullClassName, '\\')+1);
		return $this->templateName = strtolower(substr($className, 0, strpos($className, $this->viewSuffix)));
	}

	public function normalizeViewPath() {
		return $this->viewPath = rtrim($this->viewPath, DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR;
	}

	public function normalizeAssetCollection() {
		if (is_array($this->assetCollection) && !empty($this->assetCollection)) {
			foreach ($this->assetCollection as &$asset) {
				foreach ($asset['files'] as &$files) {
					foreach ($files as &$file) {
						$file = $this->assetPath.'/'.$this->themeName.$file;
					}
				}
			}
		}
	}

	public function getTemplateName() {
		return $this->templateName;
	}

	public function getViewPath() {
		return $this->viewPath;
	}

	public function getTemplateExtension() {
		return $this->templateExtension;
	}

	public function render(array $params = []) {
		return $this->renderer->render($this->getViewPath().$this->getTemplateName().$this->getTemplateExtension(), $params);
	}
}