USE publications;

/*EJERCICIOS DE FILTRADO */

# 1. Extraer todos los autores que pertenezcan al estado de california. DEbéis quedaros solo con las columnas de nombre y apellido
SELECT au_lname as nombre, au_fname FROM authors
WHERE state = "CA";

# 2. Mejora la query anterior añadiendo aquellos autores que solo pertenezcan a la ciudad de Oakland. En este caso añade también la dirección
SELECT au_lname as nombre, au_fname, address as dirección FROM authors
WHERE state = "CA" and city = "Oakland";

# 3. Seleccionar todos aquellos libros cuyo precio sea menor que 15$ y cuya fecha de publicación sea en octubre
SELECT * FROM titles
WHERE price < 15 and month(pubdate) = 10;

# 4. Obtener los empleados que llevan en la editorial desde julio del 1990
SELECT * FROM employee
WHERE YEAR(hire_date) > 1990 and MONTH(hire_date) > 6;

# 5. Seleccionar todas aquellas editoriales que no estén es USA
SELECT * FROM publishers
WHERE country != "USA";

# 6. Seleccionar aquellos titulos cuyo precio sea menor que 5 o que el royatly sea menor que 15

SELECT * FROM titles
WHERE price < 5 or royalty < 15;


/*EJERCICIOS FUNCIONES DE AGREGACIÓN */

# 1. Obtener la fecha mínima y máxima de publicación en la base de datos.
SELECT MIN(pubdate) AS fecha_minima, MAX(pubdate) AS fecha_maxima 
FROM titles;

# 2. Obtener la cantidad de publicaciones en cada tipo de publicación.
SELECT type, COUNT(title_id) AS cantidad_publicaciones 
FROM titles 
GROUP BY type;

# 3. Obtener el número de tiendas por ciudad. Ordenad los resultados de mayor a menor en función del número de tiendas
SELECT COUNT(stor_id) as num_tiendas, state 
FROM stores
GROUP BY state
ORDER BY num_tiendas DESC;

# 4. Calcula los ingresos de cada título
SELECT title, price, royalty, (price * royalty) / 100 as beneficios 
FROM titles
WHERE price IS NOT NULL;

# 5. Mejora la query anterior. Calular los beneficios por cada tipo de libro que tenemos en la base de datos
SELECT (SUM(price) * SUM(royalty)) / 100 as beneficios, type
FROM titles
WHERE price IS NOT NULL
GROUP BY type;

