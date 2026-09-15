
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

/*   ============================================================================ */

------------------------------------------------------------------------------------------------------------------------
-- Q1. How many total shipments are in the dataset?

select count(*) as total_shipments from 
            (select distinct * from Fact_Shipments) as shipment_table;


------------------------------------------------------------------------------------------------------------------------
-- Q2. What is the overall late-delivery rate across all shipments?

select 
round(cast(sum(is_late)*100.0/count(*) as decimal(10,2)), 2) as late_delivery_percentage
from (
    select 
    case when f.Late_Delivery = 1 then 1 else 0 end as is_late 
    from Fact_Shipments as f) late_table;

------------------------------------------------------------------------------------------------------------------------
-- Q3. How many shipments fall into each ShipmentStatus?

select 
f.ShipmentStatus, count(*) count_of_shipments 
from Fact_Shipments as f
group by f.ShipmentStatus;

------------------------------------------------------------------------------------------------------------------------
-- Q4. What is the average shipping cost across all shipments (nulls excluded)?

select 
round(cast(avg(f.ShippingCost) as decimal(10,2)), 2) as average_shipping_cost 
from Fact_Shipments as f;

------------------------------------------------------------------------------------------------------------------------
-- Q5. What is total order value broken down by shipping priority?

select 
f.ShippingPriority, cast(round(sum(f.OrderValue), 2) as decimal(10,2)) as total_order_value
from Fact_Shipments as f
group by f.ShippingPriority;

------------------------------------------------------------------------------------------------------------------------
-- Q6. How many distinct customers have shipped at least once?

select 
count(distinct f.CustomerID) total_distinct_customers
from Fact_Shipments as f;

------------------------------------------------------------------------------------------------------------------------
-- Q7. How many shipments were made per delivery mode?

select 
f.DeliveryMode, count(*) total_shipments
from Fact_Shipments as f
group by f.DeliveryMode;

------------------------------------------------------------------------------------------------------------------------
-- Q8. How does average promised delivery time compare to average actual delivery time?

select 
cast(avg(f.PromisedDeliveryDays*1.0) as decimal(10,2)) as avg_PromisedDeliveryDays, 
cast(avg(f.ActualDeliveryDays*1.0) as decimal(10,2)) as avg_ActualDeliveryDays,
cast(
    avg(f.PromisedDeliveryDays*1.0) - avg(f.ActualDeliveryDays*1.0) 
    as decimal(10,2)
    ) as days_diff_between_PromisedDeliveryDays_and_ActualDeliveryDays
from Fact_Shipments as f;

------------------------------------------------------------------------------------------------------------------------
-- Q9. How many shipments were made per payment method, most used first?

--shipments were made per payment method
select 
f.PaymentMethod, count(*) as total_shipments
from Fact_Shipments as f
group by f.PaymentMethod
order by total_shipments desc; --most used first

------------------------------------------------------------------------------------------------------------------------
-- Q10. What are the min, max, and average shipment distance, and how many rows have invalid (negative) distance?

select 
cast(min(f.DistanceKm*1.0) as decimal(10,2)) as min_DistanceKm,
cast(max(f.DistanceKm*1.0) as decimal(10,2)) as max_DistanceKm,
cast(avg(f.DistanceKm*1.0) as decimal(10,2)) as avg_DistanceKm,
t.is_invalid_distance
from Fact_Shipments as f
inner join ( -- shipments with negative distance
            select 
            sum(case when f.DistanceKm < 0 then 1 else 0 end) as is_invalid_distance 
            from Fact_Shipments as f) as t
on 1=1
where f.DistanceKm >= 0 -- excluding shipments with negative distances
group by t.is_invalid_distance;

------------------------------------------------------------------------------------------------------------------------
-- Q11. What is the late-delivery rate for each carrier, worst first?

select 
c.CarrierID, c.CarrierName, cast(sum(is_late)/count(c.CarrierID) as  decimal(10,2)) as late_delivery_rate
from (
    select
    f.CarrierID,
    case when f.Late_Delivery = 1 then 1.0 end as is_late
    from Fact_Shipments as f ) as t1
left join Dim_Carriers as c
on c.CarrierID = t1.CarrierID
group by c.CarrierID, c.CarrierName
order by late_delivery_rate desc --worst first

------------------------------------------------------------------------------------------------------------------------
-- Q12. What is the late-delivery rate under each weather condition?

select 
coalesce(f.WeatherCondition, 'Weather condition is not known') as Weather_Condition,
cast(sum(case when f.Late_Delivery = 1 then 1.0 end)/ count(*) as decimal(10, 2)) as late_delivery_rate
from Fact_Shipments as f
group by f.WeatherCondition
order by late_delivery_rate desc

