<?php
namespace Models\Donation;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Carbon\Carbon;

class Repository extends EntityRepository
{
	public function makeTop($start, $end)
	{
		$builder = $this->_em->createQueryBuilder();
		$exprBuilder = $builder->expr();
		return $builder
						->select('d.from, SUM(d.amount) AS total')
						->from(Entity::class, 'd')
						->where($exprBuilder->andX(
							$exprBuilder->gte('d.created_at', ':start'),
							$exprBuilder->lte('d.created_at', ':end'),
							$exprBuilder->isNotNull('d.amount')
						))
						->setParameters(['start'=>$start, 'end'=>$end])
						->groupBy('d.from')
						->orderBy('total', 'DESC')
						->setMaxResults(3)
						->getQuery()
						->getResult();
	}
}