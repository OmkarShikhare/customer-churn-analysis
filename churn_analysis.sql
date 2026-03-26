CREATE DATABASE churn_analysis;

USE churn_analysis;

CREATE TABLE churn_data (
    user_id INT,
    signup_date DATE,
    last_active_days_ago INT,
    plan_type VARCHAR(20),
    monthly_usage INT,
    feature_A_used TINYINT,
    feature_B_used TINYINT,
    support_tickets INT,
    churned TINYINT);
    
desc churn_data;

-- Overall churn rate
SELECT COUNT(CASE WHEN churned = 1 THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM churn_data;


-- Churn by plan
select plan_type,count(*) as users,sum(churned) as churned_user, sum(churned)*100/count(*) as churned_rate
from churn_data
group by plan_type;


-- Activity VS Churn
select last_active_days_ago, avg(churned) as churned_rate
from churn_data
group by last_active_days_ago
order by last_active_days_ago;

-- Activity VS churn by plan
select plan_type, avg(last_active_days_ago) as avg_inactive_days,
		avg(monthly_usage) as avg_usage,
        avg(churned) as churn_rate
from churn_data
group by plan_type;


SELECT feature_A_used,feature_B_used,AVG(churned) AS churn_rate
FROM churn_data
GROUP BY feature_A_used, feature_B_used;

SELECT plan_type, AVG(churned) AS churn_rate
FROM churn_data
GROUP BY plan_type;