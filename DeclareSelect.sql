------------------------------
-- PARA TESTAR!
-- FOR TEST!
------------------------------
DECLARE @BASE VARCHAR(300)
SELECT @BASE = '0.1,0.3,0.001; 0.4,0.6,0.005;0.7,0.9,0.01'
SELECT * FROM dbo.fnDSplit(@BASE, ';', ',')   
------------------------------