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
	protected $from;
	/** 
	 * @ORM\Column(type="integer") 
	 */
	protected $amount;
	/** 
	 * @ORM\Column(type="string") 
	 */
	protected $original_currency;
	/** 
	 * @ORM\Column(type="string") 
	 */
	protected $comment;
	/** 
	 * @ORM\Column(type="datetime") 
	 */
	protected $created_at;

	public function getId()
	{
		return $this->id;
	}

	public function getFrom()
	{
		return $this->from;
	}

	public function setFrom($name)
	{
		$this->from = $name;
		return $this;
	}

	public function getAmount()
	{
		return $this->amount;
	}

	public function getOriginalCurrency()
	{
		return $this->original_currency;
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