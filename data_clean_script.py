import pandas as pd
import numpy as np

df = pd.read_csv("data/raw_orders.csv", parse_dates=["order_datetime"])


# 1. Remove exact duplicates
df = df.drop_duplicates()

# 2. Standardize city names (strip whitespace, title case)
df["city"] = df["city"].astype(str).str.strip().str.title()

# 3. Fix invalid delivery times 
df.loc[df["actual_delivery_min"] <= 0, "actual_delivery_min"] = np.nan

# 4. Handle missing values
df["order_value_inr"] = df["order_value_inr"].fillna(df["order_value_inr"].median())
df["customer_rating"] = df["customer_rating"].fillna(df["customer_rating"].median())
df["delivery_partner_id"] = df["delivery_partner_id"].fillna("UNKNOWN")

# Drop rows where delivery time is missing/invalid
df = df.dropna(subset=["actual_delivery_min"])

# 5. Correct dtypes
df["customer_rating"] = df["customer_rating"].round().astype(int)
df["order_value_inr"] = df["order_value_inr"].round(2)
df["actual_delivery_min"] = df["actual_delivery_min"].round(1)

# 6. Feature engineering for analysis
df["delay_min"] = (df["actual_delivery_min"] - df["promised_delivery_min"]).round(1)
df["is_late"] = (df["delay_min"] > 0).astype(int)
df["order_hour"] = df["order_datetime"].dt.hour
df["order_date"] = df["order_datetime"].dt.date


df.to_csv("data/clean_orders.csv", index=False)

