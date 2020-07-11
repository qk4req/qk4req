<?php
namespace Models\Donation;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Mapping as ORM;

class Repository extends EntityRepository
{
	public function makeTop($period)
	{
		$builder = $this->_em->createQueryBuilder();

		$period = Helper::normalizePeriod($period);
		$now = time();
		return $builder
						->select('d.name, SUM(d.amount) AS total')
						->from(Entity::class, 'd')
						->where($builder->expr()->between('d.created_at', ($period === 0 ? 0 : $now-$period), $now))
						->groupBy('d.name')
						->orderBy('total', 'DESC')
						->setMaxResults(3)
						->getQuery()
						->getResult();
	}
}