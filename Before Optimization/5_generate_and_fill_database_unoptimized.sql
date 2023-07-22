

--  _______  _______           _______  _______  _______               _        _______  _______ __________________ _______ _________ _______  _______  ______  
-- (  ____ \(  ____ \|\     /|(  ____ \(       )(  ___  )    |\     /|( (    /|(  ___  )(  ____ )\__   __/\__   __/(       )\__   __// ___   )(  ____ \(  __  \ 
-- | (    \/| (    \/| )   ( || (    \/| () () || (   ) |    | )   ( ||  \  ( || (   ) || (    )|   ) (      ) (   | () () |   ) (   \/   )  || (    \/| (  \  )
-- | (_____ | |      | (___) || (__    | || || || (___) |    | |   | ||   \ | || |   | || (____)|   | |      | |   | || || |   | |       /   )| (__    | |   ) |
-- (_____  )| |      |  ___  ||  __)   | |(_)| ||  ___  |    | |   | || (\ \) || |   | ||  _____)   | |      | |   | |(_)| |   | |      /   / |  __)   | |   | |
--       ) || |      | (   ) || (      | |   | || (   ) |    | |   | || | \   || |   | || (         | |      | |   | |   | |   | |     /   /  | (      | |   ) |
-- /\____) || (____/\| )   ( || (____/\| )   ( || )   ( |    | (___) || )  \  || (___) || )         | |   ___) (___| )   ( |___) (___ /   (_/\| (____/\| (__/  )
-- \_______)(_______/|/     \|(_______/|/     \||/     \|    (_______)|/    )_)(_______)|/          )_(   \_______/|/     \|\_______/(_______/(_______/(______/ 
                                                                                                                                                             

-- clear the whole schema
DROP SCHEMA IF EXISTS unoptimized CASCADE;
CREATE SCHEMA unoptimized;

GRANT ALL ON SCHEMA unoptimized TO bob;
GRANT ALL ON SCHEMA unoptimized TO public;

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
  
CREATE TABLE IF NOT EXISTS unoptimized.students
(
    username text NOT NULL,
    name text  NOT NULL,
    password text  NOT NULL,
    CONSTRAINT students_pkey PRIMARY KEY (username)
);

insert into unoptimized.students(username , "name" , password )
select concat ('username ' , id), 
       concat ('name ' , floor(1 + random()*10000)), 
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
     
CREATE TABLE IF NOT EXISTS unoptimized.instructors
(
    username text NOT NULL,
    name text  NOT NULL,
    password text  NOT NULL,
    CONSTRAINT instructors_pkey PRIMARY KEY (username)
);

insert into unoptimized.instructors(username , "name" , password )
select concat ('username ' , id), 
       concat ('name ' , floor(1 + random()*1000)), 
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

CREATE TABLE IF NOT EXISTS unoptimized.courses
(
    id bigint ,
    name text unique  NOT NULL,
    instructor_username text NOT NULL REFERENCES unoptimized.instructors(username),
    cost integer NOT NULL,
    rate integer NOT NULL,
    CONSTRAINT courses_pkey PRIMARY KEY (id)
);

insert into unoptimized.courses(id , "name" , instructor_username , cost , rate )
select id,
       concat ('course ' , id ), 
       concat ('username ' , floor(1 + random()*10000)),
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

CREATE TABLE IF NOT EXISTS unoptimized.videos
(
    id bigint ,
    name text NOT NULL,
    link text unique  NOT NULL,
    course_id bigint NOT NULL REFERENCES unoptimized.courses(id),
    CONSTRAINT videos_pkey PRIMARY KEY (id)
);

insert into unoptimized.videos(id , "name" , link , course_id )
select id,
       concat ('video ' , floor(1 + random()*10000)), 
       concat ('link ' , id ), 
       floor(1 + random()*100000)
       from generate_series(1, 1000000) as id ;

--  _______          _________ _______  _______  _______  _______ 
-- (  ___  )|\     /|\__   __// ___   )/ ___   )(  ____ \(  ____ \
-- | (   ) || )   ( |   ) (   \/   )  |\/   )  || (    \/| (    \/
-- | |   | || |   | |   | |       /   )    /   )| (__    | (_____ 
-- | |   | || |   | |   | |      /   /    /   / |  __)   (_____  )
-- | | /\| || |   | |   | |     /   /    /   /  | (            ) |
-- | (_\ \ || (___) |___) (___ /   (_/\ /   (_/\| (____/\/\____) |
-- (____\/_)(_______)\_______/(_______/(_______/(_______/\_______)

CREATE TABLE IF NOT EXISTS unoptimized.quizzes
(
    id bigint ,
    name text NOT NULL,
    course_id bigint NOT NULL REFERENCES unoptimized.courses(id),
    CONSTRAINT quizzes_pkey PRIMARY KEY (id)
);

insert into unoptimized.quizzes(id , "name" , course_id )
select id,
       concat ('quiz ' , floor(1 + random()*100000)), 
       floor(1 + random()*100000)
       from generate_series(1, 1000000) as id 
on conflict on constraint quizzes_pkey do nothing;

--  _______ _________          ______   _______  _       _________ _______       _______  _______           _______  _______  _______  _______ 
-- (  ____ \\__   __/|\     /|(  __  \ (  ____ \( (    /|\__   __/(  ____ \     (  ____ \(  ___  )|\     /|(  ____ )(  ____ \(  ____ \(  ____ \
-- | (    \/   ) (   | )   ( || (  \  )| (    \/|  \  ( |   ) (   | (    \/     | (    \/| (   ) || )   ( || (    )|| (    \/| (    \/| (    \/
-- | (_____    | |   | |   | || |   ) || (__    |   \ | |   | |   | (_____      | |      | |   | || |   | || (____)|| (_____ | (__    | (_____ 
-- (_____  )   | |   | |   | || |   | ||  __)   | (\ \) |   | |   (_____  )     | |      | |   | || |   | ||     __)(_____  )|  __)   (_____  )
--       ) |   | |   | |   | || |   ) || (      | | \   |   | |         ) |     | |      | |   | || |   | || (\ (         ) || (            ) |
-- /\____) |   | |   | (___) || (__/  )| (____/\| )  \  |   | |   /\____) |     | (____/\| (___) || (___) || ) \ \__/\____) || (____/\/\____) |
-- \_______)   )_(   (_______)(______/ (_______/|/    )_)   )_(   \_______)_____(_______/(_______)(_______)|/   \__/\_______)(_______/\_______)
--                                                                        (_____)                                                              

CREATE TABLE IF NOT EXISTS unoptimized.students_courses
(
    student_username text NOT NULL REFERENCES unoptimized.students(username),
    course_id bigint NOT NULL REFERENCES unoptimized.courses(id),
    CONSTRAINT students_courses_pkey PRIMARY KEY (student_username, course_id)
);

insert into unoptimized.students_courses(student_username , course_id )
select concat ('username ' , floor(1 + random()*1000000)), 
       floor(1 + random()*100000)
       from generate_series(1, 5000000) as id
on conflict on constraint students_courses_pkey do nothing;

--  _______ _________          ______   _______  _       _________ _______            _________ ______   _______  _______  _______ 
-- (  ____ \\__   __/|\     /|(  __  \ (  ____ \( (    /|\__   __/(  ____ \  |\     /|\__   __/(  __  \ (  ____ \(  ___  )(  ____ \
-- | (    \/   ) (   | )   ( || (  \  )| (    \/|  \  ( |   ) (   | (    \/  | )   ( |   ) (   | (  \  )| (    \/| (   ) || (    \/
-- | (_____    | |   | |   | || |   ) || (__    |   \ | |   | |   | (_____   | |   | |   | |   | |   ) || (__    | |   | || (_____ 
-- (_____  )   | |   | |   | || |   | ||  __)   | (\ \) |   | |   (_____  )  ( (   ) )   | |   | |   | ||  __)   | |   | |(_____  )
--       ) |   | |   | |   | || |   ) || (      | | \   |   | |         ) |   \ \_/ /    | |   | |   ) || (      | |   | |      ) |
-- /\____) |   | |   | (___) || (__/  )| (____/\| )  \  |   | |   /\____) |    \   /  ___) (___| (__/  )| (____/\| (___) |/\____) |
-- \_______)   )_(   (_______)(______/ (_______/|/    )_)   )_(   \_______)_____\_/   \_______/(______/ (_______/(_______)\_______)
--                                                                        (_____)                                                  

CREATE TABLE IF NOT EXISTS unoptimized.students_videos
(
    student_username text NOT NULL REFERENCES unoptimized.students(username),
    video_id bigint NOT NULL REFERENCES unoptimized.videos(id),
    CONSTRAINT students_videos_pkey PRIMARY KEY (student_username, video_id)
);

with students_courses_videos as (
    select sc.student_username, v.id as video_id
    from unoptimized.students_courses sc
    join unoptimized.videos v on v.course_id = sc.course_id
)
   
insert into unoptimized.students_videos(student_username , video_id)
    select students_courses_videos.student_username, 
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

CREATE TABLE IF NOT EXISTS unoptimized.students_quizzes
(
    student_username text NOT NULL REFERENCES unoptimized.students(username),
    quiz_id bigint NOT NULL REFERENCES unoptimized.quizzes(id),
    score integer NOT NULL,
    CONSTRAINT students_quizzes_pkey PRIMARY KEY (student_username, quiz_id)
);

with students_courses_quizzes as (
    select sc.student_username, q.id as quiz_id
    from unoptimized.students_courses sc
    join unoptimized.quizzes q on q.course_id = sc.course_id
)

insert into unoptimized.students_quizzes(student_username , quiz_id , score )
    select students_courses_quizzes.student_username, 
           students_courses_quizzes.quiz_id,
           floor(1 + random()*(100-1)) as score
    from students_courses_quizzes
    order by random()
    limit 10000000;