------------------------------------------------------------------------------------------------------------------------
-- Q13. What is the average shipping cost by customer region?

select 
coalesce(l.Region, 'unknown') as Region,
cast(round(avg(f.ShippingCost), 2) as decimal(10,2)) as average_shipping_cost
from Fact_Shipments as f
left join Dim_Customers as c
on c.CustomerID = f.CustomerID
left join Dim_Locations as l
on l.LocationID = c.LocationID
group by coalesce(l.Region, 'unknown')
order by average_shipping_cost desc;

------------------------------------------------------------------------------------------------------------------------
-- Q14. How does late-delivery rate vary across distance buckets (intra-city to long-haul)?

select 
r.RouteType, 
cast(round(sum(case when f.Late_Delivery = 1 then 1.0 else 0 end)/count(*), 2) as decimal(10,2)) as late_delivery_rate
from Fact_Shipments as f
left join Dim_Routes as r
on r.RouteID = f.RouteID
group by r.RouteType;

------------------------------------------------------------------------------------------------------------------------
-- Q15. Which 5 cities generate the highest total order value?

select top 5
l.City, 
cast(round(sum(f.OrderValue), 2) as decimal(10,2)) as total_Order_Value
from Fact_Shipments as f
left join Dim_Customers as c
on c.CustomerID = f.CustomerID
left join Dim_Locations as l
on l.LocationID = c.LocationID
group by l.City
order by total_Order_Value desc;

------------------------------------------------------------------------------------------------------------------------
-- Q16. How does late-delivery rate vary by shipping priority AND carrier type together?

select 
f.ShippingPriority, c.CarrierType,
cast(round(sum(case when f.Late_Delivery = 1 then 1.0 else 0 end)/count(*), 2) as decimal(10,2)) as late_delivery_rate
from Fact_Shipments as f
left join Dim_Carriers as c
on c.CarrierID = f.CarrierID
group by f.ShippingPriority, c.CarrierType
order by f.ShippingPriority, c.CarrierType;

------------------------------------------------------------------------------------------------------------------------
-- Q17. What are average handling and loading times by warehouse type?

select
w.WarehouseType, 
cast(round(avg(f.HandlingTimeHours), 2) as decimal(10,2)) as avg_HandlingTimeHours, 
cast(round(avg(f.LoadingTimeHours), 2) as decimal(10,2)) as avg_LoadingTimeHours
from Fact_Shipments as f
left join Dim_Warehouses as w
on w.WarehouseID = f.WarehouseID
group by w.WarehouseType;

------------------------------------------------------------------------------------------------------------------------
-- Q18. Which customers have placed more than 10 shipments, and what's their average prior-delay count?


-- Using CEILING instead of ROUND: a partial delay (e.g. 0.5 days or more)
-- should still count as a full day's delay, not be rounded down to 0.
-- This avoids understating how late a shipment actually was.
select 
f.CustomerID, count(f.CustomerID),
cast(ceiling(avg(f.NumPreviousDelaysCustomer*1.0)) as decimal(10, 0)) as prior_delay_count
from Fact_Shipments as f
group by f.CustomerID
having count(f.CustomerID) > 10
order by count(f.CustomerID) desc, avg(f.NumPreviousDelaysCustomer*1.0) desc;

------------------------------------------------------------------------------------------------------------------------
-- Q19. After normalizing inconsistent text casing, what is the late rate by traffic condition?

select 
r.AvgTrafficLevel, 
cast(sum(case when f.Late_Delivery = 1 then 1.0 else 0 end)/count(*) as decimal(10,2)) as late_rate
from Fact_Shipments as f
left join Dim_Routes as r
on r.RouteID = f.RouteID
group by r.AvgTrafficLevel
order by late_rate desc;


------------------------------------------------------------------------------------------------------------------------
-- Q20. Do fragile products cost more to ship and run later than non-fragile ones?

