USE tutorial1;
SHOW TABLES;

SELECT 
    *
FROM
    utiva
LIMIT 30;
						-- Profit Analysis
                        
#################################################################################################
-- The profit worth of the breweries, inclusive of the anglophone and the francophone territories
#################################################################################################

SELECT 
    SUM(Profit)
FROM
    utiva;

#################################################################################################
-- Total profit generated from the two territories
#################################################################################################

SELECT 
    SUM(Profit) AS total_profit,
    CASE
        WHEN countries = 'Nigeria' THEN 'Anglophone Country'
        WHEN countries = 'Ghana' THEN 'Anglophone Country'
        ELSE 'Francophone Country'
    END AS Territories
FROM
    utiva
GROUP BY territories;

################################################################################################### 
 -- Country with the highest profit in 2019
##################################################################################################
SELECT 
    Countries, SUM(profit)
FROM
    utiva
WHERE
    years = 2019
GROUP BY countries;

#######################################################################################
-- Year with the highest profit
#######################################################################################

SELECT 
    years, SUM(profit)
FROM
    utiva
GROUP BY years;

-- Month with the least profit
SELECT 
    months, SUM(profit)
FROM
    utiva
GROUP BY months;

--  minimum profit in the month of December 2018
SELECT 
    months, MIN(profit)
FROM
    utiva
WHERE
    years = 2018 AND months = 'December';

-- profit in percentage for each of the month in 2019
SELECT 
    months,
    SUM(profit) AS total_profit,
    SUM(profit) * 100 / (SELECT 
            SUM(profit) AS s
        FROM
            utiva
        WHERE
            years = 2019) AS percentage_total
FROM
    utiva
WHERE
    years = 2019
GROUP BY months;

#######################################################
-- Brand that generated the highest profit in senegal
########################################################
SELECT 
    brands, SUM(profit) AS total_profit
FROM
    utiva
WHERE
    countries = 'senegal'
GROUP BY brands
ORDER BY total_profit DESC;

                                         -- Brand Analysis
CREATE OR REPLACE VIEW Territories AS
    SELECT 
        *,
        CASE
            WHEN countries = 'Nigeria' THEN 'Anglophone Country'
            WHEN countries = 'Ghana' THEN 'Anglophone Country'
            ELSE 'Francophone Country'
        END AS Territories
    FROM
        utiva;

SELECT 
    brands, SUM(quantity) AS total_quantity
FROM
    territories
WHERE
    territories = 'francophone country'
        AND years <> 2017
GROUP BY brands
ORDER BY total_quantity DESC;

################################################################
-- top two choice of consumer brands in Ghana
#################################################################
SELECT 
    brands, SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    countries = 'Ghana'
GROUP BY brands
ORDER BY total_quantity DESC
LIMIT 2;

#################################################################################################
-- Total number of beer brands consumed in the oil producing country in west Africa
##################################################################################################
SELECT 
    SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    brands <> 'grand malt'
        AND brands <> 'beta malt'
        AND countries = 'Nigeria';

####################################################################################
-- Total number of malt brands consumed in the oil producing country in west Africa
####################################################################################
SELECT 
    SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    brands LIKE ('%malt')
        AND countries = 'Nigeria';
        
########################################################################################
-- Total number of brands consumed in the oil producing country in west Africa (Nigeria)
########################################################################################
SELECT 
    SUM(quantity)
FROM
    utiva
WHERE
    countries = 'Nigeria';
    
#######################################################################
-- Favorites malt brand in Anglophone region between 2018 and 2019
#######################################################################
SELECT 
    brands, SUM(quantity) AS total_quantity
FROM
    territories
WHERE
    brands LIKE ('%malt') AND years <> 2017
        AND territories = 'anglophone country'
GROUP BY brands
ORDER BY total_quantity DESC
LIMIT 1;

##########################################################
-- Brand that sold the highest in nigeria in 2019
##########################################################
SELECT 
    brands, SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    years = 2019 AND countries = 'Nigeria'
GROUP BY brands
ORDER BY total_quantity DESC
LIMIT 1;

###########################################################
-- Favorites brand in South_South region in Nigeria
##########################################################
SELECT 
    brands, SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    region = 'southsouth'
        AND countries = 'Nigeria'
GROUP BY brands
ORDER BY total_quantity DESC
LIMIT 1;

#####################################################################
-- Level of consumption of Budweiser in the regions in Nigeria
#####################################################################
SELECT 
    region, SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    brands = 'budweiser'
        AND countries = 'Nigeria'
GROUP BY region
ORDER BY total_quantity DESC;

##########################################################################################
-- Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
##########################################################################################
SELECT 
    region, SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    brands = 'budweiser'
        AND countries = 'Nigeria'
        AND years = 2019
GROUP BY region
ORDER BY total_quantity DESC;


								-- Country Analysis

##############################################################################################
-- Country with the highest consumption of beer.
##############################################################################################

SELECT 
    countries, SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    brands <> 'grand malt'
        AND brands <> 'beta malt'
GROUP BY countries
ORDER BY total_quantity DESC;

#################################################################################
-- Highest sales personnel of Budweiser in Senegal
##################################################################################

SELECT 
    sales_rep, SUM(quantity) AS total_quantity
FROM
    utiva
WHERE
    brands = 'budweiser'
        AND countries = 'Senegal'
GROUP BY sales_rep
ORDER BY total_quantity DESC;

########################################################################
-- Country with the highest profit of the fourth quarter in 2019
########################################################################
SELECT countries, max(total_profit)
FROM
(SELECT 
    countries, SUM(profit) AS total_profit
FROM
    utiva
WHERE
    years = '2019'
        AND months IN ('October' , 'November', 'decemeber')
GROUP BY countries
ORDER BY total_profit DESC) as t;