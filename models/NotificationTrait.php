<?php
namespace Models;

use Models\Notification\Entity;
use Doctrine\ORM\Mapping as ORM;

trait NotificationTrait
{
	/**
	 * @ORM\ManyToOne(targetEntity="Models\Notification\Entity", inversedBy="notifications")
	 */
	private $notification;

	public function getNotification() 
	{
		return $this->notification;
	}

	public function setNotification(?Entity $notification)
	{
		$this->notification = $notification;
		return $this;
	}
}