create table faculty (
	id serial primary key,
	code int not null unique,
	name char(16) not null unique
);

create table education_form (
	id serial primary key,
	name char(8) not null unique,
	full_name char(64) null
);

create table education_level (
	id serial primary key,
	name char(32) not null
);

create table specialize (
	id serial primary key,
	faculty_id int not null,
	"number" char(16) not null,
	code char(16) not null,
	name char(128) not null,
	education_level_id int not null,
	
	foreign key (education_level_id) references education_level(id),
	foreign key (faculty_id) references faculty(id)
);

create table profile (
	id serial primary key,
	specialize_id int not null,
	"name" text not null,
	education_duration interval not null,
	
	foreign key (specialize_id) references specialize(id)
);

create table education_program (
	id serial primary key,
	profile_id int null,
	education_form_id int not null,
	
	begin_date timestamptz not null,
	
	foreign key (profile_id) references profile(id),
	foreign key (education_form_id) references education_form(id)
);

create table distant_education (
	id serial primary key,
	begin_date timestamptz not null,
	end_date timestamptz not null,
	note text,
	
	constraint dates_integrity check (begin_date < end_date)
);

create table group_schedule (
	id serial primary key
	-- Schedule tables isn't presented, so this is an empty table.
);

create table student_group (
	id serial primary key,
	final_uid int not null unique,
	title char(16) not null unique,
	course int not null,
	
	program_id int not null,
	schedule_id int not null,
	
	date_create timestamptz not null,
	last_up timestamptz null,
	
	foreign key (program_id) references education_program(id),
	foreign key (schedule_id) references group_schedule(id)
);

create table groups_on_distant_education (
	id serial primary key,
	group_id int not null,
	distant_id int not null,
	
	foreign key (group_id) references student_group(id),
	foreign key (distant_id) references distant_education(id)
);

create table student (
	id serial primary key,
	isu_id int not null unique,
	group_id int not null,
	
	surname text not null,
	name text not null,
	patronymic text null,
	
	ao smallint null,
	study_book bigint null,
	entry_creation_date timestamptz null,
	
	foreign key (group_id) references student_group(id)
);

create table contract (
	id serial primary key,
	student_id int not null,
	"number" int not null unique,
	ratification_date timestamptz not null,
	"info" text,
	
	foreign key (student_id) references student(id)
);

create table passport (
	id serial primary key,
	student_id int not null,
	is_actual bool not null,
	
	series int not null,
	"number" int not null,
	date_of_give timestamptz not null,
	place_of_give text null,
	
	foreign key (student_id) references student(id)
);
