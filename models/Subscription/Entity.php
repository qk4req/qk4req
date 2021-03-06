<?php
namespace Models\Subscription;

use Models\NotificationTrait;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="subscriptions")
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
	 * @ORM\Column(type="integer") 
	 */
	protected $months;
	/** 
	 * @ORM\Column(type="integer") 
	 */
	protected $created_at;

	public function getId()
	{
		return $this->id;
	}

	public function setId($id)
	{
		$this->id = $id;
		return $this;
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

	public function getMonths()
	{
		return $this->created_at;
	}

	public function getCreatedAt()
	{
		return $this->created_at;
	}
	
	use NotificationTrait;
}