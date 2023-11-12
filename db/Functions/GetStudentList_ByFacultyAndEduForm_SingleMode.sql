-- FUNCTION: public.get_students_list__by_faculties_and_edu_forms(character[], character[])

-- DROP FUNCTION IF EXISTS public.get_students_list__by_faculties_and_edu_forms(character[], character[]);

CREATE OR REPLACE FUNCTION public.get_students_list__by_faculties_and_edu_forms(
	p_faculty_name character[],
	p_education_form character[])
    RETURNS TABLE(faculty_name character, student_group character, on_contract boolean, student_isu_id integer, student_surname text, student_name text, student_patronymic text) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
	Select faculty.name, 
		student_group.title,
		contract.ratification_date IS NOT NULL,
		student.isu_id, student.surname, student.name, student.patronymic
	FROM student
		JOIN student_group
			ON student.group_id = student_group.id
		JOIN education_program
			ON student_group.program_id = education_program.id
		JOIN profile
			ON education_program.profile_id = profile.id
		JOIN specialize
			ON profile.specialize_id = specialize.id
		JOIN faculty
			ON specialize.faculty_id = faculty.id
		FULL JOIN contract
			ON student.id = contract.student_id
	WHERE faculty.name = ANY(p_faculty_name) AND
		  education_program.education_form_id IN (
			  SELECT education_form.id
			  FROM education_form
			  WHERE education_form.name = ANY(p_education_form)
		  )
	ORDER BY student.isu_id;
$BODY$;

ALTER FUNCTION public.get_students_list__by_faculties_and_edu_forms(character[], character[])
    OWNER TO postgres;