with fragile_run_later_table as (
        select 
        case when p.FragileFlag = 1 then 'fragile' else 'not fragile' end as is_fragile,
        cast(round(avg(f.ShippingCost), 2) as decimal(10,2)) as ShippingCost,
        cast(round(sum(case when f.Late_Delivery = 1 then 1.0 else 0 end)/count(*), 2) as decimal(10,2)) as late_rate
        from Fact_Shipments as f
        left join Dim_Products as p
        on f.ProductID = p.ProductID
        group by case when p.FragileFlag = 1 then 'fragile' else 'not fragile' end
),
row_to_col as (
        select 
        max(case when is_fragile = 'not fragile' then ShippingCost else 0 end) as not_fragile_ShippingCost,
        max(case when is_fragile = 'fragile' then ShippingCost else 0 end) as fragile_ShippingCost,
        max(case when is_fragile = 'not fragile' then late_rate else 0 end) as not_fragile_late_rate,
        max(case when is_fragile = 'fragile' then late_rate else 0 end) as fragile_late_rate
        from fragile_run_later_table
)
select 
        case when not_fragile_ShippingCost > fragile_ShippingCost 
            then 'No, fragile products do not cost more to ship' else 
                 'Yes, fragile products do cost more to ship' end as [Do fragile products cost more to ship],
        case when not_fragile_late_rate > fragile_late_rate
            then 'No, fragile products do not run later then non-fragile products' else 
                 'Yes, fragile products do run later then non-fragile products' end as [Do fragile products run later than non-fragile ones]
from row_to_col;

------------------------------------------------------------------------------------------------------------------------
-- Q21. Rank every carrier by late-delivery rate.

-- not including those carriers which have 0 shipments hence using left join instead of right join
with cte as(
            select 
            c.CarrierID,
            cast(round(sum(case when f.Late_Delivery = 1 then 1.0 else 0 end)/count(*), 4) as decimal(10,4)) as is_late_rate
            from Fact_Shipments as f
            left join Dim_Carriers as c
            on c.CarrierID = f.CarrierID
            group by c.CarrierID
)
select 
*, 
row_number() over(order by is_late_rate asc) as rn
from cte;

------------------------------------------------------------------------------------------------------------------------
-- Q22. What was each customer's most recent shipment?

with cte as (
            select 
            f.CustomerID, f.ShipmentID, 
             --we need to convert DateKey from int to date -- int cannot be converted to date so changed to str, cast can also be used
            convert(date, cast(f.DateKey as char(8)), 112) as dt
            from Fact_Shipments as f
), rn_table as (
            select 
            *, row_number() over(partition by CustomerID order by dt desc) as rn
            from cte
)
select 
CustomerID, ShipmentID, dt
from rn_table
where rn = 1;

------------------------------------------------------------------------------------------------------------------------
-- Q23. How does daily shipment volume change day-over-day?

with cte as (
            select 
            convert(date, cast(f.DateKey as char(8)), 112) as dt, count(*) as cnt
            from Fact_Shipments as f
            group by convert(date, cast(f.DateKey as char(8)), 112)
)
select 
dt as [date], 
cnt - lag(cnt) over(order by dt) as [change over previous shipment day]
from cte;

------------------------------------------------------------------------------------------------------------------------
-- Q24. Split shipments into shipping-cost quartiles — does late rate rise with cost?

with cte as (
            select 
            f.ShippingCost,
            PERCENTILE_cont(0.25) within group (order by f.ShippingCost) over() as q1,
            PERCENTILE_cont(0.50) within group (order by f.ShippingCost) over() as q2,
            PERCENTILE_cont(0.75) within group (order by f.ShippingCost) over() as q3,
            case when f.Late_Delivery = 1 then 1.0 else 0 end as is_late
            from Fact_Shipments as f
            where f.ShippingCost is not null
)
select 
case when ShippingCost >= q3 then 'q4' when ShippingCost >= q2 then 'q3' when ShippingCost >= q1 then 'q2' else 'q1' end as quantile,
avg(is_late) as avg_late_rate
from cte
group by case when ShippingCost >= q3 then 'q4' when ShippingCost >= q2 then 'q3' when ShippingCost >= q1 then 'q2' else 'q1' end
order by quantile asc;
--As the ShippingCost increases, the avg_late_rate also increases

------------------------------------------------------------------------------------------------------------------------
-- Q25. What is the cumulative running total of order value over time?

with cte as (
            select 
            convert(date, cast(f.DateKey as char(8)), 112) as dt,
            f.OrderValue
            from Fact_Shipments as f
),cte_2 as (
            select
            dt as [date], sum(OrderValue) as sm
            from cte
            group by dt)
select 
[date], sm as daily_total, sum(sm) over(order by [date] rows between unbounded preceding and current row) as running_total
from cte_2;

------------------------------------------------------------------------------------------------------------------------
-- Q26. How is the month-over-month late-delivery rate trending?

with cte as (
            select 
            format(convert(date, cast(f.DateKey as char(8)), 112), 'yyyy-MM') as dt,
            case when f.Late_Delivery = 1 then 1.0 else 0 end as cw
            from Fact_Shipments as f
)
select 
dt, cast(round(sum(cw)/count(*), 4) as decimal(10,4)) as late_delivery_rate 
from cte
group by dt
order by dt;

