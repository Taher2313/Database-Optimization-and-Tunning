

--  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
-- ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
-- ▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ 
-- ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌     ▐░▌     ▐░▌          ▐░▌          
-- ▐░▌       ▐░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌     ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ 
-- ▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
-- ▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀█░█▀▀      ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀█░▌
-- ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌          ▐░▌     ▐░▌       ▐░▌     ▐░▌                    ▐░▌
--  ▀▀▀▀▀▀█░█▀▀ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌      ▐░▌  ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄█░▌
--         ▐░▌  ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
--          ▀    ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 
                                                                                                             
                                                      

--  _______           _______  _______             __   
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|  /  \  
-- | (   ) || )   ( || (    \/| (    )|( \   / )  \/) ) 
-- | |   | || |   | || (__    | (____)| \ (_) /     | | 
-- | |   | || |   | ||  __)   |     __)  \   /      | | 
-- | | /\| || |   | || (      | (\ (      ) (       | | 
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     __) (_
-- (____\/_)(_______)(_______/|/   \__/   \_/     \____/
                                                     
-- select videos names and links for a specific course and instructor

select *
from optimized.videos v 
where course_name = 'course 12214' and instructor_name = 'instructor 2964';
-- 57 ms


--  _______           _______  _______             _______ 
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|  / ___   )
-- | (   ) || )   ( || (    \/| (    )|( \   / )  \/   )  |
-- | |   | || |   | || (__    | (____)| \ (_) /       /   )
-- | |   | || |   | ||  __)   |     __)  \   /      _/   / 
-- | | /\| || |   | || (      | (\ (      ) (      /   _/  
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     (   (__/\
-- (____\/_)(_______)(_______/|/   \__/   \_/     \_______/
      
-- get the names of most 10 popular courses (the courses that have the most students enrolled in them)
-- and the names of the students who enrolled in them

create index on optimized.students_courses (course_id);

select sc.course_name, sc.student_name
from optimized.students_courses sc
where sc.course_id in ( 
		select course_id
	    from students_courses
	    group by course_id
	    order by count(*) desc
	    limit 10   
) 
-- 305 ms


--  _______           _______  _______             ______  
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|  / ___  \ 
-- | (   ) || )   ( || (    \/| (    )|( \   / )  \/   \  \
-- | |   | || |   | || (__    | (____)| \ (_) /      ___) /
-- | |   | || |   | ||  __)   |     __)  \   /      (___ ( 
-- | | /\| || |   | || (      | (\ (      ) (           ) \
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     /\___/  /
-- (____\/_)(_______)(_______/|/   \__/   \_/     \______/ 

-- select all the courses that have rate >= 9 and the names of the students who enrolled in them

select c.name, sc.student_name
from courses c
join students_courses sc on sc.course_id = c.id
where c.rate >= 9
-- 76 ms

--  _______           _______  _______                ___   
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|     /   )  
-- | (   ) || )   ( || (    \/| (    )|( \   / )    / /) |  
-- | |   | || |   | || (__    | (____)| \ (_) /    / (_) (_ 
-- | |   | || |   | ||  __)   |     __)  \   /    (____   _)
-- | | /\| || |   | || (      | (\ (      ) (          ) (  
-- | (_\ \ || (___) || (____/\| ) \ \__   | |          | |  
-- (____\/_)(_______)(_______/|/   \__/   \_/          (_)  

-- get the name of the top 100 students in quizzes score
-- and the courses they got the highest score in

-- index + schema
create index on students_quizzes (score);

select students_quizzes.student_name, c.name, score
from students_quizzes 
join quizzes q on q.id = students_quizzes.quiz_id
join courses c on c.id = q.course_id
order by score desc
limit 100;
-- 59 ms


--  _______           _______  _______             _______ 
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|  (  ____ \
-- | (   ) || )   ( || (    \/| (    )|( \   / )  | (    \/
-- | |   | || |   | || (__    | (____)| \ (_) /   | (____  
-- | |   | || |   | ||  __)   |     __)  \   /    (_____ \ 
-- | | /\| || |   | || (      | (\ (      ) (           ) )
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     /\____) )
-- (____\/_)(_______)(_______/|/   \__/   \_/     \______/ 

-- create materilzed view 

CREATE MATERIALIZED VIEW top_courses as 
select c.name as course_name, c.rate, i.name as instructor_name, count(sc.student_name) as students_count
from courses c
join students_courses sc on sc.course_id = c.id
join instructors i on i.id = c.instructor_id
group by c.name, c.rate, c.instructor_id ,i.name
order by rate desc
limit 30;

-- select the top rate 30 courses
-- whith their instructors name and the number of students enrolled in them

select * 
from top_courses;
-- 57 ms


--  _______           _______  _______              ______ 
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|   / ____ \
-- | (   ) || )   ( || (    \/| (    )|( \   / )  ( (    \/
-- | |   | || |   | || (__    | (____)| \ (_) /   | (____  
-- | |   | || |   | ||  __)   |     __)  \   /    |  ___ \ 
-- | | /\| || |   | || (      | (\ (      ) (     | (   ) )
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     ( (___) )
-- (____\/_)(_______)(_______/|/   \__/   \_/      \_____/ 

select distinct student_name
from optimized.students_quizzes
where score > 15 
or score < 5
-- 1153 ms

select distinct students."name"
from students_quizzes
join students on students.id = students_quizzes.student_id
where score > 15 
or score < 5
-- 2099 ms


--  _______  _______  _______  _______  _______          
-- (       )(  ____ \(       )(  ___  )(  ____ )|\     /|
-- | () () || (    \/| () () || (   ) || (    )|( \   / )
-- | || || || (__    | || || || |   | || (____)| \ (_) / 
-- | |(_)| ||  __)   | |(_)| || |   | ||     __)  \   /  
-- | |   | || (      | |   | || |   | || (\ (      ) (   
-- | )   ( || (____/\| )   ( || (___) || ) \ \__   | |   
-- |/     \|(_______/|/     \|(_______)|/   \__/   \_/   
                                           
ALTER SYSTEM SET shared_buffers='2GB';
ALTER SYSTEM SET work_mem='1GB';
show shared_buffers;
show work_mem;
