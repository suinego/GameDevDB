CREATE TABLE  Company(
    company_id INT PRIMARY KEY  NOT NULL,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    founding_year INT
);
CREATE TABLE Game (
    game_id INT PRIMARY KEY,
    title VARCHAR(100),
    release_year INT,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES Company(company_id)
);

CREATE TABLE Version_History (
    version_id SERIAL PRIMARY KEY,
    game_id INT,
    version_number VARCHAR(20),
    release_date DATE,
    notes TEXT,
    changed_by VARCHAR(100),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);
CREATE TABLE GamePlatform (
    game_id INT,
    platform_name VARCHAR(50),
    PRIMARY KEY (game_id, platform_name),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

CREATE TABLE Audience (
    audience_id SERIAL PRIMARY KEY,
    game_id INT NOT NULL,
    audience_description TEXT,
    target_age_group VARCHAR(20),
    target_gender VARCHAR(10),
    target_interests TEXT,
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

CREATE TABLE Job_Vacancy (
    vacancy_id INT PRIMARY KEY,
    company_id INT,
    position_title VARCHAR(100),
    job_description TEXT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (company_id) REFERENCES Company(company_id)
);


