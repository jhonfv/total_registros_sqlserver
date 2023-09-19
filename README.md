# Total de Registros en SQL Server

Este repositorio provee una forma rápida y eficiente para contar el total de registros de una tabla en SQL Server. Es especialmente útil para bases de datos con millones de registros, donde un `SELECT COUNT(*)` podría ser subóptimo.

## 📋 Descripción

Contar registros en tablas con millones de entradas puede ser un proceso lento si se utilizan métodos convencionales. Sin embargo, SQL Server ofrece vistas del sistema que contienen estadísticas que podemos aprovechar para obtener un recuento aproximado de registros de forma más eficiente.

## 💡 Método Propuesto

Utilizamos una consulta basada en las vistas del sistema `sys.partitions` y `sys.objects`:

```sql
SELECT SUM(p.rows) as TotalRegistros
FROM sys.partitions p 
JOIN sys.objects o ON p.object_id = o.object_id
WHERE o.name = 'NOMBRE_DE_TU_TABLA' AND p.index_id IN (0,1);
```

**Nota:** Recuerda reemplazar `'NOMBRE_DE_TU_TABLA'` por el nombre real de la tabla que quieres consultar.

## 🔍 Explicación de la Consulta

1. **Vistas del Sistema**: 
    - `sys.partitions`: Contiene información sobre las particiones de todas las tablas y vistas con índices.
    - `sys.objects`: Contiene información de los objetos (tablas, vistas, etc.) en la base de datos.

2. **JOIN**:
    - Unimos las vistas anteriores mediante el identificador único `object_id` para correlacionar el nombre de la tabla con su correspondiente partición.

3. **Filtro**:
    - Filtramos por el nombre de la tabla y los índices 0 y 1, que corresponden al índice de montón y al índice clúster primario respectivamente.

## ⚠️ Consideraciones

- Esta consulta proporciona un recuento aproximado basado en estadísticas. Puede no ser 100% preciso si las estadísticas no están actualizadas.
- Es mucho más rápido que un `SELECT COUNT(*)`, especialmente en tablas grandes.

## 🛠️ Uso

1. Abre tu herramienta de administración de SQL Server (como SSMS).
2. Conéctate a tu base de datos.
3. Ejecuta la consulta, no olvides cambiar `'NOMBRE_DE_TU_TABLA'` por el nombre de tu tabla.

