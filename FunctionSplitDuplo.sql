------------------------------
-- Adaptado por José Diz / Belo Horizonte, MG - Brasil 
-- De: http://jingyangli.wordpress.com/2012/10/18/split-string-with-multiple-delimiters-t-sql-xml-method/
------------------------------
-- https://social.technet.microsoft.com/Forums/sqlserver/pt-BR/509b02af-2674-4132-bb24-03949c92721f/no-ms-sql-funcao-duplo-split?forum=transactsqlpt
------------------------------
-- SPLIT DUPLO!
-- DOUBLE SPLIT!
------------------------------
CREATE FUNCTION dbo.fnDSplit (
    @frase varchar(300),
    @delimitador1 char(1),
    @delimitador2 char(1)
) 
returns @result TABLE (Range_Inicial varchar(30), Range_Final varchar(30), Porcentagem varchar(30)) as
begin
declare @myXML XML;
set @myXML= N'<H><r>' + Replace(@frase, @delimitador1, '</r><r>') + '</r></H>';

with cte as (
SELECT Cast(N'<H><r>' + Replace(Replace(Vals.id.value('.', 'NVARCHAR(50)'),@delimitador2,'|'), '|', '</r><r>') + '</r></H>' as XML) as val
  from @myXML.nodes('/H/r') as Vals(id) 
)
INSERT into @result 
  SELECT distinct S.a.value('(/H/r)[1]', 'NVARCHAR(50)') as C1,
         S.a.value('(/H/r)[2]', 'NVARCHAR(50)') as C2,
         S.a.value('(/H/r)[3]', 'NVARCHAR(50)') as C3
    from cte 
         cross apply val.nodes('/H/r') S(a);
return;         
end;
go