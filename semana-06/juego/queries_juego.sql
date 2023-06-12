USE northwind;

/*####################### EQUIPO 1 #######################*/


/*1. Numero Pedidos por empresa/cliente en UK. 
 Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que 
 podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK.
  Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.
 */

SELECT customers.company_name AS NombreEmpresa, customers.customer_id AS Identificador, COUNT(orders.order_id) AS NumeroPedidos
FROM customers 
INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK' 
GROUP BY customers.company_name, customers.customer_id;


/* 2. Productos pedidos por empresa en UK por año. 
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido 
pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query que nos sirva para conocer 
cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa,
 el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
*/

SELECT customers.company_name as NombreEmpresa, YEAR(orders.order_date) AS Año, SUM(order_details.quantity) AS NumObjetos
FROM customers  
    INNER JOIN orders ON customers.customer_id = orders.customer_id
    INNER JOIN order_details ON orders.order_id = order_details.order_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name, YEAR(orders.order_date);


/* 3. Mejorad la query anterior. 
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que hemos ganado
por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos 
 salen en porcentajes, 15% nos sale como 0.15.
*/
SELECT C.company_name AS NombreEmpresa, 
        YEAR(O.order_date) AS Año, 
        SUM(OD.quantity) AS NumObjetos, 
        SUM(OD.quantity * OD.unit_price * (1-OD.discount)) AS DineroTotal
FROM customers AS C INNER JOIN orders AS O 
ON C.customer_id = O.customer_id
INNER JOIN order_details AS OD 
ON O.order_id = OD.order_id
WHERE C.country = 'UK'
GROUP BY C.company_name, YEAR(O.order_date)
ORDER BY C.company_name, YEAR(O.order_date);


/*####################### EQUIPO 2 #######################*/

/* 4. Pedidos que han realizado cada compañía y su fecha. 
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, 
desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada
 pedido que han realizado y su fecha.
 */

SELECT orders.order_id, customers.company_name, orders.order_date
FROM customers INNER JOIN orders 
ON customers.customer_id = orders.customer_id;

/* 5. Tipos de producto vendidos. 
Ahora nos piden un informe sobre productos en el que aparezcan sus categorías, nombre de la categoría,
el nombre del producto, y el total de dinero por el que se ha vendido cada producto (teniendo en cuenta los descuentos).
*/
SELECT DISTINCT cat.category_id, cat.category_name, prod.product_name, sum(round(ord_det.unit_price * ord_det.quantity * (1 - ord_det.discount), 2)) as ProductSales
FROM order_details AS ord_det 
INNER JOIN orders AS ord 
ON ord.order_id = ord_det.order_id
INNER JOIN products AS prod 
ON prod.product_id = ord_det.product_id
INNER JOIN categories AS cat 
ON cat.category_id = prod.category_id
GROUP BY cat.category_id, cat.category_name, prod.product_name
ORDER BY cat.category_id, prod.product_name, ProductSales;

/* Cuantos productos le quedan al proveedor después de nuestro ultimo pedido. 
 En este momento los jefes quieren hacer un análisis del último pedido que se hizo a la empresa. 
 Además, están interesados solo en aquellos productos cuyo proveedor está en Francia. 
 Quieren saber cuantas unidades le quedaban en stock al proveedor después del ultimo pedido que no hicieron nuestros clientes
 */
SELECT  company_name, city, product_name, od.unit_price, units_in_stock, quantity, (units_in_stock - quantity), order_date 
from suppliers s 
INNER JOIN products p on p.supplier_id = s.supplier_id 
INNER JOIN order_details od on od.product_id = p.product_id 
INNER JOIN orders o on o.order_id = od.order_id 
WHERE o.order_date = "1998-05-06 00:00:00" and s.country = "France"
order by product_name, company_name;





/*####################### EQUIPO 3 #######################*/

/* Empresas de UK y sus pedidos. 
Nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) 
junto con los ID de todos los pedidos que han realizado y la fecha del pedido.
*/

SELECT orders.order_id, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido 
FROM orders 
RIGHT JOIN customers ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK'. 




/* Vendedores con mas ventas de UK. 
 Los jefes quieren dar una pequeña paga extra a los empleados en función de su rendimiento.
 Para eso nos piden que calculemos el total de ingresos generados para la compañia de cada uno de los empleados. 
 Quieren que nos quedemos con aquellos que han generado más de 100000 $ de ingresos 
 y que lo ordenemos de mayor a menor.  
 */
select o.employee_id ,last_name ,first_name, SUM(od.unit_price * od.quantity) subtotal 
from employees e 
INNER JOIN orders o on e.employee_id = o.employee_id 
INNER JOIN order_details od  on od.order_id  = o.order_id
GROUP BY o.employee_id
HAVING subtotal > 100000
ORDER BY subtotal DESC ;



/* La Categoria mas rapida en llegar. 
 En la empresa estan intentando optimizar el sistema de envío de los pedidos para reducir los tiempos. 
 Para ello nos piden que calculemos el tiempo medio que tarda un envío en ser recibido por los clientes desde que lo piden. 
 En concreto, nos piden que calculemos esto para cada una de las categorías diferentes de productos que tenemos. 
 */

SELECT  AVG(DATEDIFF(required_date,order_date)) as tiempo_medio , c.category_name 
from orders o
INNER JOIN order_details od  on od.order_id  = o.order_id
INNER JOIN products p on od.product_id = p.product_id 
INNER JOIN categories c on p.category_id  = c.category_id
GROUP BY c.category_name
ORDER BY tiempo_medio ;


