SELECT SUM(p.rows) as TotalRegistros
FROM sys.partitions p 
JOIN sys.objects o ON p.object_id = o.object_id
WHERE o.name = 'EventosElectronicos' AND p.index_id IN (0,1);
