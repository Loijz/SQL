-- Exploration Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
-- checking from all companies, that had a 100% laidoff, which once were the biggest. 

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- checking from all companies, that had a 100% laidoff, which once had the most money raised. 

SELECT industry, COUNT(*) AS industry_count
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY industry
ORDER BY industry_count DESC;
-- checking which industries are affected most by 100% laidoffs  - Retail and Food

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
-- checking industry total layoffs - Consumer and Retail

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
-- sum of all layoff overall time. ORDER BY 2 is ordering by 2. column SUM(total_laid_off), Amazon, Google, Meta, Salesforce, Microsoft are top Laydown companies

SELECT country, SUM(total_laid_off), COUNT(*)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
-- US has the most laidoffs, but this might be biased from a overpopulation of US companies in this table. 

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;
-- checking the data range of the dataset

SELECT YEAR(`date`), SUM(total_laid_off), COUNT(*)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1;

SELECT stage, SUM(total_laid_off), COUNT(*)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
-- does not help very much

SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY 1
ORDER BY 1 ASC
;


-- checking monthly laidoffs with a rolling total. laidoffs started to rampage up from oct 2022.
WITH rolling_total AS 
(
SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY 1
ORDER BY 1 ASC
)
SELECT `Month`, total_off, SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
FROM rolling_total;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
;

-- checking top 6 companies laid offs per year
WITH company_year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS 
(SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 6
;

