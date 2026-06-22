# SQL Query Results

Results from `business_questions.sql`, run against `clean_orders.csv` (6,002 rows).

## 1. Late delivery % by dark store

| dark_store_id   | city     |   total_orders |   late_orders |   late_pct |
|:----------------|:---------|---------------:|--------------:|-----------:|
| MUM-DS-01       | Mumbai   |            220 |           154 |       70   |
| MUM-DS-02       | Mumbai   |            243 |           166 |       68.3 |
| NOI-DS-02       | Noida    |            404 |           264 |       65.3 |
| GGN-DS-02       | Gurugram |            400 |           255 |       63.8 |
| PUN-DS-01       | Pune     |            742 |           473 |       63.7 |

## 2. Late delivery % by hour of day

|   order_hour |   total_orders |   late_pct |   avg_delivery_min |
|-------------:|---------------:|-----------:|-------------------:|
|           21 |            312 |       95.8 |               21.9 |
|           20 |            367 |       93.7 |               21   |
|           13 |            361 |       93.1 |               21   |
|           19 |            390 |       92.3 |               21.4 |
|           12 |            357 |       91.3 |               20.8 |

## 3. Avg delivery time & late % by category

| category             |   total_orders |   avg_delivery_min |   late_pct |
|:---------------------|---------------:|-------------------:|-----------:|
| Personal Care        |            615 |               17.2 |       64.2 |
| Household Essentials |            585 |               17   |       65.1 |
| Bakery               |            616 |               17   |       64   |
| Baby Care            |            583 |               17   |       63.1 |
| Snacks               |            604 |               16.9 |       62.4 |

## 4. Top delivery partners by late deliveries

| delivery_partner_id   |   total_deliveries |   late_deliveries |   late_pct |
|:----------------------|-------------------:|------------------:|-----------:|
| DP186                 |                 50 |                36 |       72   |
| DP250                 |                 51 |                35 |       68.6 |
| DP208                 |                 52 |                35 |       67.3 |
| DP175                 |                 46 |                35 |       76.1 |
| DP139                 |                 47 |                35 |       74.5 |

## 5. City-wise volume, delay, rating

| city      |   total_orders |   avg_delay_min |   avg_rating |   late_pct |
|:----------|---------------:|----------------:|-------------:|-----------:|
| Mumbai    |            714 |             2.1 |         4.18 |       66.2 |
| Pune      |            742 |             1.9 |         4.26 |       63.7 |
| Noida     |            781 |             1.8 |         4.27 |       63.4 |
| Chennai   |            739 |             1.8 |         4.24 |       62.5 |
| Gurugram  |            798 |             2   |         4.27 |       62.4 |
| Delhi     |            740 |             1.9 |         4.26 |       62.3 |
| Hyderabad |            782 |             2.1 |         4.26 |       61.4 |
| Bengaluru |            706 |             1.7 |         4.34 |       59.1 |

## 6. Day-over-day late % trend (first 5 days)

| order_date   |   total_orders |   late_pct |
|:-------------|---------------:|-----------:|
| 2026-05-01   |            141 |       64.5 |
| 2026-05-02   |            158 |       59.5 |
| 2026-05-03   |            126 |       65.1 |
| 2026-05-04   |            132 |       64.4 |
| 2026-05-05   |            128 |       59.4 |

## 7. Customer rating vs delay bucket

| delay_bucket     |   total_orders |   avg_rating |
|:-----------------|---------------:|-------------:|
| Late by 10+ min  |            331 |         4.16 |
| On time / early  |           2243 |         4.26 |
| Late by 0-5 min  |           2253 |         4.27 |
| Late by 5-10 min |           1175 |         4.27 |

## 8. Worst store + hour combinations

| dark_store_id   |   order_hour |   total_orders |   late_pct |
|:----------------|-------------:|---------------:|-----------:|
| BLR-DS-01       |           13 |             23 |        100 |
| BLR-DS-02       |           19 |             22 |        100 |
| BLR-DS-02       |           21 |             20 |        100 |
| DEL-DS-01       |           12 |             11 |        100 |
| DEL-DS-01       |           19 |             16 |        100 |

