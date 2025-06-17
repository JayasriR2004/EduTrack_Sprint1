-- CREATING TABLES:
Creating table `Learners`:
CREATE TABLE Learners (
    learner_id INT,
    name VARCHAR(100),
    email VARCHAR(100) ,
    registration_date DATE
);

-- Creating table `Course`:
CREATE TABLE Course (
    course_id INT ,
    title VARCHAR(200),
    category VARCHAR(100),
    duration INT
);

-- Creating table `Contents`:
CREATE TABLE Contents (
    content_id INT,
    course_id INT,
    type VARCHAR(20) CHECK (type IN ('video', 'pdf')),
    title VARCHAR(200),
    duration INT,
);

-- Creating table `ActivityLog`:
CREATE TABLE ActivityLog (
    activity_id INT ,
    learner_id INT,
    content_id INT,
    watch_time INT,
    timestamp DATETIME,
);

-- Creating table `Quiz`:
CREATE TABLE Quiz (
    quiz_id INT ,
    course_id INT,
    title VARCHAR(100),
    total_marks INT,
    pass_mark INT,
);

-- Creating table `Quiz Attempt`:
CREATE TABLE Quiz_Attempt (
    attempt_id INT PRIMARY KEY,
    quiz_id INT,
    learner_id INT,
    score FLOAT,
    attempt_date DATE,
);

-- Creating table `Feedback`:
CREATE TABLE Feedback (
    feedback_id INT,
    learner_id INT,
    course_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    sentiment_tag VARCHAR(20),
);


-- PERFORMING CRUD OPERATIONS:

DESCRIBE learners;
ALTER TABLE learners ADD PRIMARY KEY (learner_id);
ALTER TABLE learners MODIFY COLUMN email VARCHAR(70);
ALTER TABLE learners ADD CONSTRAINT U_email UNIQUE(email);
ALTER TABLE learners MODIFY COLUMN registration_date DATE;

DESCRIBE courses;
ALTER TABLE courses ADD PRIMARY KEY (course_id);


DESCRIBE content;
ALTER TABLE content ADD PRIMARY KEY (content_id);
ALTER TABLE content ADD CONSTRAINT fk_courseid FOREIGN KEY (course_id) REFERENCES courses(course_id);

DESCRIBE activity_log;
ALTER TABLE activity_log ADD PRIMARY KEY (activity_id);
ALTER TABLE activity_log ADD CONSTRAINT fk_learner FOREIGN KEY (learner_id) REFERENCES learners(learner_id);
ALTER TABLE activity_log ADD CONSTRAINT fk_content FOREIGN KEY (content_id) REFERENCES content(content_id);

DESCRIBE quiz;
ALTER TABLE quiz ADD PRIMARY KEY (quiz_id);
ALTER TABLE quiz ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(course_id);

DESCRIBE quiz_attempt;
ALTER TABLE quiz_attempt ADD PRIMARY KEY (attempt_id);
ALTER TABLE quiz_attempt MODIFY COLUMN quiz_id INT;
ALTER TABLE quiz_attempt MODIFY COLUMN attempt_date DATE;
ALTER TABLE quiz_attempt ADD CONSTRAINT fk_quiz FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id);
ALTER TABLE quiz_attempt ADD CONSTRAINT fk_learnerid FOREIGN KEY (learner_id) REFERENCES learners(learner_id);

DESCRIBE feedback;
ALTER TABLE feedback ADD PRIMARY KEY (feedback_id);
ALTER TABLE feedback ADD CONSTRAINT fk_learn FOREIGN KEY (learner_id) REFERENCES learners(learner_id);
ALTER TABLE feedback ADD CONSTRAINT fk_courses FOREIGN KEY (course_id) REFERENCES courses(course_id);
