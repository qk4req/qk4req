<?php
namespace MVC;

use Doctrine\ORM\EntityManager;
use RBAC\AccessControl;

abstract class Model
{
	/*private $queryBuilder;
	protected $tableName;
	protected $modelSuffix = 'Model';

	public function __construct(QueryBuilder $queryBuilder) {
		$this->queryBuilder = $queryBuilder;
		$this->queryBuilder->from($this->normalizeTableName(), substr($this->tableName, 0, 1));
	}

	public function getTableName() {
		return $this->tableName;
	}

	public function normalizeTableName () {
		$fullClassName = get_class($this);
		$className = substr($fullClassName, strrpos($fullClassName, '\\')+1);
		return $this->tableName = strtolower(substr($className, 0, strpos($className, $this->modelSuffix))).'s';
	}

	public function one() {
		return $this->queryBuilder->execute()->fetch();
	}

	public function all() {
		return $this->queryBuilder->execute()->fetchAll();
	}

	public function count($aggregateExpr = '*') {
		return $this->queryBuilder->select([
			'COUNT('.$aggregateExpr.')'
		]);
	}

	public function sum($aggregateExpr = '*') {
		return $this->queryBuilder->select([
			'SUM('.$aggregateExpr.')'
		]);
	}

	public function max($aggregateExpr = '*') {
		return $this->queryBuilder->select([
			'MAX('.$aggregateExpr.')'
		]);
	}*/
	private $entityManager;
	protected $entities = [];

	public function __construct(EntityManager $entityManager) {
		$this->entityManager = $entityManager;
	}

	public function attachEntity () {
			
	}
}