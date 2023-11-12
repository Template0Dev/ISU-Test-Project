SELECT faculty.name AS "Факультет / Институт", 
	-- First Row Group.
	COALESCE(table_1.count, 0) AS "Очное (Всего)",
	COALESCE(table_2.count, 0) AS "Очное (Бюджет)",
		COALESCE(table_1.count, 0) - COALESCE(table_2.count, 0) AS "Очное (Договор)",
	-- Second Row Group.
	COALESCE(table_3.count, 0) AS "Очно-Заочное (Всего)",
	COALESCE(table_4.count, 0) AS "Очно-Заочное (Бюджет)",
		COALESCE(table_3.count, 0) - COALESCE(table_4.count, 0) AS "Очно-Заочное (Договор)",
	-- Third Row Group.
	COALESCE(table_5.count, 0) AS "Заочное (Всего)",
	COALESCE(table_6.count, 0) AS "Заочное (Бюджет)",
		COALESCE(table_5.count, 0) - COALESCE(table_6.count, 0) AS "Заочное (Договор)",
	-- Final Row Group.
	COALESCE(table_1.count, 0) + COALESCE(table_3.count, 0) + COALESCE(table_5.count, 0) AS "Всего",
	COALESCE(table_2.count, 0) + COALESCE(table_4.count, 0) + COALESCE(table_5.count, 0) AS "Бюджет",
		(COALESCE(table_1.count, 0) - COALESCE(table_2.count, 0)) + (COALESCE(table_3.count, 0) - COALESCE(table_4.count, 0)) + (COALESCE(table_5.count, 0) - COALESCE(table_6.count, 0)) AS "Договор"
FROM faculty
	FULL JOIN (
		SELECT faculty_name, COUNT(*) as "count"
		FROM get_students_list__by_faculties_and_edu_forms
		(
			(
				SELECT ARRAY_AGG(faculty.name)
			 	FROM faculty
			),
			ARRAY['О']
		)
		GROUP BY faculty_name
	) AS table_1
		ON faculty.name = table_1.faculty_name
	FULL JOIN (
		SELECT faculty_name, COUNT(*) as "count"
		FROM get_students_list__by_faculties_and_edu_forms
		(
			(
				SELECT ARRAY_AGG(faculty.name)
				FROM faculty
			),
			ARRAY['О']
		)
		WHERE on_contract = false
		GROUP BY faculty_name
	) AS table_2
		ON faculty.name = table_2.faculty_name
	FULL JOIN (
		SELECT faculty_name, COUNT(*) as "count"
		FROM get_students_list__by_faculties_and_edu_forms
		(
			(
				SELECT ARRAY_AGG(faculty.name)
				FROM faculty
			),
			ARRAY['ОЗ']
		)
		GROUP BY faculty_name
	) AS table_3
		ON faculty.name = table_3.faculty_name
	FULL JOIN (
		SELECT faculty_name, COUNT(*) as "count"
		FROM get_students_list__by_faculties_and_edu_forms
		(
			(
				SELECT ARRAY_AGG(faculty.name)
				FROM faculty
			),
			ARRAY['ОЗ']
		)
		WHERE on_contract = false
		GROUP BY faculty_name
	) AS table_4
		ON faculty.name = table_4.faculty_name
	FULL JOIN (
		SELECT faculty_name, COUNT(*) as "count"
		FROM get_students_list__by_faculties_and_edu_forms
		(
			(
				SELECT ARRAY_AGG(faculty.name)
				FROM faculty
			),
			ARRAY['З']
		)
		GROUP BY faculty_name
	) AS table_5
		ON faculty.name = table_5.faculty_name
	FULL JOIN (
		SELECT faculty_name, COUNT(*) as "count"
		FROM get_students_list__by_faculties_and_edu_forms
		(
			(
				SELECT ARRAY_AGG(faculty.name)
				FROM faculty
			),
			ARRAY['З']
		)
		WHERE on_contract = false
		GROUP BY faculty_name
	) AS table_6
		ON faculty.name = table_6.faculty_name;
	