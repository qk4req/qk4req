<?php
namespace Providers;

use Requtize\Assetter\Assetter;
use KHerGe\JSON\JSON;

class AssetterProvider extends Assetter {
	//private $json;
	protected $dir;
	protected $filename;

	public function __construct(
		$dir,
		$filename = '.assets',
		$revision = 0,
		$defaultGroup = 'def',
		JSON $json
	)
	{
		$this->dir = $dir;
		$this->filename = $filename;
		$files = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($this->dir));
		$assets = [];
		foreach($files as $file) {
			if (strtolower($file->getFilename()) === $this->filename) {
				$assets[$file->getPathname()] = $json->decodeFile($file->getPathname(), true);
			}
		}
		$collection = [];
		foreach ($assets as $path=>&$asset) {
			if (isset($asset['config'])) {
				if (isset($asset['config']['path'])) {
					foreach ($asset['collection'] as &$c) {
						//if (isset($c['files']) && is_array($c['files']) && !empty($c['files'])) {
							if (isset($c['files']['css'])/* && is_array($c['files']['css']) && !empty($c['files']['css'])*/) {
								foreach ($c['files']['css'] as &$css) {
									$css = $asset['config']['path'].$css;
								}
							}
							if (isset($c['files']['js'])/* && is_array($c['files']['js']) && !empty($c['files']['js'])*/) {
								foreach ($c['files']['js'] as &$js) {
									$js = $asset['config']['path'].$js;
								}
							}
						//}
						$collection[] = $c;
					}
				}
			}
		}
		parent::__construct($collection, $revision, $defaultGroup);
	}

	public function all($group = '*')
	{
		return implode("\n", $this->getLoadedCssList($group))."\n".implode("\n", $this->getLoadedJsList($group));
	}

	public function css($group = '*')
	{
		return implode("\n", $this->getLoadedCssList($group));
	}

	public function js($group = '*')
	{
		return implode("\n", $this->getLoadedJsList($group));
	}
}