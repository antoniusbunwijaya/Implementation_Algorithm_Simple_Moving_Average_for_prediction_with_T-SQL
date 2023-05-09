CREATE DATABASE DB_TANTANGAN
USE DB_TANTANGAN
Create Table data(
id_data int IDENTITY(1,1) PRIMARY KEY,
Tanggal date,
angka_aktual int,
)
insert into data values('2020-12-18',67)
insert into data values('2020-12-19',52)
insert into data values('2020-12-20',70)
insert into data values('2020-12-21',55)
insert into data values('2020-12-22',68)
insert into data values('2020-12-23',55)
insert into data values('2020-12-24',57)
insert into data values('2020-12-26',42)
insert into data values('2021-12-27',46)
insert into data values('2021-12-28',48)
insert into data values('2021-12-29',65)
insert into data values('2021-12-30',64)
insert into data values('2022-1-17',56)
insert into data values('2022-2-19',60)
insert into data values('2022-3-20',68)

--test QUery
Select *
from data
order by Tanggal

Select id_data,
avg(angka_aktual) over (order by Tanggal rows between 3 preceding and current row) as prediksi
from data 
order by Tanggal asc

--Print--
DECLARE @id_data int
DECLARE @id_sementara int
DECLARE @tanggal date
DECLARE @angka int
DECLARE @prediksi int
DECLARE @BR AS CHAR(2) = CHAR(13) + CHAR (10)
DECLARE Tantangan CURSOR FOR
SELECT id_data,[id_data]+1 as iddata,tanggal,angka_aktual,avg(angka_aktual) over (order by Tanggal rows between 2 preceding and current row) as prediksi
from data
order by Tanggal 
OPEN Tantangan
	PRINT
		'-----------------------' + 'Data Awal'+'-----------------------'+ @BR+
		'Id Data' +'---------'+ ' Tanggal ' +'---------'+ ' Angka Aktual'
	FETCH NEXT FROM Tantangan INTO @id_data,@id_sementara,@tanggal,@angka,@prediksi
	WHILE @@FETCH_STATUS = 0
		BEGIN	
			PRINT
			 convert(varchar,@id_data) +'      -      ' + convert(varchar,@tanggal)+'    -    '  + convert(varchar,@angka) 
			FETCH NEXT FROM Tantangan INTO @id_data,@id_sementara,@tanggal,@angka,@prediksi
		END
CLOSE Tantangan

OPEN Tantangan
	PRINT
		'------' + 'Data Prediksi'+ '------'+@BR+
		'Id Data' +'---------'+ ' Prediksi ' 
	FETCH NEXT FROM Tantangan INTO @id_data,@id_sementara,@tanggal,@angka,@prediksi
	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @id_sementara >3
			PRINT
			 convert(varchar,@id_sementara) +'      -      ' + convert(varchar,@prediksi)
			
			FETCH NEXT FROM Tantangan INTO @id_data,@id_sementara,@tanggal,@angka,@prediksi
		END
CLOSE Tantangan
DEALLOCATE Tantangan



