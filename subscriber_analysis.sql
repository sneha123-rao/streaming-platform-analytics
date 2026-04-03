-- ============================================
-- 1: DATASET OVERVIEW
-- ============================================

SELECT
  COUNT(*) AS total_subscribers,
  COUNT(DISTINCT country) AS total_countries,
  ROUND(AVG(age), 1) AS avg_age,
  ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
  ROUND(SUM(monthly_fee), 2) AS total_monthly_revenue,
  COUNTIF(churned =TRUE) AS total_churned,
  ROUND(COUNTIF(churned = TRUE) / COUNT(*) * 100, 2) AS churn_rate_pct
FROM `streaming-analytics-492102.streaming_data.subscribers` 
LIMIT 1000;

-- ============================================
-- 2: REVENUE & SUBSCRIBERS BY PLAN
-- ============================================

SELECT
  subscription_type,
  COUNT(*) AS total_subscribers,
  ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
  ROUND(SUM(monthly_fee), 2) AS total_monthly_revenue,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 1) AS pct_of_subscribers,
  COUNTIF(churned = TRUE) AS churned_count,
  ROUND(COUNTIF(churned = TRUE) / COUNT(*) * 100, 2) AS churn_rate_pct
FROM `streaming-analytics-492102.streaming_data.subscribers` 
GROUP BY subscription_type
ORDER BY total_monthly_revenue DESC;

-- ============================================
-- 3: GEOGRAPHIC REVENUE ANALYSIS
-- ============================================

SELECT
  country,
  COUNT(*) AS total_subscribers,
  ROUND(SUM(monthly_fee), 2) AS total_monthly_revenue,
  ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
  ROUND(AVG(avg_watch_time_minutes), 1) AS avg_watch_time,
  ROUND(COUNTIF(churned = TRUE) / COUNT(*) * 100, 2) AS churn_rate_pct
FROM `streaming-analytics-492102.streaming_data.subscribers` 
GROUP BY country
ORDER BY total_monthly_revenue DESC
LIMIT 15;

-- ============================================
--4: CHURN DEEP DIVE
-- ============================================

-- Churn by subscription type and primary device
SELECT
  subscription_type,
  primary_device,
  COUNT(*) AS total_subscribers,
  COUNTIF(churned = TRUE) AS churned,
  ROUND(COUNTIF(churned = TRUE) / COUNT(*) * 100, 2) AS churn_rate_pct,
  ROUND(AVG(days_since_last_login), 1) AS avg_days_since_login,
  ROUND(AVG(avg_watch_time_minutes), 1) AS avg_watch_time
FROM `streaming-analytics-492102.streaming_data.subscribers` 
GROUP BY subscription_type, primary_device
ORDER BY churn_rate_pct DESC;

-- ============================================
-- 5: CONTENT ENGAGEMENT BY GENRE
-- ============================================

SELECT
  favorite_genre,
  COUNT(*) AS total_subscribers,
  ROUND(AVG(avg_watch_time_minutes), 1) AS avg_watch_time_mins,
  ROUND(AVG(watch_sessions_per_week), 2) AS avg_sessions_per_week,
  ROUND(AVG(completion_rate), 3) AS avg_completion_rate,
  ROUND(AVG(recommendation_click_rate), 3) AS avg_rec_click_rate,
  ROUND(COUNTIF(churned = TRUE) / COUNT(*) * 100, 2) AS churn_rate_pct
FROM `streaming-analytics-492102.streaming_data.subscribers` 
GROUP BY favorite_genre
ORDER BY avg_watch_time_mins DESC;

-- ============================================
-- 6: SUBSCRIBER SEGMENTATION
-- ============================================

SELECT
  CASE
    WHEN monthly_fee >= 15 AND churned = FALSE AND days_since_last_login <= 7
      THEN 'High Value — Active'
    WHEN monthly_fee >= 15 AND days_since_last_login > 30
      THEN 'High Value — At Risk'
    WHEN monthly_fee < 12 AND churned = FALSE
      THEN 'Low Value — Active'
    WHEN churned = TRUE
      THEN 'Churned'
    ELSE 'Standard — Active'
  END AS subscriber_segment,
  COUNT(*) AS total_subscribers,
  ROUND(SUM(monthly_fee), 2) AS total_revenue,
  ROUND(AVG(avg_watch_time_minutes), 1) AS avg_watch_time,
  ROUND(AVG(days_since_last_login), 1) AS avg_days_since_login
FROM `streaming-analytics-492102.streaming_data.subscribers` 
GROUP BY subscriber_segment
ORDER BY total_revenue DESC;

-- ============================================
-- 7: COHORT ANALYSIS BY ACCOUNT AGE
-- ============================================

SELECT
  CASE
    WHEN account_age_months <= 3 THEN '0-3 Months (New)'
    WHEN account_age_months <= 12 THEN '4-12 Months (Growing)'
    WHEN account_age_months <= 24 THEN '13-24 Months (Established)'
    ELSE '25+ Months (Loyal)'
  END AS account_age_cohort,
  COUNT(*) AS total_subscribers,
  ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee,
  ROUND(AVG(avg_watch_time_minutes), 1) AS avg_watch_time,
  ROUND(AVG(watch_sessions_per_week), 2) AS avg_sessions_per_week,
  ROUND(COUNTIF(churned = TRUE) / COUNT(*) * 100, 2) AS churn_rate_pct
FROM `streaming-analytics-492102.streaming_data.subscribers` 
GROUP BY account_age_cohort
ORDER BY MIN(account_age_months);

-- ============================================
-- 8: EXECUTIVE SUMMARY
-- ============================================

SELECT
  'Total Subscribers' AS metric,
  CAST(COUNT(*) AS STRING) AS value
FROM `streaming-analytics-492102.streaming_data.subscribers` 
UNION ALL

SELECT 'Total Monthly Revenue',
  CONCAT('$', CAST(ROUND(SUM(monthly_fee), 2) AS STRING))
FROM `streaming-analytics-492102.streaming_data.subscribers` 
UNION ALL

SELECT 'Overall Churn Rate',
  CONCAT(CAST(ROUND(COUNTIF(churned=TRUE)/COUNT(*)*100, 2) AS STRING), '%')
FROM `streaming-analytics-492102.streaming_data.subscribers` 
UNION ALL

SELECT 'Avg Watch Time (mins)',
  CAST(ROUND(AVG(avg_watch_time_minutes), 1) AS STRING)
FROM `streaming-analytics-492102.streaming_data.subscribers` ;

-- Most popular plan
SELECT
  subscription_type,
  COUNT(*) AS total_subscribers
FROM `streaming-analytics-492102.streaming_data.subscribers`
GROUP BY subscription_type
ORDER BY total_subscribers DESC
LIMIT 1;
