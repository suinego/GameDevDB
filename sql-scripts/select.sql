--1 Выбрать название компании и год ее основания для первых трех компаний, отсортировать по году основания.
SELECT name, founding_year
FROM Company
ORDER BY founding_year
LIMIT 3;
--2 Подсчитать количество игр основанными после 2000 года.
SELECT COUNT(g.game_id) AS game_count
FROM Game g
JOIN Company c ON g.company_id = c.company_id
WHERE c.founding_year > 2000;
--3 Отсортировать по дате релиза
SELECT g.title, vh.version_number, vh.release_date, vh.notes
FROM Game g
JOIN Version_History vh ON g.game_id = vh.game_id
ORDER BY vh.release_date;
--4 Подсчитать общее количество вакансий в таблице Job_Vacancy.
SELECT COUNT(vacancy_id) AS total_vacancies
FROM Job_Vacancy;
--5 Выбрать название игры и название платформы, на которой она доступна.
SELECT g.title, gp.platform_name
FROM Game g
JOIN GamePlatform gp ON g.game_id = gp.game_id;
--6 Компании имеющее менее 5 вакансий
SELECT c.name, COUNT(jv.vacancy_id) AS vacancy_count
FROM Company c
LEFT JOIN Job_Vacancy jv ON c.company_id = jv.company_id
GROUP BY c.name
HAVING COUNT(jv.vacancy_id) < 5;
--7 Компании с наивысшими средними зп по вакансиям
SELECT c.name, AVG(jv.salary) AS avg_salary
FROM Company c
JOIN Job_Vacancy jv ON c.company_id = jv.company_id
GROUP BY c.name
ORDER BY avg_salary DESC
LIMIT 1;
--8 Выбрать должность и средний уровень зарплаты для каждой должности.
SELECT position_title, AVG(salary) AS avg_salary
FROM Job_Vacancy
GROUP BY position_title;
--9 Количество игр, выпущенных каждой компанией
SELECT c.name, COUNT(g.game_id) AS game_count
FROM Company c
JOIN Game g ON c.company_id = g.company_id
GROUP BY c.name;
--10 Отсортировать по году выпуска игры выпущеные после 2010
SELECT title, release_year
FROM Game
WHERE release_year > 2010
ORDER BY release_year;

