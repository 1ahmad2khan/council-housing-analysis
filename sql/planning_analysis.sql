-- ============================================================
-- COUNCIL PLANNING APPLICATIONS ANALYSIS -- SQL QUERIES
-- Dataset: UK Government PS1 Planning Application Statistics
-- ============================================================


-- ------------------------------------------------------------
-- 1. TOTAL APPLICATIONS RECEIVED NATIONALLY
-- ------------------------------------------------------------
SELECT 
    SUM(apps_received) AS total_applications,
    COUNT(DISTINCT local_authority) AS total_authorities,
    COUNT(DISTINCT year_clean) AS years_covered
FROM planning_applications;


-- ------------------------------------------------------------
-- 2. NATIONAL TREND BY YEAR
-- ------------------------------------------------------------
SELECT 
    year_clean,
    SUM(apps_received) AS total_received,
    SUM(apps_decided) AS total_decided,
    SUM(apps_withdrawn) AS total_withdrawn
FROM planning_applications
GROUP BY year_clean
ORDER BY year_clean;


-- ------------------------------------------------------------
-- 3. APPLICATIONS BY REGION
-- ------------------------------------------------------------
SELECT 
    region,
    SUM(apps_received) AS total_received,
    ROUND(SUM(apps_received) * 100.0 / 
        (SELECT SUM(apps_received) FROM planning_applications), 2) 
        AS pct_of_national_total
FROM planning_applications
GROUP BY region
ORDER BY total_received DESC;


-- ------------------------------------------------------------
-- 4. TOP 15 LOCAL AUTHORITIES IN SOUTH WEST
-- ------------------------------------------------------------
SELECT 
    local_authority,
    SUM(apps_received) AS total_received,
    SUM(apps_decided) AS total_decided,
    SUM(enforcement_notices) AS total_enforcement_notices
FROM planning_applications
WHERE region = 'South West'
GROUP BY local_authority
ORDER BY total_received DESC
LIMIT 15;


-- ------------------------------------------------------------
-- 5. GLOUCESTER TREND BY YEAR
-- ------------------------------------------------------------
SELECT 
    year_clean,
    SUM(apps_received) AS total_received,
    SUM(apps_decided) AS total_decided,
    SUM(apps_received) - SUM(apps_decided) AS decision_gap
FROM planning_applications
WHERE local_authority LIKE '%Gloucester%'
GROUP BY year_clean
ORDER BY year_clean;


-- ------------------------------------------------------------
-- 6. DECISION EFFICIENCY BY LOCAL AUTHORITY (SOUTH WEST)
-- ------------------------------------------------------------
SELECT 
    local_authority,
    SUM(apps_received) AS total_received,
    SUM(apps_decided) AS total_decided,
    ROUND(SUM(apps_decided) * 100.0 / 
        NULLIF(SUM(apps_received), 0), 2) AS decision_rate_pct
FROM planning_applications
WHERE region = 'South West'
GROUP BY local_authority
ORDER BY decision_rate_pct DESC;


-- ------------------------------------------------------------
-- 7. ENFORCEMENT NOTICES BY REGION
-- ------------------------------------------------------------
SELECT 
    region,
    SUM(enforcement_notices) AS total_enforcement_notices,
    ROUND(SUM(enforcement_notices) * 1.0 / 
        NULLIF(SUM(apps_received), 0) * 1000, 2) 
        AS enforcement_rate_per_1000_apps
FROM planning_applications
GROUP BY region
ORDER BY total_enforcement_notices DESC;


-- ------------------------------------------------------------
-- 8. YEARS WHERE GLOUCESTER DECISIONS LAGGED SIGNIFICANTLY
-- ------------------------------------------------------------
SELECT 
    year_clean,
    SUM(apps_received) AS received,
    SUM(apps_decided) AS decided,
    SUM(apps_received) - SUM(apps_decided) AS gap
FROM planning_applications
WHERE local_authority LIKE '%Gloucester%'
GROUP BY year_clean
HAVING gap > 200
ORDER BY gap DESC;