------------------------------------------------------------------------------------------------------------------------
-- Q27. For each route, which carrier handles the most shipments?

with cte as (
            select 
            f.RouteID, f.CarrierID, count(f.ShipmentID) as cnt_of_shipments
            from Fact_Shipments as f
            group by f.RouteID, f.CarrierID
), cte_2 as (
            select 
            *, DENSE_RANK() over(partition by RouteID order by cnt_of_shipments desc) as rn
            from cte
)
select 
RouteID, string_agg(CarrierID, ', ') WITHIN GROUP (order by CarrierID) as carriers
from cte_2
where rn = 1
group by RouteID;

------------------------------------------------------------------------------------------------------------------------
-- Q28. Which shipments cost more than their own carrier's average shipping cost?


-- using join correlated subquery

select s.ShipmentID, ShippingCost from Fact_Shipments as s
inner join (
            select 
            f.CarrierID, cast(avg(f.ShippingCost) as decimal(10,2)) as avg_ShippingCost 
            from Fact_Shipments as f
            where f.ShippingCost is not null
            group by f.CarrierID) as t1
on t1.CarrierID = s.CarrierID and t1.avg_ShippingCost < s.ShippingCost;

-- correlated subquery
select 
f.ShipmentID, ShippingCost
from Fact_Shipments as f
where f.ShippingCost > (select avg(ShippingCost) 
                        from Fact_Shipments as s
                        where f.CarrierID = s.CarrierID)

------------------------------------------------------------------------------------------------------------------------
-- Q29. What percentage of total order value does each product category contribute?

with cte_1 as (
            select 
            p.Category, coalesce(sum(f.OrderValue), 0) tot_order_value
            from Fact_Shipments as f
            right join Dim_Products as p
            on p.ProductID = f.ProductID
            group by p.Category
), cte_2 as (
            select sum(OrderValue) as sm_order_value 
            from Fact_Shipments
)
select 
Category, 
cast(tot_order_value*100.0/sm_order_value as decimal(10,2)) as percentage_of_total_order_value
from cte_1 as c1
inner join cte_2 as c2
on 1=1;

------------------------------------------------------------------------------------------------------------------------
-- Q30. Rank Traffic x Weather combinations by late-delivery risk.

with cte as (
    select 
    concat(coalesce(f.TrafficCondition, 'unknown'), '-' ,coalesce(f.WeatherCondition, 'unknown')) as Traffic_x_Weather,
    sum(case when f.Late_Delivery  =  1 then 1.0 else 0 end)/count(*) as is_late_ratio
    from Fact_Shipments as f
    group by concat(coalesce(f.TrafficCondition, 'unknown'), '-' ,coalesce(f.WeatherCondition, 'unknown'))
)
select 
DENSE_RANK() over(order by is_late_ratio desc) as rn, Traffic_x_Weather, 
cast(round(is_late_ratio, 2) as decimal(10,2)) as is_late_ratio
from cte;

------------------------------------------------------------------------------------------------------------------------
-- Q31. Build a carrier scorecard combining late-rate rank and cost rank into one weighted score.

select 
* 
from Fact_Shipments as f



------------------------------------------------------------------------------------------------------------------------
-- Q32. Cohort analysis: registration-month cohorts vs. their shipment late rate & spend.

------------------------------------------------------------------------------------------------------------------------
-- Q33. Which carriers have a late rate more than 1 standard deviation above the network average?

------------------------------------------------------------------------------------------------------------------------
-- Q34. Which routes' late rate worsened by more than 5 points quarter-over-quarter?

------------------------------------------------------------------------------------------------------------------------
-- Q35. For each warehouse, who is the most time-efficient employee (min. 30 shipments handled)?

------------------------------------------------------------------------------------------------------------------------
-- Q36. Build a Traffic x Weather late-rate matrix (weather conditions pivoted into columns).

------------------------------------------------------------------------------------------------------------------------
-- Q37. Flag customers whose latest carrier runs above-average late rates AND whose delay count is rising.

------------------------------------------------------------------------------------------------------------------------
-- Q38. Do above-median-age vehicles run a higher late rate than at/below-median-age vehicles?

------------------------------------------------------------------------------------------------------------------------
-- Q39. Top 5 products per category by revenue, with rank and cumulative % of category revenue.

------------------------------------------------------------------------------------------------------------------------
-- Q40. Flag anomalous shipping costs (z-score > 3) within their own distance-decile peer group.



/*  =========================================================================================================

                                                THE END

    ========================================================================================================= */