/*Covid 19 Data Insights

All data is as of 01/05/2022
Skills used: Data type conversions, Aggregate functions, Joins, Windows Functions
Inspired by #AlextheAnalyst 
*/


-- Checking for the precentage of United States population infected
SELECT Location, date, total_cases, population, (total_cases/population)*100 AS PercentpopulationInfected
FROM `portfolioproject-337418.World_Data_Covid_19.CovidDeaths`
WHERE Location = "United States"
ORDER BY date DESC

-- Showing likelyhood of contracting and dying from Covid in the United States

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM `portfolioproject-337418.World_Data_Covid_19.CovidDeaths`
WHERE Location = "United States"
order by 1,2

-- Showing total Death Count by Continent
SELECT Location, SUM(cast(new_deaths as int)) as TotalDeathCount
FROM `portfolioproject-337418.World_Data_Covid_19.CovidDeaths`
WHERE Continent is null and Location not in ('World', 'European Union', 'International', 'Upper middle income', 'Low income','High income', 'Lower middle income')
GROUP BY Location
ORDER BY TotalDeathCount desc


-- Checking for the precentage of World population infected 
SELECT Location, MAX(total_cases)AS HighestInfectionCount, population, MAX((total_cases/population))*100 AS PercentpopulationInfected
FROM `portfolioproject-337418.World_Data_Covid_19.CovidDeaths`
GROUP BY Location, Population
order by PercentpopulationInfected DESC


-- Looking to find total death percentage of World population
SELECT SUM(new_cases) as Total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/ SUM(New_cases)*100 AS Deathpercentage
FROM `portfolioproject-337418.World_Data_Covid_19.CovidDeaths`
WHERE location is NOT Null
order by 1,2

-- Joining tables to show total vaccinations per country

SELECT dea.continent, dea.location, MAX(cast(vac.new_vaccinations as int)) as TotalVaccinations
FROM `portfolioproject-337418.World_Data_Covid_19.CovidDeaths` dea
JOIN `portfolioproject-337418.World_Data_Covid_19.CovidVaccinations`vac
      ON dea.location = vac.location 
      AND dea.date = vac.date
WHERE dea.location not in ('World', 'European Union', 'International', 'Upper middle income', 'Low income', 'High income', 'Lower middle income')
GROUP BY 1,2
ORDER BY TotalVaccinations DESC


