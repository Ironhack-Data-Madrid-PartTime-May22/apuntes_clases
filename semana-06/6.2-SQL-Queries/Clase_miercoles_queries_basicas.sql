USE publications;

SELECT * FROM titles;

SELECT title, `type` FROM titles;

SELECT DISTINCT `type` FROM titles;

SELECT DISTINCT `type`, title FROM titles;

SELECT title, `type` FROM titles
ORDER BY title DESC;


SELECT * FROM titles
WHERE price IS NOT NULL
ORDER BY price;

SELECT * FROM titles
WHERE price IS NULL
ORDER BY price;


SELECT `type`, price FROM titles;

# sndklasdnk

/* hola
que tal
*/

-- hola que tal



SELECT `type`, AVG(price) AS precio_medio 
FROM titles
WHERE price IS NOT NULL
GROUP BY `type`;

SELECT `type` 
FROM titles
GROUP BY `type`;

SELECT DISTINCT `type`
FROM titles;

SELECT * FROM titles;

SELECT COUNT(title) AS numero_titulos
FROM titles;

SELECT COUNT(title) AS "numero titulos"
FROM titles;

SELECT MIN(title) FROM titles;

SELECT MAX(title) FROM titles;

SELECT * FROM sales;

SELECT MIN(ord_date) AS fecha_min, MAX(ord_date) AS fecha_max
FROM SALES;

SELECT * FROM sales;


SELECT * FROM sales
WHERE payterms = "Net 60"; 


SELECT MONTH(ord_date) AS mes FROM sales;

SELECT YEAR(ord_date) AS año FROM sales;

SELECT DAY(ord_date) AS dia FROM sales;


-- Calcular la cantidad de libros vendidos en el segundo semestre
SELECT * 
FROM sales
WHERE MONTH(ord_date) >= 7;

SELECT SUM(qty) 
FROM sales
WHERE MONTH(ord_date) >= 7 AND YEAR(ord_date) >= 1994;


SELECT SUM(qty) 
FROM sales
WHERE MONTH(ord_date) >= 7 OR YEAR(ord_date) >= 1994;

SELECT * FROM sales;

-- Sacar el numero de libros vendidos por cada tipo de payterms?

SELECT SUM(qty) as libros_vendidos, payterms
FROM sales
GROUP BY payterms;

# 1. Extraer todos los autores que pertenezcan al estado de california. DEbéis quedaros solo con las columnas de nombre y apellido
SELECT au_lname as apellido, au_fname as nombre FROM authors
WHERE state = "CA";

SELECT CONCAT(au_fname, " ", au_lname) AS autores FROM authors
Where state = "CA";

# 2. Mejora la query anterior añadiendo aquellos autores que solo pertenezcan a la ciudad de Oakland. En este caso añade también la dirección
SELECT * FROM authors;
SELECT CONCAT(au_fname, " ", au_lname) AS autores, address FROM authors
WHERE state = "CA" AND city = "Oakland"
LIMIT 3;

SELECT CONCAT(au_fname, " ", au_lname) AS autores, address FROM authors
WHERE state = "CA" AND city = "Oakland"
LIMIT 3
OFFSET 2;

# 3. Seleccionar todos aquellos libros cuyo precio sea menor que 15$ y cuya fecha de publicación sea en octubre
SELECT * FROM titles;

SELECT price as precio,pubdate as fecha_publicacion FROM titles
WHERE price < 15 and MONTH(pubdate) = 10;

SELECT * FROM titles
WHERE price < 15 and MONTH(pubdate) = 10;

# 4. Obtener los empleados que llevan en la editorial a partir de julio del 1990
SELECT * 
FROM employee
WHERE MONTH(hire_date) >= 7 and YEAR(hire_date) >= 1990
ORDER BY hire_date DESC
LIMIT 5;

# 5. Seleccionar todas aquellas editoriales que no estén es USA
SELECT * FROM publishers
WHERE country != "USA";

SELECT * FROM publishers
WHERE country <> "USA";

# Obtener el numero de titulos por cada tipo de publicación.
SELECT * FROM titles;


SELECT COUNT(title_id) as num_titulos, `type` FROM titles
GROUP BY `type`;

# Obtener el número de tiendas por estado. Ordenad los resultados de mayor a menor en función del número de tiendas
SELECT COUNT(stor_id) as numero_tiendas , state
FROM stores
GROUP BY state
ORDER BY numero_tiendas DESC;

# 4. Calcula los ingresos de cada título
SELECT * FROM titles;

