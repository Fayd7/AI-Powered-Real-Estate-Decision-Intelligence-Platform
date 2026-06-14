import pandas as pd
from pathlib import Path

RAW_PATH = Path("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/csv_data")

properties = pd.read_csv ( RAW_PATH / "properties.csv")
agents = pd.read_csv( RAW_PATH / "agents.csv")
marketing_campaigns = pd.read_csv( RAW_PATH / "marketing_campaigns.csv")
leads = pd.read_csv(RAW_PATH/ "leads.csv")
sales = pd.read_csv( RAW_PATH / "sales.csv")
customer_feedback_df = pd.read_csv( RAW_PATH / "customer_feedback.csv")

print(properties.info())
print(customer_feedback_df.info())
print(leads.info())
print(marketing_campaigns.info())
print(agents.info())
print(sales.info())

properties.columns
leads.columns
agents.columns
sales.columns
customer_feedback_df.columns
marketing_campaigns.columns

properties.describe()

properties.columns = ["property_id" , " property_name ", "property_type", "region",
                      "listed_price", "status"]

print(properties.columns)

sales.columns= ['sales_id', "property_id", 'agent_id', 'lead_id', 'sales_date',
                'listed_price', 'sales_amount']

print(sales.columns)

agents.columns = [
    "agent_id",
    "agent_name",
    "region",
    "experience_years"
]

marketing_campaigns.columns = [
    "campaign_id",
    "campaign_name",
    "channel",
    "spend",
    "start_date",
    "end_date"
]

leads.columns = [
    "lead_id",
    "campaign_id",
    "property_id",
    "lead_date",
    "lead_status",
    "region"
]
customer_feedback_df.columns = [
    "feedback_id",
    "agent_id",
    "rating",
    "review_text",
    "review_date"
]

print(leads.columns)
print(agents.columns)
print(marketing_campaigns.columns)
print(customer_feedback_df.columns)

leads['lead_date'] = pd.to_datetime (leads['lead_date'], dayfirst= True) 

marketing_campaigns['start_date'] = pd.to_datetime(
    marketing_campaigns['start_date'], dayfirst=True)

marketing_campaigns[ 'end_date'] = pd.to_datetime(
    marketing_campaigns[ 'end_date'], dayfirst=True)

sales["sales_date"] = pd.to_datetime(sales["sales_date"], dayfirst=True)

customer_feedback_df["review_date"] = pd.to_datetime(
    customer_feedback_df["review_date"],
    dayfirst=True
)

properties[properties['listed_price'].isna()]

print(properties.isnull().sum())
print(agents.isnull().sum())
print(leads.isnull().sum())
print(customer_feedback_df.isnull().sum())
print(marketing_campaigns.isnull().sum())
print(sales.isnull().sum())

properties["listed_price"] = properties["listed_price"].fillna(
    properties["listed_price"].median())

print(properties.isnull().sum())

print(properties['status'].unique())
print(leads["lead_status"].unique())
print(properties["region"].unique())
print(leads["region"].unique())
print(agents["region"].unique())

properties["status"] = properties["status"].str.strip().str.title()

properties["region"] = properties["region"].str.strip().str.title()

leads["lead_status"] = leads["lead_status"].str.strip().str.title()

leads["region"] = leads["region"].str.strip().str.title()

agents["region"] = agents["region"].str.strip().str.title()

print('properties :' , properties.duplicated().sum())
print("Agents:", agents.duplicated().sum())
print("Campaigns:", marketing_campaigns.duplicated().sum())
print("Leads:", leads.duplicated().sum())
print("Sales:", sales.duplicated().sum())
print("Feedback:", customer_feedback_df.duplicated().sum())

invalid_feedback= [(customer_feedback_df ['rating'] < 1),
        (customer_feedback_df ['rating'] >5)]

print(invalid_feedback)

customer_feedback_df['rating'] = customer_feedback_df['rating'].clip(1,5)
print(customer_feedback_df['rating'])

sales = sales[sales["sales_amount"] > 0]
invalid_sales = sales[sales["sales_amount"] <= 0]
print(invalid_sales)

sales.merge(
        leads[['lead_id','lead_status']],
          on = 'lead_id').query  ('lead_status ! = "converted"')

sales.merge(properties[['property_id', 'status']],
            on = 'property_id').query('status != "sold"')

sales[sales["agent_id"].isin(agents['agent_id'])]

sales[sales['property_id'].isin(properties['property_id'])]

sales[sales['lead_id'].isin(leads['lead_id'])]

rating_map = {
    "Excellent property viewing experience": 5,
    "Very professional throughout the transaction": 5,
    "Agent explained the mortgage process clearly": 4,
    "Property listing information was outdated": 2,
    "Service charge details were unclear": 2,
    "Follow-up took too long": 2,
    "Agent missed scheduled viewing": 1
}

customer_feedback_df['rating'] = customer_feedback_df['review_text'].map(rating_map)
print(
    customer_feedback_df[
        ["review_text", "rating"]
    ].head(10)
)


import os
os.makedirs(r"C:\Users\user\OneDrive\Desktop\AI-Powered Real Estate Decision Intelligence Platform\Data_architecture\processed",
            exist_ok= True)

import os
print(os.getcwd())

import os

print(os.path.exists(r"C:\Users\user\OneDrive\Desktop\AI-Powered Real Estate Decision Intelligence Platform\Data_architecture\processed"))

import os

print(os.path.exists(r"C:\Users\user\OneDrive\Desktop\AI-Powered Real Estate Decision Intelligence Platform\Data_architecture\processed"))


print(type(properties))
print(properties.shape)

properties.to_csv('test.csv')

import os
os.makedirs(r"C:\Users\user\OneDrive\Desktop\AI-Powered Real Estate Decision Intelligence Platform\Data_architecture\processed",
            exist_ok= True)

print(os.path.abspath('processed'))

properties.to_csv("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/processed/clean_properties.csv", index=False)
agents.to_csv("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/processed/clean_agents.csv", index=False)
leads.to_csv("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/processed/clean_leads.csv", index=False)
sales.to_csv("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/processed/clean_sales.csv", index=False)
marketing_campaigns.to_csv("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/processed/clean_marketing_campaigns.csv", index=False)
customer_feedback_df.to_csv("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/processed/clean_customer_feedback.csv", index=False)


leads = leads.drop_duplicates(subset= ['lead_id'])

leads.to_csv("C:/Users/user/OneDrive/Desktop/AI-Powered Real Estate Decision Intelligence Platform/Data_architecture/processed/clean_leads.csv", index=False)
print('clean_leads.csv updated succesfully')