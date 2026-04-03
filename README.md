# Streaming Platform Analytics — Subscription, Revenue & Churn Analysis

**Tools:** SQL (Google BigQuery), Python, Tableau  
**Skills:** SQL Analytics, Cohort Analysis, Churn Analysis, Revenue Analytics, Subscriber Segmentation, Data Storytelling  
**Dataset:** 50,000 streaming subscribers | Subscription type, revenue, engagement, churn

---

##  Business Problem

Streaming platforms like Disney+, Netflix, and ESPN+ manage millions of subscribers across multiple tiers, devices, and geographies. Understanding **who churns, why they churn, and which segments drive the most revenue** is critical to yield management, pricing strategy, and retention investment decisions.

This project uses SQL on Google BigQuery to analyze 50,000 streaming subscribers — answering the key business questions that Disney's Decision Science and Integration (DDSI) team tackles daily:

- Which subscription plans drive the most revenue — and which churn the most?
- Which subscriber segments are high value vs at risk?
- How does engagement vary by content genre and device?
- What does the subscriber lifecycle look like across account age cohorts?

---

##  Dataset

- **Size:** 50,000 subscribers
- **Platform:** Google BigQuery (`streaming-analytics.streaming_data.subscribers`)
- **Key Variables:**

| Column | Description |
|---|---|
| `user_id` | Unique subscriber identifier |
| `age`, `gender`, `country` | Subscriber demographics |
| `subscription_type` | Basic, Standard, Premium |
| `monthly_fee` | Revenue per subscriber |
| `account_age_months` | Subscriber tenure |
| `primary_device` | Laptop, Mobile, Smart TV, Tablet |
| `avg_watch_time_minutes` | Engagement metric |
| `watch_sessions_per_week` | Frequency metric |
| `completion_rate` | Content completion percentage |
| `recommendation_click_rate` | Personalization engagement |
| `days_since_last_login` | Recency metric |
| `churned` | Binary churn indicator (0/1) |

---

##  Key Findings

### 1. Platform Overview

| Metric | Value |
|---|---|
| **Total Subscribers** | 50,000 |
| **Total Monthly Revenue** | $616,167 |
| **Average Revenue Per User** | $12.32/month |
| **Overall Churn Rate** | 19.93% |
| **Average Watch Time** | 154.9 minutes |
| **Most Popular Plan** | Standard (19,931 subscribers — 39.9%) |

> The 19.93% monthly churn rate is significantly above industry benchmarks of 2–5% for major streaming platforms (Netflix ~2-3%, Disney+ ~4-5%), indicating an urgent need for targeted retention intervention.

---

### 2. Revenue & Churn by Subscription Plan

| Plan | Subscribers | Monthly Revenue | Churn Rate |
|---|---|---|---|
| **Standard** | 19,931 | Highest volume | 19.24% |
| **Premium** | ~15,196 | Highest per-user | **20.39% — highest** |
| **Basic** | ~14,873 | Lowest per-user | 19.24% — lowest |

**Key Insight — Premium Subscribers Churn Most:**
Counterintuitively, Premium subscribers exhibit the highest churn rate at 20.39% — 1.15 percentage points above Basic tier. This suggests:
- Premium subscribers have higher expectations and lower tolerance for content gaps
- Price sensitivity at renewal drives cancellation when perceived value doesn't justify cost
- Retention investment should prioritize Premium subscribers — losing one represents the highest revenue impact per churned user

**Business Recommendation:** Implement personalized retention campaigns for Premium subscribers at the 30-day and 90-day marks — loyalty incentives and exclusive content previews targeted at this segment would have the highest ROI.

---

### 3. Churn by Device

| Device | Plan | Churn Rate |
|---|---|---|
| **Laptop — Premium** | Premium | **21.37% — highest** |
| **Mobile — Standard** | Standard | 20.41% |
| **Smart TV — Basic** | Basic | 18.71% — lowest |

**Key Insight:** Smart TV users have the lowest churn rate — consistent with research showing that living room viewing represents a more habitual, household-level commitment. Laptop viewers churn most, suggesting more casual, individual usage patterns with lower switching costs.

**Business Recommendation:** Optimize the Smart TV experience and incentivize device upgrades — subscribers who primarily use Smart TVs show the strongest retention behavior.

---

### 4. Content Engagement by Genre

| Genre | Avg Watch Time | Sessions/Week | Churn Rate |
|---|---|---|---|
| **Comedy** | 157.4 mins | 9.96 | 20.07% |
| **Action** | 154.1 mins | 10.02 | **19.26% — lowest churn** |
| **Thriller** | 154.9 mins | 9.9 | **20.51% — highest churn** |
| **Drama** | 154.7 mins | 9.96 | 19.43% |

**Key Insight:** Action genre subscribers have the lowest churn rate despite not having the highest watch time — suggesting that action content builds loyalty more effectively than high-consumption genres like Comedy. Thriller subscribers churn most despite moderate engagement.

