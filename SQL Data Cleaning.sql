/*
Cleaning Data in SQL Queries
*/


SELECT *
FROM `Accusations_and_convictions_projetc.Accusations_and_convictions`;

-------------------------------------------------------------------------------------------------------------------

-- Change capitalization

UPDATE `Accusations_and_convictions_projetc.Accusations_and_convictions`
SET Titulo_denuncia = INITCAP(Titulo_denuncia),
    delito_imputado = INITCAP(delito_imputado),
    depto_hechos = INITCAP(depto_hechos)
WHERE true;

SELECT Titulo_denuncia, delito_imputado, depto_hechos
FROM `Accusations_and_convictions_projetc.Accusations_and_convictions`;

-------------------------------------------------------------------------------------------------------------------

-- Changing null values

SELECT 
  COUNTIF(edad IS NULL) AS cantidad_edad_null,
  COUNTIF(situaci__n_procesal IS NULL) AS cantidad_situacion_null,
  COUNTIF(depto_hechos IS NULL) AS depto_hechos_null,
  COUNTIF(Titulo_denuncia IS NULL) AS titulo_denuncia_null,
  COUNTIF(delito_imputado IS NULL) AS delito_imputado_null,
  COUNTIF(edad IS NULL) AS edad_null
FROM 
  `Accusations_and_convictions_projetc.Accusations_and_convictions`;




UPDATE 
  `Accusations_and_convictions_projetc.Accusations_and_convictions`
SET 
  situaci__n_procesal = IFNULL(situaci__n_procesal, 'N/A'),
  depto_hechos = IFNULL(depto_hechos, 'N/A'),
  Titulo_denuncia = IFNULL(Titulo_denuncia, 'N/A'),
  delito_imputado  = IFNULL(delito_imputado, 'N/A')
WHERE true;


-------------------------------------------------------------------------------------------------------------------

  
-- Change M to Masculino (Male) and F to Femenino (Female) in the gender column

SELECT 
  sexo, 
  CASE 
    WHEN sexo = 'M' THEN 'Masculino'
    WHEN sexo = 'F' THEN 'Femenino'
    ELSE 'N/A'
  END AS sexo_actualizado
FROM `Accusations_and_convictions_projetc.Accusations_and_convictions`
Order by sexo desc;

UPDATE `Accusations_and_convictions_projetc.Accusations_and_convictions`
SET sexo = CASE
            WHEN sexo = 'M' THEN 'Masculino'
           WHEN sexo = 'F' THEN 'Femenino'
           ELSE 'N/A'
  END
WHERE true;

SELECT Titulo_denuncia, depto_hechos, fecha_hecho, fecha_primera_audi, fecha_resoluci__n, edad, sexo, delito_imputado
FROM `Accusations_and_convictions_projetc.Accusations_and_convictions`
ORDER BY depto_hechos, Titulo_denuncia;

-------------------------------------------------------------------------------------------------------------------


-- add a column with age ranges
SELECT 
  MAX (edad),
  MIN (edad)
FROM `Accusations_and_convictions_projetc.Accusations_and_convictions`;


SELECT 
  edad, 
  CASE 
    WHEN edad < 18 THEN '-18'
    WHEN edad between 18 and 21 THEN '18-21'
    WHEN edad between 22 and 25 THEN '22-25'
    WHEN edad between 26 and 30 THEN '26-30'
    WHEN edad between 31 and 35 THEN '31-35'
    WHEN edad between 36 and 40 THEN '36-40'
    WHEN edad > 40 THEN '41+'    
        ELSE 'N/A'
  END AS rango_edad
FROM `Accusations_and_convictions_projetc.Accusations_and_convictions`
order by rango_edad;



CREATE TABLE `Accusations_and_convictions_projetc.Accusations_and_convictions_with_age_range`
AS SELECT *,
  CASE
    WHEN edad < 18 THEN '-18'
    WHEN edad BETWEEN 18 AND 21 THEN '18-21'
    WHEN edad BETWEEN 22 AND 25 THEN '22-25'
    WHEN edad BETWEEN 26 AND 30 THEN '26-30'
    WHEN edad BETWEEN 31 AND 35 THEN '31-35'
    WHEN edad BETWEEN 36 AND 40 THEN '36-40'
    WHEN edad > 40 THEN '41+'
    ELSE 'N/A'
  END AS rango_edad
FROM `Accusations_and_convictions_projetc.Accusations_and_convictions`;


-- Cheking
select *
from `Accusations_and_convictions_projetc.Accusations_and_convictions_with_age_range`;

