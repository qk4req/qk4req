<?php
namespace Models\User;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="users")
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
	protected $name;
	/** 
	 * @ORM\Column(type="string") 
	 */
	protected $signature;

	public function getId()
	{
		return $this->id;
	}

	public function getName()
	{
		return $this->name;
	}

	public function setName($name)
	{
		$this->name = $name;
		return $this;
	}

	public function getSignature($signature) {
		return $this->signature;
	}

	public function setSignature($signature) {
		$this->signature = md5($signature);
		return $this;
	}
}