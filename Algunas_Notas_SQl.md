# Información adicional de SQL

## El orden de escritura vs el orden de lectura


<table>
<tr>
<th> Orden de escritura </th>
<th> Orden de lectura </th>
</tr>
<tr>
<td>



|  |                 
|---|
| SELECT  |  
| FROM  |  
| WHERE  | 
| GRUOP BY  |  
| HAVING  |   
| ORDER BY  | 
| LIMIT   | 
|  OFFSET |  
|   |  


</td>
<td>

|   | 
|---|
| FROM  |  
|  JOIN |  
| WHERE  | 
| GROUP BY   |  
| HAVING  |   
| SELECT | 
|  DISTINCT  | 
|  ORDER BY |  
|  LIMIT y OFFSET |   


</td>
</tr>
</table>

Este orden es importante para tener en cuenta para los alias de las columnas y cuando podremos usarlos o no. 
