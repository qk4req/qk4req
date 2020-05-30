<?php
namespace RBAC;

trait Synonyms {
	//protected $synonyms;
	
	public function hasSynonym($name) {
		return is_array($this->synonyms) && in_array($name, $this->synonyms);
	}

	public function setSynonyms(array $synonyms) {
		$this->synonyms = $synonyms;
		return $this;
	}
}