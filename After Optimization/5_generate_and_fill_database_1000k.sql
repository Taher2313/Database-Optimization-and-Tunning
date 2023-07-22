

--  _______  _______           _______  _______  _______      __    _______  _______  _______    _       
-- (  ____ \(  ____ \|\     /|(  ____ \(       )(  ___  )    /  \  (  __   )(  __   )(  __   )  | \    /\
-- | (    \/| (    \/| )   ( || (    \/| () () || (   ) |    \/) ) | (  )  || (  )  || (  )  |  |  \  / /
-- | (_____ | |      | (___) || (__    | || || || (___) |      | | | | /   || | /   || | /   |  |  (_/ / 
-- (_____  )| |      |  ___  ||  __)   | |(_)| ||  ___  |      | | | (/ /) || (/ /) || (/ /) |  |   _ (  
--       ) || |      | (   ) || (      | |   | || (   ) |      | | |   / | ||   / | ||   / | |  |  ( \ \ 
-- /\____) || (____/\| )   ( || (____/\| )   ( || )   ( |    __) (_|  (__) ||  (__) ||  (__) |  |  /  \ \
-- \_______)(_______/|/     \|(_______/|/     \||/     \|    \____/(_______)(_______)(_______)  |_/    \/
                                                                                                      


-- clear the whole schema
DROP SCHEMA IF EXISTS optimized_1000k CASCADE;
CREATE SCHEMA optimized_1000k;

GRANT ALL ON SCHEMA optimized_1000k TO bob;
GRANT ALL ON SCHEMA optimized_1000k TO public;

-- set the seed for random function
select setseed(1) ;

--  _______ _________          ______   _______  _       _________ _______ 
-- (  ____ \\__   __/|\     /|(  __  \ (  ____ \( (    /|\__   __/(  ____ \
-- | (    \/   ) (   | )   ( || (  \  )| (    \/|  \  ( |   ) (   | (    \/
-- | (_____    | |   | |   | || |   ) || (__    |   \ | |   | |   | (_____ 
-- (_____  )   | |   | |   | || |   | ||  __)   | (\ \) |   | |   (_____  )
--       ) |   | |   | |   | || |   ) || (      | | \   |   | |         ) |
-- /\____) |   | |   | (___) || (__/  )| (____/\| )  \  |   | |   /\____) |
-- \_______)   )_(   (_______)(______/ (_______/|/    )_)   )_(   \_______)
                                                                            
CREATE TABLE IF NOT EXISTS optimized_1000k.students
(
    id int ,
    name text  NOT NULL,
    username text unique NOT NULL,
    password text  NOT NULL,
    CONSTRAINT students_pkey PRIMARY KEY (id)
);

insert into optimized_1000k.students(id , "name" , username , "password" )
select id,
       concat ('name ' , floor(1 + random()*100000)), 
       concat ('username ' , id), 
       concat ('password ' , floor (1 + random()*10000))
       from generate_series(1, 1000000) as id ;

-- _________ _        _______ _________ _______           _______ _________ _______  _______  _______ 
-- \__   __/( (    /|(  ____ \\__   __/(  ____ )|\     /|(  ____ \\__   __/(  ___  )(  ____ )(  ____ \
--    ) (   |  \  ( || (    \/   ) (   | (    )|| )   ( || (    \/   ) (   | (   ) || (    )|| (    \/
--    | |   |   \ | || (_____    | |   | (____)|| |   | || |         | |   | |   | || (____)|| (_____ 
--    | |   | (\ \) |(_____  )   | |   |     __)| |   | || |         | |   | |   | ||     __)(_____  )
--    | |   | | \   |      ) |   | |   | (\ (   | |   | || |         | |   | |   | || (\ (         ) |
-- ___) (___| )  \  |/\____) |   | |   | ) \ \__| (___) || (____/\   | |   | (___) || ) \ \__/\____) |
-- \_______/|/    )_)\_______)   )_(   |/   \__/(_______)(_______/   )_(   (_______)|/   \__/\_______)
                                                                                                   
CREATE TABLE IF NOT EXISTS optimized_1000k.instructors
(
    id int ,
    name text  NOT NULL,
    username text unique NOT NULL,
    password text  NOT NULL,
    CONSTRAINT instructors_pkey PRIMARY KEY (id)
);

insert into optimized_1000k.instructors(id , "name" , username , "password" )
select id,
       concat ('name ' , floor(1 + random()*1000)), 
       concat ('username ' , id), 
       concat ('password ' , floor (1 + random()*1000))
       from generate_series(1, 10000) as id ;

--  _______  _______           _______  _______  _______  _______ 
-- (  ____ \(  ___  )|\     /|(  ____ )(  ____ \(  ____ \(  ____ \
-- | (    \/| (   ) || )   ( || (    )|| (    \/| (    \/| (    \/
-- | |      | |   | || |   | || (____)|| (_____ | (__    | (_____ 
-- | |      | |   | || |   | ||     __)(_____  )|  __)   (_____  )
-- | |      | |   | || |   | || (\ (         ) || (            ) |
-- | (____/\| (___) || (___) || ) \ \__/\____) || (____/\/\____) |
-- (_______/(_______)(_______)|/   \__/\_______)(_______/\_______)
                                                               
CREATE TABLE IF NOT EXISTS optimized_1000k.courses
(
    id int ,
    name text unique  NOT NULL,
    instructor_id int NOT NULL REFERENCES optimized_1000k.instructors(id),
    cost integer NOT NULL,
    rate integer NOT NULL,
    CONSTRAINT courses_pkey PRIMARY KEY (id)
);

insert into optimized_1000k.courses(id , "name" , instructor_id , cost , rate )
select id,
       concat ('course ' , id ), 
       floor(1 + random()*10000), 
       floor(100 + random()*(1000-100)),
       floor(1 + random()*(10-1))
       from generate_series(1, 100000) as id ;

--          _________ ______   _______  _______  _______ 
-- |\     /|\__   __/(  __  \ (  ____ \(  ___  )(  ____ \
-- | )   ( |   ) (   | (  \  )| (    \/| (   ) || (    \/
-- | |   | |   | |   | |   ) || (__    | |   | || (_____ 
-- ( (   ) )   | |   | |   | ||  __)   | |   | |(_____  )
--  \ \_/ /    | |   | |   ) || (      | |   | |      ) |
--   \   /  ___) (___| (__/  )| (____/\| (___) |/\____) |
--    \_/   \_______/(______/ (_______/(_______)\_______)
                                                      
CREATE TABLE IF NOT EXISTS optimized_1000k.videos
(
    id int ,
    name text NOT NULL,
    instructor_name text NOT NULL,
    course_name text NOT NULL,
    link text unique  NOT NULL,
    course_id int NOT NULL REFERENCES optimized_1000k.courses(id),
    CONSTRAINT videos_pkey PRIMARY KEY (id)
);

insert into optimized_1000k.videos(id , "name" , instructor_name , course_name , link , course_id )
select id,
       concat ('video ' , floor(1 + random()*100000)), 
       concat ('instructor ' , floor(1 + random()*10000)), 
       concat ('course ' , floor(1 + random()*100000)), 
       concat ('link ' , id), 
       floor(1 + random()*100000)
       from generate_series(1, 1000000) as id ;

--  _______ _________          ______   _______  _       _________ _______       _______  _______           _______  _______  _______  _______ 
-- (  ____ \\__   __/|\     /|(  __  \ (  ____ \( (    /|\__   __/(  ____ \     (  ____ \(  ___  )|\     /|(  ____ )(  ____ \(  ____ \(  ____ \
-- | (    \/   ) (   | )   ( || (  \  )| (    \/|  \  ( |   ) (   | (    \/     | (    \/| (   ) || )   ( || (    )|| (    \/| (    \/| (    \/
-- | (_____    | |   | |   | || |   ) || (__    |   \ | |   | |   | (_____      | |      | |   | || |   | || (____)|| (_____ | (__    | (_____ 
-- (_____  )   | |   | |   | || |   | ||  __)   | (\ \) |   | |   (_____  )     | |      | |   | || |   | ||     __)(_____  )|  __)   (_____  )
--       ) |   | |   | |   | || |   ) || (      | | \   |   | |         ) |     | |      | |   | || |   | || (\ (         ) || (            ) |
-- /\____) |   | |   | (___) || (__/  )| (____/\| )  \  |   | |   /\____) |     | (____/\| (___) || (___) || ) \ \__/\____) || (____/\/\____) |
-- \_______)   )_(   (_______)(______/ (_______/|/    )_)   )_(   \_______)_____(_______/(_______)(_______)|/   \__/\_______)(_______/\_______)
--                                                                        (_____)                                                              

CREATE TABLE IF NOT EXISTS optimized_1000k.students_courses
(
    student_id int NOT NULL REFERENCES optimized_1000k.students(id),
    course_id int NOT NULL REFERENCES optimized_1000k.courses(id),
    course_name text NOT NULL,
    student_name text NOT NULL,
    CONSTRAINT students_courses_pkey PRIMARY KEY (student_id, course_id)
);


insert into optimized_1000k.students_courses(student_id , course_id , course_name , student_name )
select floor(1 + random()*1000000), 
       floor(1 + random()*100000), 
       concat ('course ' , floor(1 + random()*10000)), 
       concat ('student ' , floor(1 + random()*10000))
       from generate_series(1, 5000000) as id 
on conflict on constraint students_courses_pkey do nothing;

------------------ update course_name and student_name ------------------

------------------------- update student_name ----------------------------
update optimized_1000k.students_courses sc
set student_name = s.name
from optimized_1000k.students s
where sc.student_id = s.id;
------------------------- update course_name ----------------------------
update optimized_1000k.students_courses 
set course_name = concat ('course ' , course_id);
                 
--  _______          _________ _______  _______  _______  _______ 
-- (  ___  )|\     /|\__   __// ___   )/ ___   )(  ____ \(  ____ \
-- | (   ) || )   ( |   ) (   \/   )  |\/   )  || (    \/| (    \/
-- | |   | || |   | |   | |       /   )    /   )| (__    | (_____ 
-- | |   | || |   | |   | |      /   /    /   / |  __)   (_____  )
-- | | /\| || |   | |   | |     /   /    /   /  | (            ) |
-- | (_\ \ || (___) |___) (___ /   (_/\ /   (_/\| (____/\/\____) |
-- (____\/_)(_______)\_______/(_______/(_______/(_______/\_______)
                                                          
CREATE TABLE IF NOT EXISTS optimized_1000k.quizzes
(
    id int ,
    name text NOT NULL,
    course_id int NOT NULL REFERENCES optimized_1000k.courses(id),
    CONSTRAINT quizzes_pkey PRIMARY KEY (id)
);

insert into optimized_1000k.quizzes(id , "name" , course_id )
select id,
       concat ('quiz ' , floor(1 + random()*100000)), 
       floor(1 + random()*100000)
       from generate_series(1, 1000000) as id 
on conflict on constraint quizzes_pkey do nothing;

--  _______ _________          ______   _______  _       _________ _______            _________ ______   _______  _______  _______ 
-- (  ____ \\__   __/|\     /|(  __  \ (  ____ \( (    /|\__   __/(  ____ \  |\     /|\__   __/(  __  \ (  ____ \(  ___  )(  ____ \
-- | (    \/   ) (   | )   ( || (  \  )| (    \/|  \  ( |   ) (   | (    \/  | )   ( |   ) (   | (  \  )| (    \/| (   ) || (    \/
-- | (_____    | |   | |   | || |   ) || (__    |   \ | |   | |   | (_____   | |   | |   | |   | |   ) || (__    | |   | || (_____ 
-- (_____  )   | |   | |   | || |   | ||  __)   | (\ \) |   | |   (_____  )  ( (   ) )   | |   | |   | ||  __)   | |   | |(_____  )
--       ) |   | |   | |   | || |   ) || (      | | \   |   | |         ) |   \ \_/ /    | |   | |   ) || (      | |   | |      ) |
-- /\____) |   | |   | (___) || (__/  )| (____/\| )  \  |   | |   /\____) |    \   /  ___) (___| (__/  )| (____/\| (___) |/\____) |
-- \_______)   )_(   (_______)(______/ (_______/|/    )_)   )_(   \_______)_____\_/   \_______/(______/ (_______/(_______)\_______)
--                                                                        (_____)                                                  

CREATE TABLE IF NOT EXISTS optimized_1000k.students_videos
(
    student_id int NOT NULL REFERENCES optimized_1000k.students(id),
    video_id int NOT NULL REFERENCES optimized_1000k.videos(id),
    CONSTRAINT students_videos_pkey PRIMARY KEY (student_id, video_id)
);

with students_courses_videos as (
    select sc.student_id, v.id as video_id
    from optimized_1000k.students_courses sc
    join optimized_1000k.videos v on v.course_id = sc.course_id
)

insert into optimized_1000k.students_videos(student_id , video_id)
    select students_courses_videos.student_id, 
           students_courses_videos.video_id
    from students_courses_videos
    order by random()
    limit 7000000
on conflict on constraint students_videos_pkey do nothing;
 
--  _______ _________          ______   _______  _       _________ _______       _______          _________ _______  _______  _______  _______ 
-- (  ____ \\__   __/|\     /|(  __  \ (  ____ \( (    /|\__   __/(  ____ \     (  ___  )|\     /|\__   __// ___   )/ ___   )(  ____ \(  ____ \
-- | (    \/   ) (   | )   ( || (  \  )| (    \/|  \  ( |   ) (   | (    \/     | (   ) || )   ( |   ) (   \/   )  |\/   )  || (    \/| (    \/
-- | (_____    | |   | |   | || |   ) || (__    |   \ | |   | |   | (_____      | |   | || |   | |   | |       /   )    /   )| (__    | (_____ 
-- (_____  )   | |   | |   | || |   | ||  __)   | (\ \) |   | |   (_____  )     | |   | || |   | |   | |      /   /    /   / |  __)   (_____  )
--       ) |   | |   | |   | || |   ) || (      | | \   |   | |         ) |     | | /\| || |   | |   | |     /   /    /   /  | (            ) |
-- /\____) |   | |   | (___) || (__/  )| (____/\| )  \  |   | |   /\____) |     | (_\ \ || (___) |___) (___ /   (_/\ /   (_/\| (____/\/\____) |
-- \_______)   )_(   (_______)(______/ (_______/|/    )_)   )_(   \_______)_____(____\/_)(_______)\_______/(_______/(_______/(_______/\_______)
--                                                                        (_____)                                                              

CREATE TABLE IF NOT EXISTS optimized_1000k.students_quizzes
(
    student_id int NOT NULL REFERENCES optimized_1000k.students(id),
    student_name text NOT NULL,
    quiz_id int NOT NULL REFERENCES optimized_1000k.quizzes(id),
    score integer NOT NULL,
    CONSTRAINT students_quizzes_pkey PRIMARY KEY (student_id, quiz_id)
);

with students_courses_quizzes as (
    select sc.student_id, q.id as quiz_id
    from optimized_1000k.students_courses sc
    join optimized_1000k.quizzes q on q.course_id = sc.course_id
)

insert into optimized_1000k.students_quizzes(student_id , student_name, quiz_id , score)
    select students_courses_quizzes.student_id, 
           s.name,
           students_courses_quizzes.quiz_id,
           floor(1 + random()*(100-1))
    from students_courses_quizzes
    join optimized_1000k.students s on s.id = students_courses_quizzes.student_id
    order by random()
    limit 10000000
