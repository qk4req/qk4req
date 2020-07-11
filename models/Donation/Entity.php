<?php
namespace Models\Donation;

use Models\{
	NotificationTrait,
	Notification\Entity as NotificationEntity,
	EasterEgg\Entity as EasterEggEntity
};
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="Models\Donation\Repository")
 * @ORM\Table(name="donations")
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
	protected $amount;
	/** 
	 * @ORM\Column(type="string") 
	 */
	protected $currency;
	/** 
	 * @ORM\Column(type="string") 
	 */
	protected $comment;
	/** 
	 * @ORM\Column(type="integer") 
	 */
	protected $created_at;

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

	public function getAmount()
	{
		return $this->amount;
	}

	public function getCurrency()
	{
		return $this->currency;
	}

	public function getCreatedAt()
	{
		return $this->created_at;
	}

	public function getComment()
	{
		return $this->comment;
	}

	use NotificationTrait;

	/**
	 * @ORM\ManyToOne(targetEntity="Models\EasterEgg\Entity", inversedBy="easter_eggs")
	 */
	private $easter_egg;

	public function getEasterEgg() 
	{
		return $this->easter_egg;
	}

	public function setEasterEgg(?EasterEggEntity $ee)
	{
		$this->easter_egg = $ee;
		return $this;
	}
}