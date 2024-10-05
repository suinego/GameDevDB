--Триггер для автоматической установки даты  создания вакансии:
CREATE OR REPLACE FUNCTION set_creation_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.creation_date := CURRENT_DATE;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_creation_date_trigger
BEFORE INSERT ON job_vacancy
FOR EACH ROW
EXECUTE FUNCTION set_creation_date();

--Триггер для проверки корректности значения заработной платы
CREATE OR REPLACE FUNCTION check_salary()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary < 0 THEN
        RAISE EXCEPTION 'Salary cannot be negative';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_salary_trigger
BEFORE INSERT OR UPDATE ON job_vacancy
FOR EACH ROW
EXECUTE FUNCTION check_salary();

--Триггер для отслеживания изменений вакансий
CREATE OR REPLACE FUNCTION log_vacancy_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO vacancy_changes (vacancy_id, change_type, change_timestamp)
        VALUES (NEW.vacancy_id, 'INSERT', NOW());
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO vacancy_changes (vacancy_id, change_type, change_timestamp)
        VALUES (NEW.vacancy_id, 'UPDATE', NOW());
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO vacancy_changes (vacancy_id, change_type, change_timestamp)
        VALUES (OLD.vacancy_id, 'DELETE', NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_vacancy_changes_trigger
AFTER INSERT OR UPDATE OR DELETE ON job_vacancy
FOR EACH ROW
EXECUTE FUNCTION log_vacancy_changes();

