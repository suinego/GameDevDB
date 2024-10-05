--Процедура для получения информации об играх, выпущенных  компанией
CREATE OR REPLACE PROCEDURE get_games_by_company(company_name VARCHAR)
LANGUAGE SQL
AS $$
BEGIN
    SELECT g.title, g.release_year, c.name AS company_name
    FROM game g
    JOIN company c ON g.company_id = c.company_id
    WHERE c.name = company_name;
END;
$$;
--Процедура для получения информации о версиях игры
CREATE OR REPLACE PROCEDURE get_game_versions(game_title VARCHAR)
LANGUAGE SQL
AS $$
    SELECT g.title, vh.version_number, vh.release_date, vh.notes
    FROM game g
    JOIN version_history vh ON g.game_id = vh.game_id
    WHERE g.title = game_title;
$$;
--Процедура для получения списка вакансий по заданной должности:
CREATE OR REPLACE PROCEDURE get_vacancies_by_position(position_title VARCHAR)
LANGUAGE SQL
AS $$
    SELECT *
    FROM job_vacancy
    WHERE position_title = position_title;
$$;

