/*
insert into educations(name) values
 ('Не указано')
,('Среднее')
,('Средне специальное')
,('Неоконченное высшее')
,('Высшее')
,('Бакалавр')
,('Магистр')
,('Кандидат наук')
,('Доктор наук')
;
*/

MERGE INTO logins AS t
USING (VALUES
   ('TestPersone', 0, 'password')
  , ('TestCompany', 1, 'password')
) AS s([login], [is_Companies], [salt])
  ON (s.login = t.login)
WHEN MATCHED THEN
  UPDATE SET is_Companies=s.[is_Companies] ,[salt] = cast(s.[salt] as varbinary(256))
WHEN NOT MATCHED THEN 
  INSERT(login,is_Companies,[salt]) 
  VALUES (s.login,s.[is_Companies],cast(s.[salt] as varbinary(256)))
;

select * from logins AS t

/*
insert into dbo.Companies([login], [name], [full_name])
VALUES('TestCompany', 'Test', 'Full test')

insert into dbo.Person([login], [first_name], [last_name], [sur_name], [education_ID], [home_address])
VALUES('TestPersone', 'A', 'B', 'C', 1, 'На деревне у дедушки')


insert into dbo.Vacancies([login], [job_title], [Wage], [education_ID], [job_expr])
values('TestCompany', 'junitor', 3000, 1, 3)
*/

--delete from dbo.Logins where login = 'TestCompany'
/*
select * from dbo.Logins
select * from dbo.Vacancies
select * from dbo.Companies

GO

insert into dbo.Appliance([login], [desired_job], [Wage], [job_status])
VALUES
  ('TestPersone', 'Хочу работать', 3000, 0)
, ('TestPersone', 'Хочу не работать', 5000, 1)


insert into [dbo].[PlaceJobs]([login], [company_name], [job_title], [start_date]) values
  ('TestPersone', 'Рога и копыта', 'фермер', '20010101')
, ('TestPersone', 'Дом', 'житель', '20010101')
[dbo].[Person]

insert into dbo.CrossJobs([login], [appliance_id], [place_job_id])
select p.login, a.id, p.id
from [dbo].[PlaceJobs] as p
inner join dbo.Appliance as a
  on a.login = p.login
  and (
    ([company_name] = 'Дом' and a.desired_job = 'Хочу работать')
    or
    ([company_name] != 'Дом' and a.desired_job != 'Хочу работать')
  )

*/

select * from [dbo].[Logins]
select * from [dbo].[Person]
select * from [dbo].[PlaceJobs]
select * from dbo.Appliance
select * from [dbo].[CrossJobs]





select * from dbo.CrossJobs

delete from [dbo].[PlaceJobs] where id = 0

delete from dbo.Appliance where id = 1

delete from dbo.Logins where LOGin = 'TestPersone'