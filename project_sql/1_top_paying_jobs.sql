-- Question: What are the top-paying Data Analyst jobs?


SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact

INNER JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id

WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True AND
    salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC
LIMIT 10