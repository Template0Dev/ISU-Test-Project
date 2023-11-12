SELECT *
FROM report

UNION

SELECT '— Итого:',
	SUM(report."Очное (Всего)"),
	SUM(report."Очное (Бюджет)"),
	SUM(report."Очное (Договор)"),
	SUM(report."Очно-Заочное (Всего)"),
	SUM(report."Очно-Заочное (Бюджет)"),
	SUM(report."Очно-Заочное (Договор)"),
	SUM(report."Заочное (Всего)"),
	SUM(report."Заочное (Бюджет)"),
	SUM(report."Заочное (Договор)"),
	SUM(report."Всего"),
	SUM(report."Бюджет"),
	SUM(report."Договор")
FROM report
ORDER BY "Всего" ASC;
