--Информации о компаниях
CREATE VIEW CompanyInfo AS
SELECT company_id, name, country, founding_year
FROM Company;
--Инфрмация об играх
CREATE VIEW GameInfo AS
SELECT g.game_id, g.title, g.release_year, g.company_id, c.name AS company_name
FROM Game g
JOIN Company c ON g.company_id = c.company_id;
--История версий игр
CREATE VIEW VersionHistoryInfo AS
SELECT vh.version_id, vh.game_id, g.title AS game_title, vh.version_number, vh.release_date, vh.notes, vh.changed_by
FROM Version_History vh
JOIN Game g ON vh.game_id = g.game_id;
--Плаформы
CREATE VIEW GamePlatformInfo AS
SELECT gp.game_id, gp.platform_name
FROM GamePlatform gp;
--Целевая аудитория игр
CREATE VIEW AudienceInfo AS
SELECT a.audience_id, a.game_id, g.title AS game_title, a.audience_description, a.target_age_group, a.target_gender, a.target_interests
FROM Audience a
JOIN Game g ON a.game_id = g.game_id;
--Вакансии в компаниях
CREATE VIEW JobVacancyInfo AS
SELECT j.vacancy_id, j.company_id, c.name AS company_name, j.position_title, j.job_description, j.salary
FROM Job_Vacancy j
JOIN Company c ON j.company_id = c.company_id;

