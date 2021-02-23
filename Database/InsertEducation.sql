/*
insert into public.educations(name) values
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


SELECT * FROM  educations;
*/

SELECT * FROM "public"."logins";

INSERT INTO public.logins(login,is_company,salt) VALUES
('TestPersone', TRUE, 'password')


;MERGE INTO logins AS t
USING (VALUES
   ('TestPersone', TRUE, 'password')
  , ('TestCompany', TRUE, 'password')
) AS s(login,is_company,salt)
  ON (s.login = t.login)
WHEN MATCHED THEN
  UPDATE SET is_company=s.is_company , salt = s.salt
WHEN NOT MATCHED THEN
  INSERT(login,is_company,salt)
  VALUES(s.login,s.is_company,s.salt)
;





