-- ============================================================
-- Blinkit Dark Store Delivery Performance: Business Questions
-- Table: orders (cleaned dataset, 6,002 rows)
-- ============================================================

-- 1. Which dark stores have the highest % of late deliveries?
-- (Helps identify which stores need operational attention)
SELECT
    dark_store_id,
    city,
    COUNT(*) AS total_orders,
    SUM(is_late) AS late_orders,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_pct
FROM orders
GROUP BY dark_store_id, city
ORDER BY late_pct DESC;


-- 2. What is the late-delivery rate by hour of day?
-- (Identifies peak hours where delivery performance breaks down)
SELECT
    order_hour,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_pct,
    ROUND(AVG(actual_delivery_min), 1) AS avg_delivery_min
FROM orders
GROUP BY order_hour
ORDER BY order_hour;


-- 3. Which product categories have the slowest average delivery time?
-- (Useful for category-specific picking/packing process review)
SELECT
    category,
    COUNT(*) AS total_orders,
    ROUND(AVG(actual_delivery_min), 1) AS avg_delivery_min,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_pct
FROM orders
GROUP BY category
ORDER BY avg_delivery_min DESC;


-- 4. Top 10 delivery partners with the most late deliveries
-- (Used for partner-level coaching/performance follow-up)
SELECT
    delivery_partner_id,
    COUNT(*) AS total_deliveries,
    SUM(is_late) AS late_deliveries,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_pct
FROM orders
WHERE delivery_partner_id != 'UNKNOWN'
GROUP BY delivery_partner_id
HAVING total_deliveries >= 10
ORDER BY late_deliveries DESC
LIMIT 10;


-- 5. City-wise order volume, average delay, and average customer rating
-- (City-level snapshot for leadership reporting)
SELECT
    city,
    COUNT(*) AS total_orders,
    ROUND(AVG(delay_min), 1) AS avg_delay_min,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_pct
FROM orders
GROUP BY city
ORDER BY late_pct DESC;


-- 6. Day-over-day trend of late delivery % over the period
-- (Are things improving or getting worse over time?)
SELECT
    order_date,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_pct
FROM orders
GROUP BY order_date
ORDER BY order_date;


-- 7. Does customer rating drop as delivery delay increases?
-- (Links operational delay directly to customer experience)
SELECT
    CASE
        WHEN delay_min <= 0 THEN 'On time / early'
        WHEN delay_min BETWEEN 0.1 AND 5 THEN 'Late by 0-5 min'
        WHEN delay_min BETWEEN 5.1 AND 10 THEN 'Late by 5-10 min'
        ELSE 'Late by 10+ min'
    END AS delay_bucket,
    COUNT(*) AS total_orders,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM orders
GROUP BY delay_bucket
ORDER BY avg_rating ASC;


-- 8. Which store + hour combination has the worst on-time performance?
-- (Pinpoints exactly where and when to focus operational fixes)
SELECT
    dark_store_id,
    order_hour,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 1) AS late_pct
FROM orders
GROUP BY dark_store_id, order_hour
HAVING total_orders >= 5
ORDER BY late_pct DESC
LIMIT 10;
