<?php

namespace App\Providers;
use DateInterval;

class PostgresIntervalProvider 
{
    private const YEARS_IN_INTERVAL_NAME = 'years';

    private const MONTHS_IN_INTERVAL_NAME = 'mons';

    public static function getIntervalFromPostgresRawIntervalResult($rawPostgresInterval) : DateInterval 
    {
        if ($rawPostgresInterval == '') {
            return new DateInterval();
        }

        $refinedPostgresInterval = preg_replace('/(\S+\s+\S+\s+)/', '$1 + ', $rawPostgresInterval);
        $refinedPostgresInterval = str_replace(self::MONTHS_IN_INTERVAL_NAME, 'months', $refinedPostgresInterval);

        return DateInterval::createFromDateString($refinedPostgresInterval);
    }
}
