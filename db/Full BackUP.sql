PGDMP  4    .            
    {            ISU_Student    16.0    16.0 v    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    20386    ISU_Student    DATABASE     �   CREATE DATABASE "ISU_Student" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "ISU_Student";
                postgres    false            �            1255    20572 G   get_students_list__by_faculties_and_edu_forms(character[], character[])    FUNCTION     �  CREATE FUNCTION public.get_students_list__by_faculties_and_edu_forms(p_faculty_name character[], p_education_form character[]) RETURNS TABLE(faculty_name character, education_form character, student_group character, on_contract boolean, student_isu_id integer, student_surname text, student_name text, student_patronymic text)
    LANGUAGE sql
    AS $$
	Select faculty.name,
		education_form.name,
		student_group.title,
		contract.ratification_date IS NOT NULL,
			student.isu_id, student.surname, student.name, student.patronymic
	FROM student
		JOIN student_group
			ON student.group_id = student_group.id
		JOIN education_program
			ON student_group.program_id = education_program.id
		JOIN education_form
			ON education_program.education_form_id = education_form.id
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
$$;
 ~   DROP FUNCTION public.get_students_list__by_faculties_and_edu_forms(p_faculty_name character[], p_education_form character[]);
       public          postgres    false            �            1255    20566 @   get_students_list__by_faculty_and_edu_form(character, character)    FUNCTION     u  CREATE FUNCTION public.get_students_list__by_faculty_and_edu_form(p_faculty_name character, p_education_form character) RETURNS TABLE(faculty_name character, student_group character, on_contract boolean, student_isu_id integer, student_surname text, student_name text, student_patronymic text)
    LANGUAGE sql
    AS $$
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
	WHERE LOWER(faculty.name) = LOWER(p_faculty_name) AND
		  education_program.education_form_id = (
			  SELECT education_form.id
			  FROM education_form
			  WHERE LOWER(education_form.name) = LOWER(p_education_form)
			  LIMIT 1
		  )
	ORDER BY student.isu_id;
$$;
 w   DROP FUNCTION public.get_students_list__by_faculty_and_edu_form(p_faculty_name character, p_education_form character);
       public          postgres    false            �            1259    20534    contract    TABLE     �   CREATE TABLE public.contract (
    id integer NOT NULL,
    student_id integer NOT NULL,
    number integer NOT NULL,
    ratification_date timestamp with time zone NOT NULL,
    info text
);
    DROP TABLE public.contract;
       public         heap    postgres    false            �            1259    20533    contract_id_seq    SEQUENCE     �   CREATE SEQUENCE public.contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.contract_id_seq;
       public          postgres    false    238            �           0    0    contract_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.contract_id_seq OWNED BY public.contract.id;
          public          postgres    false    237            �            1259    20463    distant_education    TABLE     �   CREATE TABLE public.distant_education (
    id integer NOT NULL,
    begin_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    note text,
    CONSTRAINT dates_integrity CHECK ((begin_date < end_date))
);
 %   DROP TABLE public.distant_education;
       public         heap    postgres    false            �            1259    20462    distant_education_id_seq    SEQUENCE     �   CREATE SEQUENCE public.distant_education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.distant_education_id_seq;
       public          postgres    false    228            �           0    0    distant_education_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.distant_education_id_seq OWNED BY public.distant_education.id;
          public          postgres    false    227            �            1259    20399    education_form    TABLE     }   CREATE TABLE public.education_form (
    id integer NOT NULL,
    name character(8) NOT NULL,
    full_name character(64)
);
 "   DROP TABLE public.education_form;
       public         heap    postgres    false            �            1259    20398    education_form_id_seq    SEQUENCE     �   CREATE SEQUENCE public.education_form_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.education_form_id_seq;
       public          postgres    false    218            �           0    0    education_form_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.education_form_id_seq OWNED BY public.education_form.id;
          public          postgres    false    217            �            1259    20408    education_level    TABLE     b   CREATE TABLE public.education_level (
    id integer NOT NULL,
    name character(32) NOT NULL
);
 #   DROP TABLE public.education_level;
       public         heap    postgres    false            �            1259    20407    education_level_id_seq    SEQUENCE     �   CREATE SEQUENCE public.education_level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.education_level_id_seq;
       public          postgres    false    220            �           0    0    education_level_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.education_level_id_seq OWNED BY public.education_level.id;
          public          postgres    false    219            �            1259    20446    education_program    TABLE     �   CREATE TABLE public.education_program (
    id integer NOT NULL,
    profile_id integer,
    education_form_id integer NOT NULL,
    begin_date timestamp with time zone NOT NULL
);
 %   DROP TABLE public.education_program;
       public         heap    postgres    false            �            1259    20445    education_program_id_seq    SEQUENCE     �   CREATE SEQUENCE public.education_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.education_program_id_seq;
       public          postgres    false    226            �           0    0    education_program_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.education_program_id_seq OWNED BY public.education_program.id;
          public          postgres    false    225            �            1259    20388    faculty    TABLE     u   CREATE TABLE public.faculty (
    id integer NOT NULL,
    code integer NOT NULL,
    name character(16) NOT NULL
);
    DROP TABLE public.faculty;
       public         heap    postgres    false            �            1259    20387    faculty_id_seq    SEQUENCE     �   CREATE SEQUENCE public.faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.faculty_id_seq;
       public          postgres    false    216            �           0    0    faculty_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.faculty_id_seq OWNED BY public.faculty.id;
          public          postgres    false    215            �            1259    20473    group_schedule    TABLE     @   CREATE TABLE public.group_schedule (
    id integer NOT NULL
);
 "   DROP TABLE public.group_schedule;
       public         heap    postgres    false            �            1259    20472    group_schedule_id_seq    SEQUENCE     �   CREATE SEQUENCE public.group_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.group_schedule_id_seq;
       public          postgres    false    230            �           0    0    group_schedule_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.group_schedule_id_seq OWNED BY public.group_schedule.id;
          public          postgres    false    229            �            1259    20501    groups_on_distant_education    TABLE     �   CREATE TABLE public.groups_on_distant_education (
    id integer NOT NULL,
    group_id integer NOT NULL,
    distant_id integer NOT NULL
);
 /   DROP TABLE public.groups_on_distant_education;
       public         heap    postgres    false            �            1259    20500 "   groups_on_distant_education_id_seq    SEQUENCE     �   CREATE SEQUENCE public.groups_on_distant_education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.groups_on_distant_education_id_seq;
       public          postgres    false    234            �           0    0 "   groups_on_distant_education_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.groups_on_distant_education_id_seq OWNED BY public.groups_on_distant_education.id;
          public          postgres    false    233            �            1259    20550    passport    TABLE       CREATE TABLE public.passport (
    id integer NOT NULL,
    student_id integer NOT NULL,
    is_actual boolean NOT NULL,
    series integer NOT NULL,
    number integer NOT NULL,
    date_of_give timestamp with time zone NOT NULL,
    place_of_give text
);
    DROP TABLE public.passport;
       public         heap    postgres    false            �            1259    20549    passport_id_seq    SEQUENCE     �   CREATE SEQUENCE public.passport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.passport_id_seq;
       public          postgres    false    240            �           0    0    passport_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.passport_id_seq OWNED BY public.passport.id;
          public          postgres    false    239            �            1259    20432    profile    TABLE     �   CREATE TABLE public.profile (
    id integer NOT NULL,
    specialize_id integer NOT NULL,
    name text NOT NULL,
    education_duration interval NOT NULL
);
    DROP TABLE public.profile;
       public         heap    postgres    false            �            1259    20431    profile_id_seq    SEQUENCE     �   CREATE SEQUENCE public.profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.profile_id_seq;
       public          postgres    false    224            �           0    0    profile_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;
          public          postgres    false    223            �            1259    20584    report    VIEW     I  CREATE VIEW public.report AS
 SELECT faculty.name AS "Факультет / Институт",
    COALESCE(table_1.count, (0)::bigint) AS "Очное (Всего)",
    COALESCE(table_2.count, (0)::bigint) AS "Очное (Бюджет)",
    (COALESCE(table_1.count, (0)::bigint) - COALESCE(table_2.count, (0)::bigint)) AS "Очное (Договор)",
    COALESCE(table_3.count, (0)::bigint) AS "Очно-Заочное (Всего)",
    COALESCE(table_4.count, (0)::bigint) AS "Очно-Заочное (Бюджет)",
    (COALESCE(table_3.count, (0)::bigint) - COALESCE(table_4.count, (0)::bigint)) AS "Очно-Заочное (Договор)",
    COALESCE(table_5.count, (0)::bigint) AS "Заочное (Всего)",
    COALESCE(table_6.count, (0)::bigint) AS "Заочное (Бюджет)",
    (COALESCE(table_5.count, (0)::bigint) - COALESCE(table_6.count, (0)::bigint)) AS "Заочное (Договор)",
    ((COALESCE(table_1.count, (0)::bigint) + COALESCE(table_3.count, (0)::bigint)) + COALESCE(table_5.count, (0)::bigint)) AS "Всего",
    ((COALESCE(table_2.count, (0)::bigint) + COALESCE(table_4.count, (0)::bigint)) + COALESCE(table_5.count, (0)::bigint)) AS "Бюджет",
    (((COALESCE(table_1.count, (0)::bigint) - COALESCE(table_2.count, (0)::bigint)) + (COALESCE(table_3.count, (0)::bigint) - COALESCE(table_4.count, (0)::bigint))) + (COALESCE(table_5.count, (0)::bigint) - COALESCE(table_6.count, (0)::bigint))) AS "Договор"
   FROM ((((((public.faculty
     FULL JOIN ( SELECT get_students_list__by_faculties_and_edu_forms.faculty_name,
            count(*) AS count
           FROM public.get_students_list__by_faculties_and_edu_forms(( SELECT array_agg(faculty_1.name) AS array_agg
                   FROM public.faculty faculty_1), (ARRAY['О'::text])::bpchar[]) get_students_list__by_faculties_and_edu_forms(faculty_name, education_form, student_group, on_contract, student_isu_id, student_surname, student_name, student_patronymic)
          GROUP BY get_students_list__by_faculties_and_edu_forms.faculty_name) table_1 ON ((faculty.name = table_1.faculty_name)))
     FULL JOIN ( SELECT get_students_list__by_faculties_and_edu_forms.faculty_name,
            count(*) AS count
           FROM public.get_students_list__by_faculties_and_edu_forms(( SELECT array_agg(faculty_1.name) AS array_agg
                   FROM public.faculty faculty_1), (ARRAY['О'::text])::bpchar[]) get_students_list__by_faculties_and_edu_forms(faculty_name, education_form, student_group, on_contract, student_isu_id, student_surname, student_name, student_patronymic)
          WHERE (get_students_list__by_faculties_and_edu_forms.on_contract = false)
          GROUP BY get_students_list__by_faculties_and_edu_forms.faculty_name) table_2 ON ((faculty.name = table_2.faculty_name)))
     FULL JOIN ( SELECT get_students_list__by_faculties_and_edu_forms.faculty_name,
            count(*) AS count
           FROM public.get_students_list__by_faculties_and_edu_forms(( SELECT array_agg(faculty_1.name) AS array_agg
                   FROM public.faculty faculty_1), (ARRAY['ОЗ'::text])::bpchar[]) get_students_list__by_faculties_and_edu_forms(faculty_name, education_form, student_group, on_contract, student_isu_id, student_surname, student_name, student_patronymic)
          GROUP BY get_students_list__by_faculties_and_edu_forms.faculty_name) table_3 ON ((faculty.name = table_3.faculty_name)))
     FULL JOIN ( SELECT get_students_list__by_faculties_and_edu_forms.faculty_name,
            count(*) AS count
           FROM public.get_students_list__by_faculties_and_edu_forms(( SELECT array_agg(faculty_1.name) AS array_agg
                   FROM public.faculty faculty_1), (ARRAY['ОЗ'::text])::bpchar[]) get_students_list__by_faculties_and_edu_forms(faculty_name, education_form, student_group, on_contract, student_isu_id, student_surname, student_name, student_patronymic)
          WHERE (get_students_list__by_faculties_and_edu_forms.on_contract = false)
          GROUP BY get_students_list__by_faculties_and_edu_forms.faculty_name) table_4 ON ((faculty.name = table_4.faculty_name)))
     FULL JOIN ( SELECT get_students_list__by_faculties_and_edu_forms.faculty_name,
            count(*) AS count
           FROM public.get_students_list__by_faculties_and_edu_forms(( SELECT array_agg(faculty_1.name) AS array_agg
                   FROM public.faculty faculty_1), (ARRAY['З'::text])::bpchar[]) get_students_list__by_faculties_and_edu_forms(faculty_name, education_form, student_group, on_contract, student_isu_id, student_surname, student_name, student_patronymic)
          GROUP BY get_students_list__by_faculties_and_edu_forms.faculty_name) table_5 ON ((faculty.name = table_5.faculty_name)))
     FULL JOIN ( SELECT get_students_list__by_faculties_and_edu_forms.faculty_name,
            count(*) AS count
           FROM public.get_students_list__by_faculties_and_edu_forms(( SELECT array_agg(faculty_1.name) AS array_agg
                   FROM public.faculty faculty_1), (ARRAY['З'::text])::bpchar[]) get_students_list__by_faculties_and_edu_forms(faculty_name, education_form, student_group, on_contract, student_isu_id, student_surname, student_name, student_patronymic)
          WHERE (get_students_list__by_faculties_and_edu_forms.on_contract = false)
          GROUP BY get_students_list__by_faculties_and_edu_forms.faculty_name) table_6 ON ((faculty.name = table_6.faculty_name)));
    DROP VIEW public.report;
       public          postgres    false    255    216            �            1259    20589    report_full    VIEW     {  CREATE VIEW public.report_full AS
 SELECT report."Факультет / Институт",
    report."Очное (Всего)",
    report."Очное (Бюджет)",
    report."Очное (Договор)",
    report."Очно-Заочное (Всего)",
    report."Очно-Заочное (Бюджет)",
    report."Очно-Заочное (Договор)",
    report."Заочное (Всего)",
    report."Заочное (Бюджет)",
    report."Заочное (Договор)",
    report."Всего",
    report."Бюджет",
    report."Договор"
   FROM public.report
UNION
 SELECT '— Итого:'::bpchar AS "Факультет / Институт",
    sum(report."Очное (Всего)") AS "Очное (Всего)",
    sum(report."Очное (Бюджет)") AS "Очное (Бюджет)",
    sum(report."Очное (Договор)") AS "Очное (Договор)",
    sum(report."Очно-Заочное (Всего)") AS "Очно-Заочное (Всего)",
    sum(report."Очно-Заочное (Бюджет)") AS "Очно-Заочное (Бюджет)",
    sum(report."Очно-Заочное (Договор)") AS "Очно-Заочное (Договор)",
    sum(report."Заочное (Всего)") AS "Заочное (Всего)",
    sum(report."Заочное (Бюджет)") AS "Заочное (Бюджет)",
    sum(report."Заочное (Договор)") AS "Заочное (Договор)",
    sum(report."Всего") AS "Всего",
    sum(report."Бюджет") AS "Бюджет",
    sum(report."Договор") AS "Договор"
   FROM public.report
  ORDER BY 11;
    DROP VIEW public.report_full;
       public          postgres    false    241    241    241    241    241    241    241    241    241    241    241    241    241            �            1259    20415 
   specialize    TABLE     �   CREATE TABLE public.specialize (
    id integer NOT NULL,
    faculty_id integer NOT NULL,
    number character(16) NOT NULL,
    code character(16) NOT NULL,
    name character(128) NOT NULL,
    education_level_id integer NOT NULL
);
    DROP TABLE public.specialize;
       public         heap    postgres    false            �            1259    20414    specialize_id_seq    SEQUENCE     �   CREATE SEQUENCE public.specialize_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.specialize_id_seq;
       public          postgres    false    222            �           0    0    specialize_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.specialize_id_seq OWNED BY public.specialize.id;
          public          postgres    false    221            �            1259    20518    student    TABLE       CREATE TABLE public.student (
    id integer NOT NULL,
    isu_id integer NOT NULL,
    group_id integer NOT NULL,
    surname text NOT NULL,
    name text NOT NULL,
    patronymic text,
    ao smallint,
    study_book bigint,
    entry_creation_date timestamp with time zone
);
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    20480    student_group    TABLE     :  CREATE TABLE public.student_group (
    id integer NOT NULL,
    final_uid integer NOT NULL,
    title character(16) NOT NULL,
    course integer NOT NULL,
    program_id integer NOT NULL,
    schedule_id integer NOT NULL,
    date_create timestamp with time zone NOT NULL,
    last_up timestamp with time zone
);
 !   DROP TABLE public.student_group;
       public         heap    postgres    false            �            1259    20479    student_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.student_group_id_seq;
       public          postgres    false    232            �           0    0    student_group_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.student_group_id_seq OWNED BY public.student_group.id;
          public          postgres    false    231            �            1259    20517    student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.student_id_seq;
       public          postgres    false    236            �           0    0    student_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;
          public          postgres    false    235            �           2604    20537    contract id    DEFAULT     j   ALTER TABLE ONLY public.contract ALTER COLUMN id SET DEFAULT nextval('public.contract_id_seq'::regclass);
 :   ALTER TABLE public.contract ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    237    238            �           2604    20466    distant_education id    DEFAULT     |   ALTER TABLE ONLY public.distant_education ALTER COLUMN id SET DEFAULT nextval('public.distant_education_id_seq'::regclass);
 C   ALTER TABLE public.distant_education ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    20402    education_form id    DEFAULT     v   ALTER TABLE ONLY public.education_form ALTER COLUMN id SET DEFAULT nextval('public.education_form_id_seq'::regclass);
 @   ALTER TABLE public.education_form ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    20411    education_level id    DEFAULT     x   ALTER TABLE ONLY public.education_level ALTER COLUMN id SET DEFAULT nextval('public.education_level_id_seq'::regclass);
 A   ALTER TABLE public.education_level ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    20449    education_program id    DEFAULT     |   ALTER TABLE ONLY public.education_program ALTER COLUMN id SET DEFAULT nextval('public.education_program_id_seq'::regclass);
 C   ALTER TABLE public.education_program ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    20391 
   faculty id    DEFAULT     h   ALTER TABLE ONLY public.faculty ALTER COLUMN id SET DEFAULT nextval('public.faculty_id_seq'::regclass);
 9   ALTER TABLE public.faculty ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    20476    group_schedule id    DEFAULT     v   ALTER TABLE ONLY public.group_schedule ALTER COLUMN id SET DEFAULT nextval('public.group_schedule_id_seq'::regclass);
 @   ALTER TABLE public.group_schedule ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    230    230            �           2604    20504    groups_on_distant_education id    DEFAULT     �   ALTER TABLE ONLY public.groups_on_distant_education ALTER COLUMN id SET DEFAULT nextval('public.groups_on_distant_education_id_seq'::regclass);
 M   ALTER TABLE public.groups_on_distant_education ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    20553    passport id    DEFAULT     j   ALTER TABLE ONLY public.passport ALTER COLUMN id SET DEFAULT nextval('public.passport_id_seq'::regclass);
 :   ALTER TABLE public.passport ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    239    240            �           2604    20435 
   profile id    DEFAULT     h   ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);
 9   ALTER TABLE public.profile ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    20418    specialize id    DEFAULT     n   ALTER TABLE ONLY public.specialize ALTER COLUMN id SET DEFAULT nextval('public.specialize_id_seq'::regclass);
 <   ALTER TABLE public.specialize ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    20521 
   student id    DEFAULT     h   ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);
 9   ALTER TABLE public.student ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    236    236            �           2604    20483    student_group id    DEFAULT     t   ALTER TABLE ONLY public.student_group ALTER COLUMN id SET DEFAULT nextval('public.student_group_id_seq'::regclass);
 ?   ALTER TABLE public.student_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231    232            �          0    20534    contract 
   TABLE DATA           S   COPY public.contract (id, student_id, number, ratification_date, info) FROM stdin;
    public          postgres    false    238   ��       v          0    20463    distant_education 
   TABLE DATA           K   COPY public.distant_education (id, begin_date, end_date, note) FROM stdin;
    public          postgres    false    228   ��       l          0    20399    education_form 
   TABLE DATA           =   COPY public.education_form (id, name, full_name) FROM stdin;
    public          postgres    false    218   Ȳ       n          0    20408    education_level 
   TABLE DATA           3   COPY public.education_level (id, name) FROM stdin;
    public          postgres    false    220   �       t          0    20446    education_program 
   TABLE DATA           Z   COPY public.education_program (id, profile_id, education_form_id, begin_date) FROM stdin;
    public          postgres    false    226   ��       j          0    20388    faculty 
   TABLE DATA           1   COPY public.faculty (id, code, name) FROM stdin;
    public          postgres    false    216   �       x          0    20473    group_schedule 
   TABLE DATA           ,   COPY public.group_schedule (id) FROM stdin;
    public          postgres    false    230   {�       |          0    20501    groups_on_distant_education 
   TABLE DATA           O   COPY public.groups_on_distant_education (id, group_id, distant_id) FROM stdin;
    public          postgres    false    234   ��       �          0    20550    passport 
   TABLE DATA           j   COPY public.passport (id, student_id, is_actual, series, number, date_of_give, place_of_give) FROM stdin;
    public          postgres    false    240   δ       r          0    20432    profile 
   TABLE DATA           N   COPY public.profile (id, specialize_id, name, education_duration) FROM stdin;
    public          postgres    false    224   ��       p          0    20415 
   specialize 
   TABLE DATA           \   COPY public.specialize (id, faculty_id, number, code, name, education_level_id) FROM stdin;
    public          postgres    false    222   "�       ~          0    20518    student 
   TABLE DATA           w   COPY public.student (id, isu_id, group_id, surname, name, patronymic, ao, study_book, entry_creation_date) FROM stdin;
    public          postgres    false    236   L�       z          0    20480    student_group 
   TABLE DATA           t   COPY public.student_group (id, final_uid, title, course, program_id, schedule_id, date_create, last_up) FROM stdin;
    public          postgres    false    232   �       �           0    0    contract_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.contract_id_seq', 5, true);
          public          postgres    false    237            �           0    0    distant_education_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.distant_education_id_seq', 1, false);
          public          postgres    false    227            �           0    0    education_form_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.education_form_id_seq', 3, true);
          public          postgres    false    217            �           0    0    education_level_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.education_level_id_seq', 4, true);
          public          postgres    false    219            �           0    0    education_program_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.education_program_id_seq', 19, true);
          public          postgres    false    225            �           0    0    faculty_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.faculty_id_seq', 5, true);
          public          postgres    false    215            �           0    0    group_schedule_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.group_schedule_id_seq', 13, true);
          public          postgres    false    229            �           0    0 "   groups_on_distant_education_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.groups_on_distant_education_id_seq', 1, false);
          public          postgres    false    233            �           0    0    passport_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.passport_id_seq', 46, true);
          public          postgres    false    239            �           0    0    profile_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.profile_id_seq', 15, true);
          public          postgres    false    223            �           0    0    specialize_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.specialize_id_seq', 6, true);
          public          postgres    false    221            �           0    0    student_group_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.student_group_id_seq', 4, true);
          public          postgres    false    231            �           0    0    student_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.student_id_seq', 31, true);
          public          postgres    false    235            �           2606    20543    contract contract_number_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_number_key UNIQUE (number);
 F   ALTER TABLE ONLY public.contract DROP CONSTRAINT contract_number_key;
       public            postgres    false    238            �           2606    20541    contract contract_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.contract DROP CONSTRAINT contract_pkey;
       public            postgres    false    238            �           2606    20471 (   distant_education distant_education_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.distant_education
    ADD CONSTRAINT distant_education_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.distant_education DROP CONSTRAINT distant_education_pkey;
       public            postgres    false    228            �           2606    20406 &   education_form education_form_name_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.education_form
    ADD CONSTRAINT education_form_name_key UNIQUE (name);
 P   ALTER TABLE ONLY public.education_form DROP CONSTRAINT education_form_name_key;
       public            postgres    false    218            �           2606    20404 "   education_form education_form_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.education_form
    ADD CONSTRAINT education_form_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.education_form DROP CONSTRAINT education_form_pkey;
       public            postgres    false    218            �           2606    20413 $   education_level education_level_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.education_level
    ADD CONSTRAINT education_level_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.education_level DROP CONSTRAINT education_level_pkey;
       public            postgres    false    220            �           2606    20451 (   education_program education_program_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.education_program
    ADD CONSTRAINT education_program_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.education_program DROP CONSTRAINT education_program_pkey;
       public            postgres    false    226            �           2606    20395    faculty faculty_code_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_code_key UNIQUE (code);
 B   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_code_key;
       public            postgres    false    216            �           2606    20397    faculty faculty_name_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_name_key UNIQUE (name);
 B   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_name_key;
       public            postgres    false    216            �           2606    20393    faculty faculty_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_pkey;
       public            postgres    false    216            �           2606    20478 "   group_schedule group_schedule_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.group_schedule
    ADD CONSTRAINT group_schedule_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.group_schedule DROP CONSTRAINT group_schedule_pkey;
       public            postgres    false    230            �           2606    20506 <   groups_on_distant_education groups_on_distant_education_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.groups_on_distant_education
    ADD CONSTRAINT groups_on_distant_education_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.groups_on_distant_education DROP CONSTRAINT groups_on_distant_education_pkey;
       public            postgres    false    234            �           2606    20557    passport passport_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.passport DROP CONSTRAINT passport_pkey;
       public            postgres    false    240            �           2606    20439    profile profile_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.profile DROP CONSTRAINT profile_pkey;
       public            postgres    false    224            �           2606    20420    specialize specialize_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.specialize DROP CONSTRAINT specialize_pkey;
       public            postgres    false    222            �           2606    20487 )   student_group student_group_final_uid_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_final_uid_key UNIQUE (final_uid);
 S   ALTER TABLE ONLY public.student_group DROP CONSTRAINT student_group_final_uid_key;
       public            postgres    false    232            �           2606    20485     student_group student_group_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.student_group DROP CONSTRAINT student_group_pkey;
       public            postgres    false    232            �           2606    20489 %   student_group student_group_title_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_title_key UNIQUE (title);
 O   ALTER TABLE ONLY public.student_group DROP CONSTRAINT student_group_title_key;
       public            postgres    false    232            �           2606    20527    student student_isu_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_isu_id_key UNIQUE (isu_id);
 D   ALTER TABLE ONLY public.student DROP CONSTRAINT student_isu_id_key;
       public            postgres    false    236            �           2606    20525    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    236            �           2606    20544 !   contract contract_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);
 K   ALTER TABLE ONLY public.contract DROP CONSTRAINT contract_student_id_fkey;
       public          postgres    false    238    236    4805            �           2606    20457 :   education_program education_program_education_form_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.education_program
    ADD CONSTRAINT education_program_education_form_id_fkey FOREIGN KEY (education_form_id) REFERENCES public.education_form(id);
 d   ALTER TABLE ONLY public.education_program DROP CONSTRAINT education_program_education_form_id_fkey;
       public          postgres    false    4781    218    226            �           2606    20452 3   education_program education_program_profile_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.education_program
    ADD CONSTRAINT education_program_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id);
 ]   ALTER TABLE ONLY public.education_program DROP CONSTRAINT education_program_profile_id_fkey;
       public          postgres    false    226    4787    224            �           2606    20512 G   groups_on_distant_education groups_on_distant_education_distant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.groups_on_distant_education
    ADD CONSTRAINT groups_on_distant_education_distant_id_fkey FOREIGN KEY (distant_id) REFERENCES public.distant_education(id);
 q   ALTER TABLE ONLY public.groups_on_distant_education DROP CONSTRAINT groups_on_distant_education_distant_id_fkey;
       public          postgres    false    4791    234    228            �           2606    20507 E   groups_on_distant_education groups_on_distant_education_group_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.groups_on_distant_education
    ADD CONSTRAINT groups_on_distant_education_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.student_group(id);
 o   ALTER TABLE ONLY public.groups_on_distant_education DROP CONSTRAINT groups_on_distant_education_group_id_fkey;
       public          postgres    false    234    4797    232            �           2606    20558 !   passport passport_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);
 K   ALTER TABLE ONLY public.passport DROP CONSTRAINT passport_student_id_fkey;
       public          postgres    false    240    236    4805            �           2606    20440 "   profile profile_specialize_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_specialize_id_fkey FOREIGN KEY (specialize_id) REFERENCES public.specialize(id);
 L   ALTER TABLE ONLY public.profile DROP CONSTRAINT profile_specialize_id_fkey;
       public          postgres    false    224    222    4785            �           2606    20421 -   specialize specialize_education_level_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_education_level_id_fkey FOREIGN KEY (education_level_id) REFERENCES public.education_level(id);
 W   ALTER TABLE ONLY public.specialize DROP CONSTRAINT specialize_education_level_id_fkey;
       public          postgres    false    4783    220    222            �           2606    20426 %   specialize specialize_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(id);
 O   ALTER TABLE ONLY public.specialize DROP CONSTRAINT specialize_faculty_id_fkey;
       public          postgres    false    4777    216    222            �           2606    20528    student student_group_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.student_group(id);
 G   ALTER TABLE ONLY public.student DROP CONSTRAINT student_group_id_fkey;
       public          postgres    false    236    232    4797            �           2606    20490 +   student_group student_group_program_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.education_program(id);
 U   ALTER TABLE ONLY public.student_group DROP CONSTRAINT student_group_program_id_fkey;
       public          postgres    false    4789    226    232            �           2606    20495 ,   student_group student_group_schedule_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.group_schedule(id);
 V   ALTER TABLE ONLY public.student_group DROP CONSTRAINT student_group_schedule_id_fkey;
       public          postgres    false    230    4793    232            �   �   x�M��n�0E�����Z��(Pi��%�D%N5�~^���>Y:�UVYW7�r��G��k���Ƽ�V�ń\�\rX�y��,����<!�)���x[1#?�@cɜ�J;%�iw�`��i\�ɋ��Gx�e=��&#H\R�|��������*��3�"����>�w�Y�?��B���c�k%�b�{�̹��ͮ�QA�?�ɧN{{aZ%�3r��ٙk���@�i      v      x������ � �      l   A   x�3�0O�����^�p�_�|�e4��tT#��^�~aÅ}���e�	3h.��Ǎ���� �k@r      n   g   x�}��	�0D��*�@�S�Ř�����",���LGn�хax��fD��˲��"2���a1j��3k$��Y�qX������@l}�[���xMB��B�RD^�L�      t   u   x�}�A� �sx��W�� m�[��w�ڻ-���L� Oe���'>���~s�"����I\15�Rx�ԅ�X��M�Id:
�i��2:b��0�c�v6+ K�%�����f�ϯ���<ac      j   V   x�3�440�0�¢s���Dfƅ9\X�,g�i�[ra)֢ʙp���&\�ԉ&g�i
1s���_X�,���� �w-      x   &   x��I   �?a��.��!D�ӲW�D�t��Q��      |      x������ � �      �     x���ˍ1DϜ(�n��O�����8G�H\T��Q/0,��T�D		�&5�$�[HYz�$o�w��g����C� ��Rm�EC\W�7�]�Il�!��� qNܒ�&�빲S�x�e|�'�$m�2���VϚ�$m��e�u���%��@����&�˹r%�C��_��g�ǯ-������՝įz�н���C�b\,�l��$��6h���.�1H>�����=F)�Q��G1�{�%����iO�1�<UGg�N(�'���M�3���kL?f�s��E�e��0�sX����{O�#��+./y#]���^fu'���F��1���Aɕ"���K��x`��w �w��靨c@w���`k�%��xf�+�Vz��J/�'����U`��cMdg��{��"_�>%��VzS�W �L���2#���yt�n��.������k��u9�����=a6�W�H�x/��\j���q�	cÃ�|�Q���7 ������6�q���v�uU�za�b<��ٿ���t�s%�݃�~�7r���;��|<���      r     x��T�rA�W_�?`����℀���8,�K��H\6.��e�^�_��#��V�Ӯ�P��;����L�lf2#�d�s�d%�N���I����[���q����,d�����I_�`�dj���L��,�	~��)�|����%�8Pgg��������}���Y�G���~�GM�i�T
�����X�F� ��0��[���T��
�Jx�)B))c��3�QG)��7C��@4�C99����^�{��������7Q0i �*�+,�BuS$ds��2H���]�/A!9�OI���M�"�S{�)�*@�H���<��ᢣ �ډ�4/��.Q�ܬɪ֛иJ~ˬ)������$�>��7�1���\���<E�5{f��5�s��ŏE��]�q��y��1=�\+�J��:�n[N����oo��Ut޵�k��Y(�M�뛡ٹ�L�H��s���}��7A���d�K�����wA"{6$h2���Cm"Rs���+(�Q�_�e��/���i�����}�.      p     x���MN�0���)z�*N��rSF,@�%;V��j����:�XB-5nm���c31��u�k�MF���Ό�Q갓Qz����H2|6a/�����\�o�L>B%#jBp�:�v��������;#V�鋨�簱ۥ�'�5�mG�w�҂��	�҅{�窿��Ѡ����w�fS.�<Ǟpzh�'R���U����o�ۺR�5QF{۬�:ðr�H�dv
[�N^�د���@�-�)����hO���ޕ��2WJ}�Y=3      ~   �  x��V�nA��_�=�3k!z
(%-���*@J� E!�E�X��8�7����}y��L�Ȼ��{w��w6Z��8�e���q"�n�œxVm��)�w/�M\L�z�g��ƺ܇Bh��U�j�)=6r,��FZ���P"~��xj�Ǝ%ݸ���֎�G)��sg�V=��d1V��2� ��9�T��b���x��8#��?ǖe.EM\{d��|l[d+\n4Ϳ�I�*�,�ǳXV�;���R�T��Lٱn'w"ׅ����R6���z��䥨��c��2%Ǯe�Vs�T��wL�%���Ƀ5�v�)3V-K/�6�&�V=�6�����ȗ�N�@}�|�u��@� ����1�i��!.��yh�:N�"Ӑ)5�-zA�Ȅ
 $o���{��d�Ԕ>"�������-ρKL���+`��pI��¥��t��17���i�����b�l����M�r����"n�H���yH�WS�:C�68C�|���ǒL�� V�-^��׍0��O�ٰ��V�@�,)O�e<_��W�H��R�{kڦ9_;!�Ջ:���d�1��L�e*�:7t���\�Q�#��'�ސڴ/:_�W'��������۔<�nb�$z�)����������Z�XF�uR_|$#��r~�'�h�t�T��5�
�㗐��B[*�3GҤ�@1�TK��mUw��K��ld���rub	���QDH����Y�����ꏚ���+�����j$�8N���(��R�k�튞��C�OF�L�!)]#b�+z*���r4V%�ًh
>���F����g�I����aY�j}�tN.�%��iWH�]뻨� I	~��������Ձ�H��E����!��Vꂓ����}{����3|N�+2\G��7��p]������č��od�o�{�l@ib�BZ�r$�I���k���9�z�      z   z   x�}�1�0��9Ev��vH�'�P�� ��#a!h��xx�B�B�b�����!)Q��	�=sW��D�۩Y�Z��zc#�X�\:�����Cj�/k��I���x*>~Q���ι)d<=     