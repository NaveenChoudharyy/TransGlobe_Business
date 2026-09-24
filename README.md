# TransGlobe_Business — End-to-End Logistics Analytics Project

> **Data Analytics Portfolio Project | SQL Server • Python • Machine Learning • Power BI**

## 1. Project Overview

**TransGlobe_Business** is an end-to-end logistics analytics project built using a logistics dataset published on **Kaggle**.

The project combines **SQL Server, Python, machine learning, and Power BI** to transform logistics data into:

- Business-focused SQL analysis
- Exploratory data analysis and operational insights
- A predictive model for late-delivery risk
- An interactive Power BI dashboard
- Actionable operational insights

### Business Domain

**Third-Party Logistics (3PL) and Last-Mile Delivery**

The project uses the fictional business context of **TransGlobe Logistics Pvt. Ltd.**, covering shipments across:

- 25 major Indian cities
- 10 carrier partners
- 30 warehouses
- 3,000+ customers
- 22,000+ shipment records


### Dataset Source

**Kaggle:** [TransGlobe_Business](https://www.kaggle.com/datasets/iamxman/transglobe-business)

---

## 2. Business Problem Statement

TransGlobe Logistics needs to understand why shipments are being delivered late and identify operational patterns associated with delivery delays.

The original business scenario describes a largely reactive delay-investigation process: after a shipment is delayed, analysts investigate factors such as the carrier, warehouse, weather, traffic, and route.

The project therefore addresses two connected objectives:

1. **Descriptive and diagnostic analytics** — understand shipment performance, costs, carriers, customers, warehouses, routes and operational delay patterns.
2. **Predictive analytics** — predict whether a shipment will be delivered late using a binary classification model.

The classification target is:

```text
Late_Delivery = 1 → Late delivery
Late_Delivery = 0 → Not late
```

The business objective is to move toward proactive delivery-risk identification so that operations teams can investigate potentially high-risk shipments before the delivery outcome is known.

---

# 3. Dataset & Data Model

The project started with:

```text
10 Excel data files
        +
1 Excel data dictionary
```

The data was converted into a SQL Server relational database named:

```text
LogisticsAnalyticsDB
```

using the `dbo` schema.

### Database Structure

The documented database uses a **Snowflake-style schema** centered around `Fact_Shipments`.

Main tables:

```text
Fact_Shipments
Dim_Dates
Dim_Customers
Dim_Products
Dim_Employees
Dim_Vehicles
Dim_Routes
Dim_Warehouses
Dim_Locations
Dim_Carriers
```

The documented grain of `Fact_Shipments` is one row per shipment/shipment leg, depending on the schema documentation version.

`Dim_Locations` acts as a shared snowflaked dimension used by customer and route-related entities.

### Approximate Dataset Size

| Table | Rows | Columns |
|---|---:|---:|
| Fact_Shipments | 22,110 | 32 |
| Dim_Dates | 1,096 | 10 |
| Dim_Customers | 3,000 | 6 |
| Dim_Products | 800 | 7 |
| Dim_Employees | 900 | 5 |
| Dim_Vehicles | 500 | 6 |
| Dim_Routes | 350 | 6 |
| Dim_Warehouses | 30 | 6 |
| Dim_Locations | 25 | 6 |
| Dim_Carriers | 10 | 5 |
| **Total** | **~29,821** | **89 documented columns** |

---

# 4. Tools & Technologies

## Database

- **SQL Server**
- **Python `pyodbc`**

Used for database creation, relational data storage, joins and business analysis.

## Python & Data Analytics

- **Python**
- **pandas**
- **NumPy**
- **scikit-learn**
- **XGBoost**
- **Jupyter Notebook**
- **Pickle**

Used for data cleaning, preparation, feature engineering, classification modeling, model evaluation, hyperparameter tuning and model serialization.

## Business Intelligence

- **Power BI**
- **Power Query**
- **DAX**

Used for data transformation, data modeling, KPI development, analytical reporting and dashboard design.

## Design & AI-Assisted Tools

- **ChatGPT** — technical assistance, troubleshooting, SQL/Python/modeling guidance and project documentation.
- **Claude** — additional AI-assisted ideation and review during project development.
- **Figma** — dashboard background, layout and visual design.
- **stitch.google** — dashboard UI/mockup and design ideation.

---

# 5. End-to-End Data Analytics Workflow

```text
Kaggle Excel Dataset
        │
        ▼
1. Dataset & Data Dictionary Understanding
        │
        ▼
2. SQL Server Database Creation
   Python + pyodbc
        │
        ▼
3. 40 Business SQL Problems
        │
        ▼
4. Python Data Cleaning
        │
        ▼
5. Classification Data Preparation
        │
        ▼
6. Model Building & Comparison
        │
        ▼
7. Gradient Boosting Selection
        │
        ▼
8. GridSearchCV Hyperparameter Tuning
        │
        ▼
9. Pickle Model
        │
        ▼
10. Power BI Transformation
        │
        ▼
11. Power BI Data Modeling
        │
        ▼
12. DAX Measures & KPIs
        │
        ▼
13. Interactive Four-Page Dashboard
```

---

## 5.1 Understanding the Dataset

The first stage was understanding the source Excel files and the accompanying data dictionary.

The data dictionary was used to understand:

- Table structures
- Column definitions
- Data types
- Relationships
- Business meaning of variables
- Fact and dimension tables

This established the foundation for both SQL analysis and machine-learning preparation.

---

## 5.2 SQL Server Database Creation — Python + pyodbc

Python was used to connect to SQL Server through `pyodbc` and create the project database.

### Database

```text
Database: LogisticsAnalyticsDB
Schema: dbo
```

The 10 Excel files were loaded as relational tables.

The resulting database was organized around a central shipment fact table with supporting dimensions for dates, customers, products, routes, warehouses, employees, vehicles, carriers and locations.

---

## 5.3 SQL-Based Business Problem Solving — 40 Questions

After creating the database, **40 business problems** were solved using SQL Server.

The questions were organized into four major analytical areas.

### A. Core Shipment & Delivery Performance

Analysis included:

- Total shipments
- Overall late-delivery rate
- Shipment-status distribution
- Average shipping cost
- Order value by shipping priority
- Active customer count
- Delivery-mode volume
- Promised vs. actual delivery time
- Payment-method usage
- Shipment-distance statistics and invalid-distance checks

### B. Carrier, Customer & Operational Analysis

Analysis included:

- Carrier late-delivery rates
- Weather-condition performance
- Customer-region shipping cost
- Distance-bucket late rates
- Highest-value cities
- Shipping priority × carrier-type analysis
- Warehouse handling/loading times
- High-frequency customers
- Traffic-condition late rates
- Fragile vs. non-fragile shipment performance

### C. Trend, Ranking & Cost Analysis

Analysis included:

- Carrier rankings
- Customer latest shipments
- Day-over-day shipment volume
- Shipping-cost quartiles
- Cumulative order value
- Month-over-month late-delivery trends
- Carrier utilization by route
- Shipments above carrier-average cost
- Product-category contribution
- Traffic × weather risk combinations

### D. Advanced Management & Risk Analysis

The advanced SQL analysis included:

- Carrier scorecards
- Customer cohort analysis
- Statistical identification of high-risk carriers
- Quarter-over-quarter route deterioration
- Warehouse employee efficiency
- Traffic × weather matrices
- Customer risk flags
- Vehicle-age analysis
- Top products by category with cumulative revenue contribution
- Distance-decile-based shipping-cost anomaly detection

The SQL work demonstrates both standard querying and advanced analytical SQL techniques.

---

# 5.3 Data Cleaning — Python / Jupyter

After the SQL analysis, the data was cleaned and prepared in Python.

The cleaning process included:

- Missing/null-value analysis
- Duplicate checks
- Data-type corrections
- Categorical-value standardization
- Invalid-value checks
- Outlier analysis
- Numerical validation
- Preparation of clean analytical datasets

Examples of data-quality issues considered included inconsistent categorical text values, missing operational fields and invalid shipment-distance values.

The cleaning stage was performed before downstream classification modeling and BI preparation.

---


# 5.4 Exploratory Data Analysis — Python / Jupyter

After data cleaning, an extensive exploratory data analysis was performed in Python/Jupyter to identify operational factors associated with delivery delays.

The EDA contains **20 business-focused analytical questions**, with each question supported by a summary table and visual analysis.

### EDA Questions

| # | Business Question |
|---|---|
| **Q1** | How does shipping priority influence delivery performance, and are higher-priority shipments delivered closer to their promised delivery time? |
| **Q2** | How does route distance affect delivery performance, and are longer-distance shipments more likely to be delivered late? |
| **Q3** | To what extent do traffic and weather conditions influence delivery performance, and which combinations are associated with higher late-delivery rates? |
| **Q4** | How does delivery mode affect delivery reliability, delivery time, and the gap between promised and actual delivery days? |
| **Q5** | Are customers with a history of previous delivery delays more likely to experience another late delivery? |
| **Q6** | How do package weight and volume affect delivery time and the likelihood of late delivery? |
| **Q7** | How does delivery performance vary across carriers, and are high-volume carriers consistent in meeting delivery commitments? |
| **Q8** | Does longer warehouse processing time lead to higher late-delivery rates and longer delivery times? |
| **Q9** | Do shipments requiring more handling or loading time have higher late-delivery rates and longer actual delivery times? |
| **Q10** | How consistently are shipments processed and delivered across different warehouses, and does warehouse activity relate to delivery performance? |
| **Q11** | Do older vehicles experience higher late-delivery rates or longer delivery times than newer vehicles? |
| **Q12** | How does order quantity affect delivery performance, delivery time, and delivery delays? |
| **Q13** | How does shipping cost relate to delivery performance and late-delivery risk? |
| **Q14** | How does order value relate to delivery performance and delivery delays? |
| **Q15** | Does payment method have a relationship with delivery performance, delivery time, and shipping cost? |
| **Q16** | How do route distance and shipping priority interact, and does the relationship affect late-delivery performance? |
| **Q17** | Does vehicle utilization relate to delivery performance and late-delivery risk? |
| **Q18** | How does delivery reliability vary across routes, and which routes show different late-delivery patterns? |
| **Q19** | Does customer activity level and previous delay history relate to current delivery performance? |
| **Q20** | How does the combination of traffic, weather, and shipping priority affect delivery risk? |

### EDA Feature Engineering

Several analytical bands were created to make continuous variables easier to compare across operational groups:

- **Distance_Band** — Short, Medium, Long, Very Long Distance
- **Weight_Band** — Light, Medium, Heavy, Very Heavy
- **Volume_Band** — Small, Medium, Large, Very Large
- **Warehouse_Processing_Band** — Low, Medium, High, Very High
- **Handling_Time_Band** — Low, Medium, High, Very High
- **Loading_Time_Band** — Low, Medium, High, Very High
- **Shipping_Cost_Band** — Low, Medium, High, Very High Cost
- **Order_Value_Band** — Low, Medium, High, Very High Value
- **Utilization_Band** — Low, Medium, High, Very High Utilization
- **Customer_Segment** — Low, Medium, High, Very High Activity

### EDA Analysis Areas

The 20 questions cover:

- Delivery performance by shipping priority and delivery mode
- Distance and package-size effects
- Traffic and weather risk
- Customer delay history and activity
- Carrier performance
- Warehouse processing efficiency
- Handling and loading efficiency
- Vehicle age and utilization
- Route-level reliability
- Shipping cost and order value
- Payment-method patterns
- Interaction effects between operational factors

The visual analysis uses bar charts, line charts, boxplots, scatter plots with trendlines, and heatmaps to identify patterns and relationships in the shipment data.


# 5.5 Classification Modeling Data Preparation

The predictive objective was to classify shipments according to their late-delivery status.

### Target

```text
Late_Delivery
```

### Target Definition

```text
1 → Late
0 → Not Late
```

The modeling preparation included:

1. Defining the modeling population.
2. Separating features and target.
3. Performing the train-test split.
4. Reviewing/treating outliers.
5. Handling missing values.
6. Encoding categorical variables.
7. Scaling features where required.
8. Performing feature selection.
9. Handling class imbalance on the training data.
10. Training and evaluating classification models.

### Target Leakage Prevention

A key modeling decision was to exclude variables that become known only after delivery.

In particular:

```text
ActualDeliveryDays
DeliveryTimeHours
```

were treated as leakage variables for predictive modeling because they describe the outcome after the shipment has already been delivered.

They remain useful for descriptive and historical BI analysis, but should not be used as predictors when the goal is to identify late-delivery risk before the outcome is known.

---

# 5.6 Model Building & Comparison

Multiple classification algorithms were evaluated during the modeling process:

- Logistic Regression
- Random Forest
- XGBoost
- Support Vector Machine (SVM)
- K-Nearest Neighbors (KNN)
- Gradient Boosting

The primary comparison shown in the final model-comparison output uses **Class 1 Precision, Class 1 Recall and Class 1 F1-score**.

Because the business objective is specifically to identify late deliveries, Class 1 performance is particularly relevant.

---

# 5.7 Model Selection — Gradient Boosting

**Gradient Boosting was selected as the final model based on the test-set results.**

The final comparison was:

| Model | Test Precision | Test Recall | Test F1 |
|---|---:|---:|---:|
| Logistic Regression | 0.317341 | 0.734954 | 0.443281 |
| Random Forest | 0.639576 | 0.209491 | 0.315606 |
| XGBoost | 0.426230 | 0.481481 | 0.452174 |
| KNN | 0.181725 | 0.409722 | 0.251778 |
| **Gradient Boosting** | **0.335236** | **0.747685** | **0.462917** |

### Why Gradient Boosting was selected

Gradient Boosting achieved the **highest test F1-score among the models in the documented comparison**:

```text
Test F1 = 0.462917
```

It also achieved the highest test recall in the comparison:

```text
Test Recall = 0.747685
```

This means the model provided the strongest balance between Class 1 precision and recall among the displayed candidate models.

### Important Model-Behavior Observation

The comparison also highlights differences in generalization:

- Random Forest achieved perfect training scores but substantially lower test recall and F1.
- XGBoost achieved very high training performance but a much lower test F1.
- KNN showed a large train/test performance gap.
- Logistic Regression generalized more consistently than some tree-based models but had a lower test F1 than Gradient Boosting.
- Gradient Boosting provided the strongest test F1 among the displayed models.

This comparison demonstrates why **test-set performance and generalization** are more useful for model selection than training performance alone.

---

# 5.8 Hyperparameter Tuning — GridSearchCV

After selecting Gradient Boosting, `GridSearchCV` was used to tune the model.

The tuning process explored combinations of:

```python
{
    "n_estimators": [100, 200],
    "learning_rate": [0.05, 0.1],
    "max_depth": [2, 3, 4]
}
```

Four-fold cross-validation was used during the documented GridSearchCV experiment.

Example implementation:

```python
from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import GradientBoostingClassifier

param_gb = {
    "n_estimators": [100, 200],
    "learning_rate": [0.05, 0.1],
    "max_depth": [2, 3, 4]
}

gb = GridSearchCV(
    GradientBoostingClassifier(random_state=42),
    param_gb,
    cv=4,
    verbose=True
)

gb.fit(train_x, train_y)

final_model = gb.best_estimator_
```

The tuned estimator was then used as the final Gradient Boosting model.

---

# 5.9 Model Saving — Pickle

The final trained model was serialized using Python's pickle functionality.

Conceptually:

```python
import pickle

with open("gradient_boosting_model.pkl", "wb") as file:
    pickle.dump(final_model, file)
```

This creates a reusable trained-model artifact that can later be loaded for prediction without retraining the model from scratch.

---

# 5.10 Power BI — Data Transformation & New Columns

The final stage of the project focused on business intelligence reporting.

Power Query was used to prepare the data for Power BI by performing transformations and creating analytical fields required by the dashboard.

The dashboard analyzes dimensions such as:

- Year
- Product Category
- Service Level
- Customer Tier
- Carrier
- Region
- State
- City
- Route
- Warehouse
- Vehicle Age
- Weather
- Traffic
- Shipping Priority
- Day of Week

---

# 5.11 Power BI — Data Modeling

The Power BI model was built around the logistics fact and dimension structure.

Conceptually:

```text
Dim_Dates
Dim_Customers
Dim_Products
Dim_Routes
Dim_Warehouses
Dim_Employees
Dim_Vehicles
Dim_Carriers
        │
        ▼
Fact_Shipments
        ▲
        │
Dim_Locations
```

The underlying database documentation describes the relational structure as a Snowflake schema, with `Dim_Locations` shared by multiple dimensions.

---

# 5.12 Power BI — DAX Measures & KPIs

DAX was used to create the business metrics used throughout the dashboard.

Key metrics include:

```text
Total Shipments
On-Time Delivery %
Late Delivery %
Total Late Deliveries
Average Delivery Time
Average Delay
Average Shipping Cost
Average Shipment Distance
Average Order Value
Average Order Quantity
Total Customers
Total Order Value
Total Orders
Total Order Quantity
Old Fleet Late-Delivery %
```

These measures allow the dashboard to move beyond raw tables and provide business-level performance indicators.

---

# 5.13 Power BI — Dashboard Design

The Power BI report contains **four report pages**.

## Page 1 — Executive Overview

Purpose:

> Provide management with a high-level view of overall logistics performance.

Key KPIs and visuals include:

- Total shipments
- On-time delivery %
- Average delivery time
- Average shipping cost
- Shipment volume vs. late-delivery trend
- Delivery-status distribution
- Top carriers by shipment volume
- Late-delivery rate by region

The page uses button-style filters for:

```text
Year
Product Category
Service Level
```

---

## Page 2 — Logistics Performance

Purpose:

> Analyze the efficiency of the logistics network.

Key analysis includes:

- Delivery performance by carrier
- Shipment volume by region
- Shipment volume by transport mode
- Average delivery time by route
- Average shipment distance
- Late-delivery rate
- Average order value
- Average order quantity

---

## Page 3 — Customer & Product Analysis

Purpose:

> Analyze customers, customer tiers, products and order trends.

Key KPIs and visuals include:

- Total customers
- Total order value
- Total orders
- Total order quantity
- Order volume by product category
- Late-delivery rate by product category
- Top sub-categories by volume
- Monthly product-category trends
- Customer-tier analysis

---

## Page 4 — Delay Analysis

Purpose:

> Identify operational factors associated with late deliveries.

Key analysis includes:

- Total late deliveries
- Late-delivery rate
- Average delay
- Old-fleet late-delivery rate
- Late delivery by carrier
- Late delivery by weather
- Late delivery by operational factors
- Late delivery by warehouse
- Vehicle age vs. late-delivery rate
- Late delivery by day of week

---

# 6. Key Analytical Insights

The Power BI dashboard provides several clear findings from the dataset.

## 6.1 Overall Delivery Performance

The dataset contains approximately **22.1K shipments**.

The dashboard reports:

```text
On-Time Delivery Rate = 85.3%
Late Delivery Rate    = 14.7%
Total Late Deliveries = 3,254
```

This establishes late delivery as a meaningful operational metric for the business.

---

## 6.2 Delivery Performance by Carrier

The Delay Analysis page shows substantial differences in late-delivery rates across carriers.

The displayed carrier rates are:

| Carrier | Late Delivery Rate |
|---|---:|
| Skyline Transport | 26.1% |
| National Carriers | 24.1% |
| Swift Cargo | 22.6% |
| Rapid Roadways | 20.3% |
| FastTrack Logistics | 11.6% |

The variation indicates that carrier-level performance is an important dimension for operational monitoring.

---

## 6.3 Weather Has a Strong Association with Delay Rate

The dashboard shows the following late-delivery rates by weather condition:

| Weather Condition | Late Delivery Rate |
|---|---:|
| Storm | 31.7% |
| Fog | 18.8% |
| Rain | 17.9% |
| Clear | 11.3% |
| Extreme Heat | 11.0% |

Storm conditions have the highest displayed late-delivery rate among the weather categories.

This supports the use of weather as an operational risk factor in both diagnostic analysis and future predictive-risk workflows.

---

## 6.4 Older Vehicles Show Higher Late-Delivery Rates

The dashboard compares vehicle-age groups:

| Vehicle Age | Late Delivery Rate |
|---|---:|
| > 7 Years | 19.2% |
| 2–7 Years | 11.9% |
| < 3 Years | 9.5% |

The oldest vehicle group has the highest displayed late-delivery rate.

This suggests that fleet age is a useful dimension for investigating operational delivery risk.

---

## 6.5 Product Categories Have Different Late-Delivery Rates

The Customer & Product Analysis page shows:

| Product Category | Late Delivery Rate |
|---|---:|
| Pharma | 16.7% |
| Industrial | 15.5% |
| Furniture | 15.2% |
| Electronics | 14.6% |
| Apparel | 14.1% |
| Grocery | 13.9% |

The displayed rates vary across categories, with **Pharma** showing the highest late-delivery rate and **Grocery** the lowest among the six categories shown.

---

## 6.6 Delay Risk Varies by Day of Week

The dashboard shows late-delivery rates by day:

| Day | Late Delivery Rate |
|---|---:|
| Monday | 14.3% |
| Tuesday | 14.2% |
| Wednesday | 15.0% |
| Thursday | 15.1% |
| Friday | 14.7% |
| Saturday | 14.0% |
| Sunday | 15.7% |

Sunday has the highest displayed late-delivery rate, while Saturday has the lowest.

This provides another operational dimension that can be monitored for planning and scheduling.

---

# 7. Technical Challenges Solved

## Challenge 1 — Building a Relational Analytics Database

The source data was provided as multiple Excel files rather than as a ready-to-query relational database.

### Solution

Python and `pyodbc` were used to create `LogisticsAnalyticsDB` and load the 10 source tables into SQL Server, creating a structured analytical environment.

---

## Challenge 2 — Working with a Multi-Table Snowflake Schema

The dataset contains multiple fact and dimension relationships, including a shared location dimension.

### Solution

The relational structure was understood through the data dictionary and ERD documentation before writing the 40 business queries and building the BI model.

---

## Challenge 3 — Preventing Target Leakage

Some shipment variables describe the delivery outcome after it has already happened.

### Solution

`ActualDeliveryDays` and `DeliveryTimeHours` were excluded from the predictive feature set because they would reveal information unavailable at prediction time.

---

## Challenge 4 — Model Selection with Class-Specific Metrics

Different algorithms produced very different train/test behavior.

### Solution

The models were compared using **Class 1 Precision, Recall and F1-score**, with particular attention to the untouched test set.

Gradient Boosting achieved the highest test F1-score among the documented candidate models:

```text
Gradient Boosting Test F1 = 0.462917
```

---

# 8. End-to-End Project Architecture

```text
┌───────────────────────────────┐
│       Kaggle Dataset          │
│  10 Excel Files + Dictionary  │
└───────────────┬───────────────┘
                │
                ▼
┌───────────────────────────────┐
│     Data Understanding        │
│   Schema + Data Dictionary    │
└───────────────┬───────────────┘
                │
                ▼
┌───────────────────────────────┐
│       Python + pyodbc         │
│   Database Creation & Load    │
└───────────────┬───────────────┘
                │
                ▼
┌───────────────────────────────┐
│          SQL Server           │
│      LogisticsAnalyticsDB     │
└───────────────┬───────────────┘
                │
        ┌───────┴────────┐
        │                │
        ▼                ▼
┌──────────────┐  ┌─────────────────┐
│ 40 SQL       │  │ Python / Jupyter │
│ Business     │  │ Data Cleaning    │
│ Questions    │  │ & Preparation    │
└──────────────┘  └────────┬────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │ Classification  │
                   │ Model Building  │
                   └────────┬────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │ Gradient        │
                   │ Boosting        │
                   └────────┬────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │ GridSearchCV    │
                   │ Fine-Tuning     │
                   └────────┬────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │ Pickle Model    │
                   │ .pkl            │
                   └─────────────────┘

SQL Server / Analytical Data
          │
          ▼
┌───────────────────────────────┐
│           Power BI            │
│ Power Query → Model → DAX    │
│ → KPI Cards → Visuals        │
└───────────────┬───────────────┘
                │
                ▼
┌───────────────────────────────┐
│       4-Page Dashboard        │
│                               │
│ 1. Executive Overview         │
│ 2. Logistics Performance      │
│ 3. Customer & Product Analysis│
│ 4. Delay Analysis             │
└───────────────────────────────┘
```

---

# 9. My Contribution

I worked across the complete analytics lifecycle:

- Studied the Kaggle dataset and data dictionary.
- Created the SQL Server database using Python and `pyodbc`.
- Loaded 10 Excel source files into relational tables.
- Solved 40 business problems using SQL Server.
- Performed data cleaning and validation in Python/Jupyter.
- Performed 20 business-focused EDA questions using summary tables and visualizations.
- Created analytical bands and interaction analyses for operational variables.
- Prepared the dataset for binary classification.
- Implemented multiple classification algorithms.
- Compared models using Class 1 precision, recall and F1-score.
- Selected Gradient Boosting using test-set performance.
- Tuned Gradient Boosting with `GridSearchCV`.
- Saved the final model as a `.pkl` file.
- Performed Power Query transformations.
- Built the Power BI data model.
- Created DAX measures and business KPIs.
- Designed a four-page interactive dashboard.
- Analyzed operational factors such as carriers, weather, vehicle age, product category, warehouses and day of week.
- Used AI-assisted tools as supporting resources for technical problem-solving, ideation, design and documentation.

---

# 10. Skills Demonstrated

## SQL & Database

- SQL Server
- Relational Database Design
- Snowflake Schema
- Primary / Foreign Keys
- Joins
- CTEs
- Subqueries
- Correlated Subqueries
- Window Functions
- Ranking
- Running Totals
- Percentiles
- Quartiles
- Cohort Analysis
- Statistical Analysis
- Anomaly Detection

## Python & Data Analytics

- Python
- pandas
- NumPy
- Data Cleaning
- Missing-Value Handling
- Duplicate Handling
- Data-Type Correction
- Outlier Analysis
- Feature Engineering
- Feature Selection
- Jupyter Notebook
- `pyodbc`

## Exploratory Data Analysis

- Business Question Framing
- Univariate & Bivariate Analysis
- Grouped Summary Tables
- Quartile-Based Binning
- Trend Analysis
- Correlation / Relationship Analysis
- Scatter & Regression Analysis
- Heatmaps
- Boxplots
- Operational Risk Analysis

## Machine Learning

- Binary Classification
- Logistic Regression
- Random Forest
- XGBoost
- **SVM**
- **KNN**
- Gradient Boosting
- Train/Test Split
- Encoding
- Scaling
- Class Imbalance Handling
- Model Evaluation
- Cross-Validation
- GridSearchCV
- Target Leakage Prevention
- Model Serialization

## Power BI

- Power Query
- Data Modeling
- Relationships
- DAX
- KPI Development
- Calculated Columns
- Measures
- Slicers
- Interactive Visuals
- Dashboard Design
- Business Storytelling

## Business Analytics

- Logistics Analytics
- Supply Chain Analytics
- Delivery Performance
- Carrier Analysis
- Route Analysis
- Warehouse Analysis
- Customer Analytics
- Product Analytics
- Cost Analysis
- Operational Risk Analysis
- Predictive Analytics

---

# 11. Interview Explanation

> **TransGlobe_Business is an end-to-end logistics analytics project where I combined SQL, Python, machine learning and Power BI.**
>
> I started with 10 Excel files and a data dictionary from a Kaggle dataset. I first understood the data model and then used Python with `pyodbc` to create a SQL Server database and load the source data into a relational structure.
>
> After creating the database, I solved 40 business problems using SQL Server. These covered shipment performance, late deliveries, carriers, customers, warehouses, routes, costs, trends and operational risks.
>
> I then moved to Python and Jupyter for data cleaning and machine-learning preparation. The predictive objective was binary classification of `Late_Delivery`, where 1 represents a late delivery and 0 represents a non-late delivery.
>
> I evaluated Logistic Regression, Random Forest, XGBoost, SVM, KNN and Gradient Boosting. I compared the models using Class 1 precision, recall and F1-score. Gradient Boosting achieved the highest test F1-score among the documented models at **0.462917**, so I selected it as the final modeling approach and then fine-tuned it using GridSearchCV.
>
> The final trained model was saved as a pickle file.
>
> For the BI layer, I built a four-page Power BI dashboard covering Executive Overview, Logistics Performance, Customer & Product Analysis, and Delay Analysis. I used Power Query for transformations, built the data model, created DAX measures and designed interactive KPI-driven visuals.
>
> Overall, the project demonstrates a complete workflow from **raw data → database → SQL analysis → data preparation → predictive modeling → model tuning → business dashboard → operational insights**.

---

# 12. Project Outcome

The project delivers a complete analytics solution with both **descriptive** and **predictive** capabilities.

### Descriptive & Diagnostic Layer

The SQL analysis and Power BI dashboard allow users to:

- Monitor shipment volume.
- Track on-time and late-delivery performance.
- Compare carriers.
- Analyze warehouse and route performance.
- Examine weather and traffic-related delay patterns.
- Analyze customers and products.
- Monitor shipping costs and order values.
- Investigate vehicle-age-related performance.
- Identify operational areas requiring further investigation.

### Predictive Layer

The machine-learning workflow provides a foundation for identifying shipments with a higher probability of late delivery before the delivery outcome is known.

This can support operational activities such as:

- Early identification of potentially high-risk shipments.
- Carrier and route review.
- Additional operational planning.
- Delivery-buffer decisions.
- Proactive customer communication.

### Final Deliverables

```text
TransGlobe_Business/
│
├── data/
│   ├── 10 Excel source files
│   └── Data Dictionary
│
├── sql/
│   └── 40 Business Problem Queries
│
├── eda_and_data_prep/
│   ├── data_cleaning.ipynb
│   ├── exploratory_data_analysis.ipynb
│   └── data_preparation_for_modelling.ipynb
│
├── Classification_model/
│   ├── model_training_evaluation_and_validation.ipynb
│   └── final_model.pkl
│
├── models/
│   └── gradient_boosting_model.pkl
│
├── powerbi/
│   └── TransGlobe Logistics Performance Dashboard
│
├── documentation/
│   ├── Business Problems
│   ├── ERD / Schema Documentation
│   └── Dashboard Documentation
│
└── README.md
```

---

## Project Summary

| Item | Details |
|---|---|
| **Project** | TransGlobe_Business |
| **Domain** | Logistics / Supply Chain / Last-Mile Delivery |
| **Dataset Source** | Kaggle |
| **Source Data** | 10 Excel files + data dictionary |
| **Database** | SQL Server |
| **Database Name** | `LogisticsAnalyticsDB` |
| **SQL Analysis** | 40 Business Problems |
| **Python EDA** | 20 Business Questions |
| **ML Problem** | Binary Classification |
| **Target** | `Late_Delivery` |
| **Models** | Logistic Regression, Random Forest, XGBoost, SVM, KNN, Gradient Boosting |
| **Selected Model** | Gradient Boosting |
| **Best Documented Test F1** | **0.462917** |
| **Grid Search** | GridSearchCV |
| **Model Format** | Pickle (`.pkl`) |
| **BI Tool** | Power BI |
| **Dashboard Pages** | 4 Power BI pages |
| **Status** | Completed Portfolio Project |

---

## Disclaimer

**TransGlobe Logistics Pvt. Ltd. is the business context used for this portfolio project.**

The project is intended to demonstrate practical skills in **SQL, Python, machine learning, Power BI, data modeling, business analysis and analytical storytelling**.
