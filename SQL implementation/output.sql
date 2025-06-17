-- Average quiz score per learner
SELECT learner_id, ROUND (AVG (score), 1) AS average_score
FROM QuizAttempt
GROUP BY learner_id;


-- Average watch percentage per learner per course
SELECT 
    l.learner_id,
    c.course_id,
    ROUND(SUM(a.watch_time) * 100.0 / SUM(content.duration), 2) AS watch_percentage
FROM ActivityLog a
JOIN Content content ON a.content_id = content.content_id
JOIN Course c ON content.course_id = c.course_id
JOIN Learner l ON a.learner_id = l.learner_id
WHERE content.type = 'video'
GROUP BY l.learner_id, c.course_id;

-- 3. Drop out percentage
SELECT COUNT(*) AS total_learners,
SUM(CASE WHEN DATEDIFF(last_activity, registration_date) <= 180 THEN 1 ELSE 0 END) AS dropout_count,
 ROUND(100.0 * SUM(CASE WHEN DATEDIFF(last_activity, registration_date) <= 180 THEN 1 ELSE 0 END) / COUNT(*),2) AS dropout_rate_percentage
FROM (SELECT l.learner_id, l.registration_date,
GREATEST(
COALESCE(MAX(al.timestamp), '1900-01-01'),
COALESCE(MAX(qa.attempt_date), '1900-01-01') ) AS last_activity
 FROM Learner l
 LEFT JOIN ActivityLog al ON l.learner_id = al.learner_id
 LEFT JOIN QuizAttempt qa ON l.learner_id = qa.learner_id
 GROUP BY l.learner_id, l.registration_date
  ) AS learner_activity;
