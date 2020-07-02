<?php
namespace Models;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="notifications")
 */
class NotificationModel
{
	/** 
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue
	 */
	protected $id;
    /** 
     * @ORM\Column(type="string", columnDefinition="ENUM('donation','follower','subscription','easter_egg','progress_bar')")
     */
    protected $type;
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

    public function getSrc() {
        return $this->src;
    }

    public function getType() {
        return $this->type;
    }

    public function getVolume() {
        return $this->volume;
    }
}