# StartUp_Analysis

## Project Description

The analysis seeks to explore specific questions on data regarding start-up companies.

## Methods Used

1) Data exploration, cleaning, and analysis.

## Results 

### Which are the top 10 industries basis Revenue? 

Top 10 industries basis average revenue per company:

* Media  - $10M
* Retail - $10M
* Security - $10M
* Government Services - $9M
* Environmental Services - $9M
* Logistics & Transportation - $9M
* Engineering - $9M
* Real Estate - $9M
* IT Services - $9M
* Consumer Products & Services - $9M

Top 10 industries basis total revenue:

* IT Services - $1,345M
* Software - $775M
* Health - $774M
* Business Products & Services - $596M
* Advertising & Marketing - $594M
* Government Services - $472M
* Financial Services - $468M
* Retail - $463M
* Construction - $437M
* Consumer Products & Services - $412M

### RL2 Reclaimer

* The RL2 reclaimer does not need maintenance due to the idle capacity not exceeding the allowable threshold within September.
* The RL2 reclaimer's idle capacity peaked at 9.64% and may need maintenance sometime soon.

### SR1 Reclaimer

* The SR1 reclaimer needs maintenance due to idle capacity exceeding the allowable threshold 103 times within September.
* The SR1 reclaimer's idle capacity peaked at 100.00% due to a significant amount of missing date data.
* If missing data is excluded from the calculations because the reclaimer could have been parked or because the exact case for missing date data is currently unknown, the idle capacity only exceeds the allowable threshold 1 time and peaks at 10.34%. 

### SR4A Reclaimer

* The SR4A reclaimer needs maintenance due to idle capacity exceeding the allowable threshold 225 times within September.
* The SR4A reclaimer's idle capacity peaked at 100.00% due to a significant amount of missing date data.
* If missing data is excluded from the calculations because the reclaimer could have been parked or because the exact case for missing date data is currently unknown, the idle capacity only exceeds the allowable threshold 1 time and peaks at 10.31%. 

### SR6 Reclaimer

* The SR6 reclaimer needs maintenance due to idle capacity exceeding the allowable threshold 23 times within September.
* The SR6 reclaimer's idle capacity peaked at 13.04%.

### Dashboard 

![](ReadMe_Images/Dash.png)

## Technologies 

1) MySQL
2) Microsoft Excel

## Directory Files

1) **Coal_Terminal_Maintenance.sql** - Analysis in MySQL.
2) **Coal_Terminal_Maintenance_Dashboard.xlsx** - Dashboard in Microsoft Excel.
3) **Cole_Data** - All project data.
