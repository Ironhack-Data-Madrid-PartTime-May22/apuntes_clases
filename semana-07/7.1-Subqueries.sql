-- Ejercicios de Subqueries
use northwind;

--  1. Extraer información  de los productos "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.-- 
SELECT product_id, product_name, category_id
FROM products
WHERE category_id IN (SELECT category_id
						FROM categories
						WHERE category_name = "Beverages");

-- 2. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.
SELECT DISTINCT country
 FROM customers
WHERE country NOT IN (SELECT DISTINCT country
                        FROM suppliers);
                        
-- 3.   Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread". Extraed el OrderId y el nombre del cliente
SELECT o.order_id, 
       o.customer_id
FROM orders AS o
WHERE 
(
    SELECT quantity 
    FROM order_details AS od
    WHERE o.order_id = od.order_id AND od.product_id = 6
) > 20;

-- 4. Extraed los 10 productos mas caros 
select * from( 
                select distinct product_name as Ten_Most_Expensive_Products, unit_price 
	from products 
	order by unit_price desc) 
as a limit 10;



-- 5. Selecciona aquellos productos que su precio unitario sea mayor que la media de todos los precios
select product_name, unit_price 
from products p 
where unit_price > (
					select avg(unit_price)
					from order_details od );