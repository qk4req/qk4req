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
	protected $assetsPath = '/assets/themes';
	protected $assetsCollection = [];
	protected $assets = [];
	protected $assetName;
	protected $viewsSuffix = 'View';
	protected $viewsPrefix = 'Views\\';
	protected $viewsPath = '';
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
		$this->normalizeAssetsCollection();
		$this->assetManager->setCollection($this->assetsCollection);
		if (is_array($this->assets) && !empty($this->assets))
			foreach ($this->assets as $asset) {
				$this->assetManager->load($asset);
			}
		else {
			$asset = $this->normalizeAssetName();
			$this->assetManager->load($asset);
		}
	}

	public function normalizeAssetName() {
		return $this->assetName = str_replace('\\', '/', $this->normalizeTemplateName());
	}

	public function normalizeTemplateName() {
		if ($this->templateName) return $this->templateName; 
		$fullClassName = get_class($this);
		$className = substr($fullClassName, strlen($this->viewsPrefix));
		return $this->templateName = strtolower(substr($className, 0, (strlen($className) - strlen($this->viewsSuffix))));
	}

	public function normalizeViewsPath() {
		return $this->viewsPath = rtrim($this->viewsPath, DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR;
	}

	public function normalizeAssetsCollection() {
		if (is_array($this->assetsCollection) && !empty($this->assetsCollection)) {
			foreach ($this->assetsCollection as &$asset) {
				foreach ($asset['files'] as &$files) {
					foreach ($files as &$file) {
						$file = $this->assetsPath.'/'.$this->themeName.$file;
					}
				}
			}
		}
	}

	public function getTemplateName() {
		return $this->templateName;
	}

	public function getViewsPath() {
		return $this->viewsPath;
	}

	public function getTemplateExtension() {
		return $this->templateExtension;
	}

	public function render(array $params = []) {
		return $this->renderer->render($this->getViewsPath().$this->getTemplateName().$this->getTemplateExtension(), $params);
	}
}