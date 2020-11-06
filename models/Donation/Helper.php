<?php
namespace Models\Donation;
use Carbon\Carbon;

class Helper
{
	private static $periods = [
		'day'=>1,
		'week'=>7,
		'month'=>30,
		'all-time'=>0,
		'd'=>1,
		'w'=>7,
		'm'=>30,
		'a'=>0,
	];

	public static function getPeriods() {
		return self::$periods;
	}

	public static function checkPeriod($period) {
		return /*in_array($p, self::$periods) || */is_string($period) && in_array($period, array_keys(self::$periods));
	}

	public static function normalizePeriod($period) {
		$period = strtolower($period);
		if (self::checkPeriod($period)) {
			return self::$periods[$period] * 86400;
		}
	}
}