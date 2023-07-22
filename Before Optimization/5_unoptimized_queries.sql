

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

select videos."name" , link
from unoptimized.videos
join unoptimized.courses on videos.course_id = courses.id
join unoptimized.instructors on courses.instructor_username = instructors.username
where courses."name" = 'course 99510' 
and instructors."name" = 'name 997'



-- 218 ms


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

select courses."name", students."name"
from unoptimized.students_courses
join unoptimized.students on students_courses.student_username = students.username
join unoptimized.courses on students_courses.course_id = courses.id
where courses.id in ( 
        select course_id
        from unoptimized.students_courses
        group by course_id
        order by count(*) desc
        limit 10   
)
-- 1428 ms


--  _______           _______  _______             ______  
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|  / ___  \ 
-- | (   ) || )   ( || (    \/| (    )|( \   / )  \/   \  \
-- | |   | || |   | || (__    | (____)| \ (_) /      ___) /
-- | |   | || |   | ||  __)   |     __)  \   /      (___ ( 
-- | | /\| || |   | || (      | (\ (      ) (           ) \
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     /\___/  /
-- (____\/_)(_______)(_______/|/   \__/   \_/     \______/ 
                                                        
-- select all the courses that have rate >= 9 and the names of the students who enrolled in them

select courses."name", students."name"
from unoptimized.courses
join unoptimized.students_courses on courses.id = students_courses.course_id
join unoptimized.students on students_courses.student_username = students.username
where courses.rate >= 9
-- 934 ms


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

select students."name", courses."name", score
from unoptimized.students
join unoptimized.students_quizzes on students.username = students_quizzes.student_username
join unoptimized.quizzes on students_quizzes.quiz_id = quizzes.id
join unoptimized.courses on quizzes.course_id = courses.id
order by students_quizzes.score desc
limit 100;


-- 7477 ms


--  _______           _______  _______             _______ 
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|  (  ____ \
-- | (   ) || )   ( || (    \/| (    )|( \   / )  | (    \/
-- | |   | || |   | || (__    | (____)| \ (_) /   | (____  
-- | |   | || |   | ||  __)   |     __)  \   /    (_____ \ 
-- | | /\| || |   | || (      | (\ (      ) (           ) )
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     /\____) )
-- (____\/_)(_______)(_______/|/   \__/   \_/     \______/ 
                                                        
-- select the top rate 30 courses
-- whith their instructors name and the number of students enrolled in them

select courses."name", instructors."name", count(*) as students_count
from unoptimized.courses
join unoptimized.instructors on courses.instructor_username = instructors.username
join unoptimized.students_courses on courses.id = students_courses.course_id
group by courses.id, courses."name", instructors."name"
order by courses.rate desc
limit 30;
-- 5058 ms


--  _______           _______  _______              ______ 
-- (  ___  )|\     /|(  ____ \(  ____ )|\     /|   / ____ \
-- | (   ) || )   ( || (    \/| (    )|( \   / )  ( (    \/
-- | |   | || |   | || (__    | (____)| \ (_) /   | (____  
-- | |   | || |   | ||  __)   |     __)  \   /    |  ___ \ 
-- | | /\| || |   | || (      | (\ (      ) (     | (   ) )
-- | (_\ \ || (___) || (____/\| ) \ \__   | |     ( (___) )
-- (____\/_)(_______)(_______/|/   \__/   \_/      \_____/ 

-- query optimization

-- select all student names that have score > 15 or score < 4

select distinct "name"
from
(
    (
        select students."name"
        from unoptimized.students_quizzes
        join unoptimized.students on students_quizzes.student_username = students.username
        where students_quizzes.score > 15

    )
    union
    (
        select students."name"
        from unoptimized.students_quizzes
        join unoptimized.students on students_quizzes.student_username = students.username
        where students_quizzes.score  < 4        
    )
) temp


-- 3948 ms

-- optimized query

select distinct "name"
from unoptimized.students_quizzes
join unoptimized.students on students_quizzes.student_username = students.username
where students_quizzes.score > 15 or students_quizzes.score < 4

--  _______  _______  _______  _______  _______          
-- (       )(  ____ \(       )(  ___  )(  ____ )|\     /|
-- | () () || (    \/| () () || (   ) || (    )|( \   / )
-- | || || || (__    | || || || |   | || (____)| \ (_) / 
-- | |(_)| ||  __)   | |(_)| || |   | ||     __)  \   /  
-- | |   | || (      | |   | || |   | || (\ (      ) (   
-- | )   ( || (____/\| )   ( || (___) || ) \ \__   | |   
-- |/     \|(_______/|/     \|(_______)|/   \__/   \_/   
                                                      
-- select courses."name", instructors."name", count(*) as students_count
-- from courses
-- join instructors on courses.instructor_username = instructors.username
-- join students_courses on courses.id = students_courses.course_id
-- group by courses.id, courses."name", instructors."name"
-- order by courses.rate desc
-- limit 30;

ALTER SYSTEM SET shared_buffers='16MB';
ALTER SYSTEM SET work_mem='4MB';
show shared_buffers;
show work_mem;
