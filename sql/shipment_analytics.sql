
/* ============================================================================
   
   SHIPMENT ANALYTICS — BUSINESS SQL ANALYSIS

   ----------------------------------------------------------------------------
   Schema: Star schema — Fact_Shipments + Dim_Dates, Dim_Locations,
   Dim_Customers, Dim_Products, Dim_Carriers, Dim_Vehicles, Dim_Warehouses,
   Dim_Employees, Dim_Routes (per Data Dictionary).
   ----------------------------------------------------------------------------

    The following SQL analysis contains a set of 
    **business-driven analytical requirements provided by stakeholders** 
    to evaluate the company's shipment and logistics operations.

    The queries are designed to answer practical business questions around 
    **shipment performance, delivery delays, logistics costs, carrier and vehicle 
    efficiency, warehouse operations, customer behavior, route performance, and operational trends**.

    These requirements simulate a real-world analytics workflow where business 
    teams provide analytical questions and the Data Analytics team uses 
    SQL to extract, analyze, and interpret the required data from the shipment data warehouse.

    **Objective:** 
    Transform business requirements into meaningful SQL-based insights 
    that can support **operational decision-making, performance monitoring, 
    cost optimization, and logistics improvement.**

    ** Queries
    ------------
    -- Q1. How many total shipments are in the dataset?
    -- Q2. What is the overall late-delivery rate across all shipments?
    -- Q3. How many shipments fall into each ShipmentStatus?
    -- Q4. What is the average shipping cost across all shipments (nulls excluded)?
    -- Q5. What is total order value broken down by shipping priority?
    -- Q6. How many distinct customers have shipped at least once?
    -- Q7. How many shipments were made per delivery mode?
    -- Q8. How does average promised delivery time compare to average actual delivery time?
    -- Q9. How many shipments were made per payment method, most used first?
    -- Q10. What are the min, max, and average shipment distance, and how many rows have invalid (negative) distance?
    -- Q11. What is the late-delivery rate for each carrier, worst first?
    -- Q12. What is the late-delivery rate under each weather condition?
    -- Q13. What is the average shipping cost by customer region?
    -- Q14. How does late-delivery rate vary across distance buckets (intra-city to long-haul)?
    -- Q15. Which 5 cities generate the highest total order value?
    -- Q16. How does late-delivery rate vary by shipping priority AND carrier type together?
    -- Q17. What are average handling and loading times by warehouse type?
    -- Q18. Which customers have placed more than 10 shipments, and what's their average prior-delay count?
    -- Q19. After normalizing inconsistent text casing, what is the late rate by traffic condition?
    -- Q20. Do fragile products cost more to ship and run later than non-fragile ones?
    -- Q21. Rank every carrier by late-delivery rate.
    -- Q22. What was each customer's most recent shipment?
    -- Q23. How does daily shipment volume change day-over-day?
    -- Q24. Split shipments into shipping-cost quartiles — does late rate rise with cost?
    -- Q25. What is the cumulative running total of order value over time?
    -- Q26. How is the month-over-month late-delivery rate trending?
    -- Q27. For each route, which carrier handles the most shipments?
    -- Q28. Which shipments cost more than their own carrier's average shipping cost? (correlated subquery)
    -- Q29. What percentage of total order value does each product category contribute?
    -- Q30. Rank Traffic x Weather combinations by late-delivery risk.
    -- Q31. Build a carrier scorecard combining late-rate rank and cost rank into one weighted score.
    -- Q32. Cohort analysis: registration-month cohorts vs. their shipment late rate & spend.
    -- Q33. Which carriers have a late rate more than 1 standard deviation above the network average?
    -- Q34. Which routes' late rate worsened by more than 5 points quarter-over-quarter?
    -- Q35. For each warehouse, who is the most time-efficient employee (min. 30 shipments handled)?
    -- Q36. Build a Traffic x Weather late-rate matrix (weather conditions pivoted into columns).
    -- Q37. Flag customers whose latest carrier runs above-average late rates AND whose delay count is rising.
    -- Q38. Do above-median-age vehicles run a higher late rate than at/below-median-age vehicles?
    -- Q39. Top 5 products per category by revenue, with rank and cumulative % of category revenue.
    -- Q40. Flag anomalous shipping costs (z-score > 3) within their own distance-decile peer group.

   ============================================================================ */
 
USE LogisticsAnalyticsDB;
GO

/*   ============================================================================ */


-- Q1. How many total shipments are in the dataset?
select * from 

-- Q2. What is the overall late-delivery rate across all shipments?


-- Q3. How many shipments fall into each ShipmentStatus?


-- Q4. What is the average shipping cost across all shipments (nulls excluded)?


-- Q5. What is total order value broken down by shipping priority?


-- Q6. How many distinct customers have shipped at least once?


-- Q7. How many shipments were made per delivery mode?


-- Q8. How does average promised delivery time compare to average actual delivery time?


-- Q9. How many shipments were made per payment method, most used first?


-- Q10. What are the min, max, and average shipment distance, and how many rows have invalid (negative) distance?


-- Q11. What is the late-delivery rate for each carrier, worst first?


-- Q12. What is the late-delivery rate under each weather condition?


-- Q13. What is the average shipping cost by customer region?


-- Q14. How does late-delivery rate vary across distance buckets (intra-city to long-haul)?


-- Q15. Which 5 cities generate the highest total order value?


-- Q16. How does late-delivery rate vary by shipping priority AND carrier type together?


-- Q17. What are average handling and loading times by warehouse type?


-- Q18. Which customers have placed more than 10 shipments, and what's their average prior-delay count?


-- Q19. After normalizing inconsistent text casing, what is the late rate by traffic condition?


-- Q20. Do fragile products cost more to ship and run later than non-fragile ones?


-- Q21. Rank every carrier by late-delivery rate.


-- Q22. What was each customer's most recent shipment?


-- Q23. How does daily shipment volume change day-over-day?


-- Q24. Split shipments into shipping-cost quartiles — does late rate rise with cost?


-- Q25. What is the cumulative running total of order value over time?


-- Q26. How is the month-over-month late-delivery rate trending?


-- Q27. For each route, which carrier handles the most shipments?


-- Q28. Which shipments cost more than their own carrier's average shipping cost? (correlated subquery)


-- Q29. What percentage of total order value does each product category contribute?


-- Q30. Rank Traffic x Weather combinations by late-delivery risk.


-- Q31. Build a carrier scorecard combining late-rate rank and cost rank into one weighted score.


-- Q32. Cohort analysis: registration-month cohorts vs. their shipment late rate & spend.


-- Q33. Which carriers have a late rate more than 1 standard deviation above the network average?


-- Q34. Which routes' late rate worsened by more than 5 points quarter-over-quarter?


-- Q35. For each warehouse, who is the most time-efficient employee (min. 30 shipments handled)?


-- Q36. Build a Traffic x Weather late-rate matrix (weather conditions pivoted into columns).


-- Q37. Flag customers whose latest carrier runs above-average late rates AND whose delay count is rising.


-- Q38. Do above-median-age vehicles run a higher late rate than at/below-median-age vehicles?


-- Q39. Top 5 products per category by revenue, with rank and cumulative % of category revenue.


-- Q40. Flag anomalous shipping costs (z-score > 3) within their own distance-decile peer group.


/*  ===========================================================================

                                   THE END

    ============================================================================ */

