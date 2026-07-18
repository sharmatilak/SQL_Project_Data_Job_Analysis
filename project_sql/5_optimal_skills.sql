-- Question: What are the most optimal skills to learn ( should be in high demand and also high pay)

WITH top_skills AS (
    
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS rokda -- Rokda means money in hindi lol
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE

GROUP BY skills_job_dim.skill_id

), demand_skills AS (

SELECT
    skills_job_dim.skill_id,
    skills_dim.skills,
    COUNT(*) AS skill_count

FROM skills_job_dim

INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE job_title_short = 'Data Analyst'
GROUP BY skills_job_dim.skill_id, skills_dim.skills

)


SELECT
    demand_skills.skill_id,
    demand_skills.skills,
    rokda,
    skill_count
FROM demand_skills
INNER JOIN top_skills ON demand_skills.skill_id = top_skills.skill_id
ORDER BY 
    skill_count DESC,
    rokda DESC
LIMIT 25