SELECT title as titulo, (price * royalty)/100 as beneficio
FROM titles
WHERE (price * royalty)/100 IS NOT NULL
ORDER BY beneficio;




USE publications;

SELECT * FROM titles;


SELECT title as titulo, price as precio
FROM titles
WHERE price IS NOT NULL;



SELECT title, price, au_id 
FROM titles
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id;



SELECT title, price, titleauthor.au_id, au_fname, au_lname, state
FROM titles 
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id;


SELECT title, price, ta.au_id, au_fname, au_lname, state
FROM titles as t
INNER JOIN titleauthor as ta ON t.title_id = ta.title_id
INNER JOIN authors as a ON ta.au_id = a.au_id;


SELECT state, AVG(price) as precio_medio_libros
FROM titles  t
INNER JOIN titleauthor  ta ON t.title_id = ta.title_id
INNER JOIN authors  a ON ta.au_id = a.au_id
WHERE state = "CA" AND price IS NOT NULL OR state = "UT"
GROUP BY state
ORDER BY precio_medio_libros;


SELECT * 
FROM titles as t
NATURAL JOIN titleauthor;


SELECT * 
FROM titles as t
LEFT JOIN titleauthor as ta ON t.title_id = ta.title_id;

SELECT * 
FROM titles as t
CROSS JOIN titleauthor as ta ON t.title_id = ta.title_id;

-- 1. ¿Cuántos libros/titulos diferentes tiene cada tienda?
SELECT stor_name, COUNT(t.title_id) as total_titulos
FROM stores as st
INNER JOIN sales as sa ON st.stor_id = sa.stor_id 
INNER JOIN titles as t ON t.title_id = sa.title_id
GROUP BY stor_name;



SELECT * 
FROM stores
NATURAL JOIN sales ;

-- 3. ¿Cuantos autores tiene cada libro? Muestra solo los 5 primeros resultados ordenados de mayor a menor en base el número de autores
SELECT title, COUNT(a.au_id) as total_autores
FROM authors AS a
INNER JOIN titleauthor AS ta ON a.au_id = ta.au_id
INNER JOIN titles AS t ON t.title_id = ta.title_id
GROUP BY title
ORDER BY total_autores DESC
LIMIT 5;

-- 4. Beneficio por autor
SELECT concat(au_lname, " ", au_fname) as author, SUM(((price * royalty)/100)* qty) as benefits
FROM  authors as au
INNER JOIN titleauthor as ta on au.au_id = ta.au_id
INNER JOIN titles as t on t.title_id = ta.title_id
INNER JOIN sales as sa on sa.title_id = t.title_id
GROUP BY author
ORDER BY author;

SELECT concat(au_lname, " ", au_fname) as author, (((price * royalty)/100)* qty) as benefits
FROM  authors as au
INNER JOIN titleauthor as ta on au.au_id = ta.au_id
INNER JOIN titles as t on t.title_id = ta.title_id
INNER JOIN sales as sa on sa.title_id = t.title_id
ORDER BY author;

-- ¿Cuantos empleados hay en cada editorial?
SELECT pub_name as editorial, COUNT(emp_id) as total_empleados
FROM publishers as pu
INNER JOIN employee AS em ON em.pub_id = pu.pub_id
GROUP BY editorial
ORDER BY total_empleados DESC;

-- Mejora la query anterior añadiendo la fecha de la ultima persona que se incorporó a cada editorial
SELECT pub_name as editorial, COUNT(emp_id) as total_empleados, MAX(hire_date) as ultima_contratacion
FROM publishers as pu
INNER JOIN employee AS em ON em.pub_id = pu.pub_id
GROUP BY editorial
ORDER BY total_empleados DESC;

-- Cuantos empleados tenemos en cada una de las editoriales? Seleccionad solo aquellas editoriales que tengan mas de 5 empleados

SELECT pub_name as editorial, COUNT(emp_id) as total_empleados
FROM publishers as pu
INNER JOIN employee AS em ON em.pub_id = pu.pub_id 
GROUP BY editorial
HAVING  COUNT(emp_id)  > 5
ORDER BY total_empleados DESC;

-- ¿que tienda vende mas libros en septiembre?
SELECT stor_name as tienda, MAX(qty) as maximo
FROM sales as sl
INNER JOIN stores as st ON  sl.stor_id = st.stor_id
WHERE MONTH(ord_date) = 9
GROUP BY tienda
ORDER BY maximo DESC
LIMIT 1;


















