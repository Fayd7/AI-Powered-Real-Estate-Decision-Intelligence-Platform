CREATE SCHEMA IF NOT EXISTS clean;

CREATE TABLE clean.properties (
    property_id VARCHAR(10) PRIMARY KEY,
    property_name VARCHAR(255),
    property_type VARCHAR(100),
    region VARCHAR(100),
    listed_price NUMERIC(15,2),
    status VARCHAR(50)
);

CREATE TABLE clean.agents (
    agent_id VARCHAR(10) PRIMARY KEY,
    agent_name VARCHAR(255),
    region VARCHAR(100),
    experience_years INTEGER
);

CREATE TABLE clean.marketing_campaigns (
    campaign_id VARCHAR(10) PRIMARY KEY,
    campaign_name VARCHAR(255),
    channel VARCHAR(100),
    spend NUMERIC(15,2),
    start_date DATE,
    end_date DATE
);

CREATE TABLE clean.leads (
    lead_id VARCHAR(10) PRIMARY KEY,
    campaign_id VARCHAR(10),
    property_id VARCHAR(10),
    lead_date DATE,
    lead_status VARCHAR(50),
    region VARCHAR(100)
);

CREATE TABLE clean.sales (
    sale_id VARCHAR(10) PRIMARY KEY,
    property_id VARCHAR(10),
    agent_id VARCHAR(10),
    lead_id VARCHAR(10),
    sale_date DATE,
    listed_price NUMERIC(15,2),
    sale_amount NUMERIC(15,2)
);

CREATE TABLE clean.customer_feedback (
    feedback_id VARCHAR(10) PRIMARY KEY,
    agent_id VARCHAR(10),
    rating INTEGER,
    review_text TEXT,
    review_date DATE
);

ALTER TABLE clean.customer_feedback
ALTER COLUMN rating TYPE NUMERIC(2,1);