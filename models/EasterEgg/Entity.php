<?php
namespace Models\EasterEgg;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="easter_eggs")
 */
class Entity
{
	/** 
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue
	 */
	protected $id;
	/** 
	 * @ORM\Column(type="string")
	 */
	protected $expression;
	/** 
	 * @ORM\Column(type="float")
	 */
	protected $value;
	/** 
	 * @ORM\Column(type="float")
	 */
	protected $volume;
	/** 
	 * @ORM\Column(type="string")
	 */
	protected $src;

	public function getId() {
		return $this->id;
	}

	public function getExpression() {
		return $this->expression;
	}

	public function getValue() {
		return $this->value;
	}

	public function getVolume() {
		return $this->volume;
	}

	public function getSrc() {
		return $this->src;
	}
}