USE publications;


-- 1. Mejora la query anterior añadiendo el nombre de la tienda
SELECT COUNT(title_id) as num_titulos_diferentes, stor_id, stor_name 
FROM titles t   
NAtural JOIN sales sl
NATURAL JOIN stores s 
GROUP BY stor_id ;

-- 2. ¿Cuantos autores tiene cada libro? Muestra solo los 5 primeros resultados ordenador de mayor a menor en base el número de autores
SELECT  title, COUNT(au_id) as num_autores
FROM titles as t
INNER JOIN titleauthor t2  ON t.title_id = t2.title_id
GROUP BY title
ORDER BY num_autores DESC
LIMIT 5;



-- 3. Beneficio por autor
SELECT concat(au_lname, " ", au_fname) as author, SUM(((price * royalty)/100)* qty) as benefits
FROM  authors as au
INNER JOIN titleauthor as ta on au.au_id = ta.au_id
INNER JOIN titles as t on t.title_id = ta.title_id
INNER JOIN sales as sa on sa.title_id = t.title_id
GROUP BY author
ORDER BY author;


-- 4. Cuantos empleados tenemos en cada una de las editoriales? Seleccionad solo aquellas editoriales que tengan mas de 5 empleados
SELECT pub_name, COUNT(emp_id) as num_empleados FROM publishers p
NATURAL JOIN employee e 
GROUP BY pub_name
HAVING COUNT(emp_id) > 5
ORDER BY num_empleados DESC;

-- 5. media de ventas por tienda
SELECT stor_name, SUM(qty) as cantidad_media_ventas from stores s
INNER JOIN sales sl 
GROUP BY stor_name;



-- 6. obten un listado de los autores que mas libros venden 


SELECT   CONCAT(au_lname, " ", au_fname) , SUM(qty) as libros_vendidos
FROM sales s
INNER JOIN  titles t ON t.title_id = s.title_id 
INNER JOIN titleauthor t2 ON t2.title_id = t.title_id
NATURAL JOIN authors a 
GROUP BY au_id
ORDER BY libros_vendidos DESC;



-- 7. ¿que tienda vende mas libros en diciembre?
SELECT stor_name , MAX(qty)
FROM stores as s
INNER JOIN sales as sl
WHERE month(ord_date) = 2
GROUP BY stor_name;


-- 8. ¿Cuántos tipo de libros se publican por estado?
SELECT type, COUNT(state) num_estados FROM titles
NATURAL JOIN publishers
WHERE state IS NOT NULL
GROUP BY state, type
ORDER BY num_estados DESC;


-- 9. ¿Cuantos empleados hay en cada editorial?
SELECT pub_name, COUNT(emp_id) as num_empleados from employee as e
INNER JOIN publishers as p ON e.pub_id = p.pub_id
GROUP BY pub_name
ORDER BY num_empleados DESC;


-- 10. Mejora la query anterior añadiendo la fecha de la ultima persona que se incorporo a cada editorial
SELECT pub_name, COUNT(emp_id) as num_empleados, MAX(hire_date) as ultima_incorporacion from employee as e
INNER JOIN publishers as p ON e.pub_id = p.pub_id
GROUP BY pub_name
ORDER BY num_empleados DESC;


-- BONUS: ¿Qué libros tienen un precio superior al de la media general de los libros que tenemos en la BBDD?
SELECT title, price FROM
titles
WHERE price > (SELECT AVG(price)FROM titles);