**Business Recommendation:** Invest in action content library expansion as a retention tool — the genre's low churn rate indicates it builds habitual viewing behavior.

---

### 5. Subscriber Segmentation

| Segment | Subscribers | Monthly Revenue | Avg Days Since Login |
|---|---|---|---|
| **Standard — Active** | 18,433 | $255,147 (41.4%) | 26.4 days |
| **High Value — At Risk** | 8,044 | $128,624 (20.9%) | **45.1 days** |
| **Low Value — Active** | 13,349 | $106,659 (17.3%) | 29.5 days |
| **Churned** | 8,378 | $97,020 (15.7%) | 26.5 days |
| **High Value — Active** | 1,796 | $28,718 (4.7%) | 3.5 days |

**Critical Finding — High Value At-Risk Segment:**
8,044 High Value subscribers generating $128,624/month have not logged in for an average of **45.1 days** — nearly 3x longer than High Value Active subscribers (3.5 days). This segment represents the highest-priority retention opportunity: $128K in monthly revenue at immediate risk of churning.

**Business Recommendation:** Implement automated re-engagement campaigns triggered at 30 days of inactivity for Premium and Standard subscribers — personalized content recommendations, "we miss you" offers, and plan downgrade options to retain revenue at a reduced tier rather than losing it entirely.

---

### 6. Cohort Analysis by Account Age

| Cohort | Subscribers | Churn Rate | Avg Watch Time |
|---|---|---|---|
| **0–3 Months (New)** | 2,574 | 20.75% | 157.2 mins |
| **4–12 Months (Growing)** | 7,718 | 19.85% | 155.4 mins |
| **13–24 Months (Established)** | 10,216 | **20.77% — highest** | 155.1 mins |
| **25+ Months (Loyal)** | 29,492 | **19.58% — lowest** | 154.6 mins |

**Key Insight:** The Established cohort (13–24 months) has the highest churn rate — even higher than that of new subscribers. This suggests a "mid-life crisis" in the subscriber lifecycle where initial novelty has worn off, but loyalty hasn't fully formed. Loyal subscribers (25+ months) show the lowest churn, confirming that if a subscriber passes the 2-year mark, they are significantly more likely to stay long-term.

**Business Recommendation:** Design a targeted retention program specifically for the 12–24-month cohort — this is the critical window when subscribers are most at risk of lapsing before becoming loyal long-term users.

---

##  Executive Summary of Business Recommendations

1. **Premium retention program** — Premium subscribers churn the most despite paying the most; personalized loyalty incentives at 30 and 90 days would protect the highest-value revenue
2. **Re-engage High Value At-Risk segment** — 8,044 subscribers generating $128K/month haven't logged in for 45+ days; automated win-back campaigns should be triggered immediately
3. **Invest in Action content** — lowest churn genre; expanding the action library is a measurable retention investment
4. **Optimize Smart TV experience** — lowest churn device; household-level viewing builds stronger retention habits
5. **12–24 month cohort intervention** — the established cohort churns more than new subscribers; a targeted mid-lifecycle engagement program addresses this critical retention gap

---

##  SQL Queries

All 8 analysis blocks are available in `streaming_analysis.sql`:

| Query Block | Analysis |
|---|---|
| Block 1 | Dataset overview and KPIs |
| Block 2 | Revenue and churn by subscription plan |
| Block 3 | Geographic revenue analysis — top 15 countries |
| Block 4 | Churn by subscription type and primary device |
| Block 5 | Content engagement and churn by favorite genre |
| Block 6 | Subscriber segmentation — High Value, At Risk, Churned |
| Block 7 | Cohort analysis by account age |
| Block 8 | Executive summary KPIs |

---

##  Tableau Dashboard

An interactive dashboard visualizing key findings is available at:
[Tableau Public — Streaming Platform Analytics](https://public.tableau.com/app/profile/sneha.ashok.rao/viz/StreamingPlatformAnalytics-SubscriptionRevenueandChurnIntelligence/Dashboard) 

---

##  How to Run

```sql
-- All queries run on Google BigQuery
-- Dataset: streaming-analytics.streaming_data.subscribers
-- Replace project ID with your own BigQuery project

SELECT * FROM `your-project.streaming_data.subscribers` LIMIT 10;
```

---

##  Skills Demonstrated

- **SQL on Google BigQuery** — 8 analytical query blocks covering aggregation, window functions, CASE statements, UNION ALL, cohort analysis
- **Churn analysis** — identifying at-risk segments and quantifying revenue at risk
- **Subscriber segmentation** — RFM-style segmentation using revenue, recency, and activity
- **Cohort analysis** — subscriber lifecycle analysis by account age
- **Revenue analytics** — ARPU, MRR, plan-level revenue breakdown
- **Business communication** — translating SQL findings into actionable recommendations for marketing, finance, and product teams
- **Tableau** — interactive dashboard for non-technical stakeholder reporting

---
