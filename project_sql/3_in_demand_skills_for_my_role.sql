-- Question: What are the most in-demand skills for Data Analyst jobs?


WITH job_skill_count AS (
    SELECT
        skills_job_dim.skill_id,
        COUNT(*) AS skill_count

    FROM skills_job_dim

        INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id

    WHERE job_title_short = 'Data Analyst'
    GROUP BY skills_job_dim.skill_id
    ORDER BY skill_count DESC
)

SELECT
    skill_count,
    skills
FROM job_skill_count

INNER JOIN skills_dim ON skills_dim.skill_id = job_skill_count.skill_id

ORDER BY skill_count DESC
LIMIT 5;