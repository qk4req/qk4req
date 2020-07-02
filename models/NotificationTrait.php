<?php
namespace Models;

use Models\NotificationModel;
use Doctrine\ORM\Mapping as ORM;

trait NotificationTrait
{
	/**
	 * @ORM\ManyToOne(targetEntity="Models\NotificationModel", inversedBy="notifications")
	 */
	private $notification;

	public function getNotification() 
	{
		return $this->notification;
	}

	public function setNotification(?NotificationModel $notification)
	{
		$this->notification = $notification;
		return $this;
	}
}