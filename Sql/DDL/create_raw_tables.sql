/*
==================================================
Project: AI Real Estate Decision Intelligence Platform
File: create_raw_tables.sql
Purpose: Create raw ingestion tables
==================================================
*/

-- Properties
CREATE TABLE IF NOT EXISTS raw.properties (
    property_id VARCHAR(10),
    property_name VARCHAR(100),
    property_type VARCHAR(50),
    region VARCHAR(100),
    listed_price NUMERIC(18,2),
    status VARCHAR(30)
);

-- Marketing Campaigns
CREATE TABLE IF NOT EXISTS raw.marketing_campaigns (
    campaign_id VARCHAR(10),
    campaign_name VARCHAR(100),
    channel VARCHAR(50),
    spend NUMERIC(18,2),
    start_date DATE,
    end_date DATE
);

-- Agents
CREATE TABLE IF NOT EXISTS raw.agents (
    agent_id VARCHAR(10),
    agent_name VARCHAR(100),
    region VARCHAR(100),
    experience_years INTEGER
);

-- Leads
CREATE TABLE IF NOT EXISTS raw.leads (
    lead_id VARCHAR(10),
    campaign_id VARCHAR(10),
    property_id VARCHAR(10),
    lead_date DATE,
    lead_status VARCHAR(30)
);

-- Sales
CREATE TABLE IF NOT EXISTS raw.sales (
    sale_id VARCHAR(10),
    property_id VARCHAR(10),
    agent_id VARCHAR(10),
    lead_id VARCHAR(10),
    sale_date DATE,
    listed_price NUMERIC(18,2),
    sale_amount NUMERIC(18,2)
);

-- Customer Feedback
CREATE TABLE IF NOT EXISTS raw.customer_feedback (
    feedback_id VARCHAR(10),
    agent_id VARCHAR(10),
    rating INTEGER,
    review_text TEXT,
    review_date DATE
);