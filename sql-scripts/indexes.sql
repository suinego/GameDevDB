--Job_Vacancy по столбцу company_id
CREATE INDEX idx_job_vacancy_company_id ON Job_Vacancy(company_id);
--Audience по столбцу game_id
CREATE INDEX idx_audience_game_id ON Audience(game_id);
-- GamePlatform по столбцу game_id
CREATE INDEX idx_game_platform_game_id ON GamePlatform(game_id);
--Version_History по столбцу game_id
CREATE INDEX idx_version_history_game_id ON Version_History(game_id);

