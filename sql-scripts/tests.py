import pytest
import psycopg2
from psycopg2.extras import RealDictCursor

DATABASE_URL = "postgresql://user:password@localhost/gamedevpr"

@pytest.fixture(scope='module')
def db_connection():
    conn = psycopg2.connect(DATABASE_URL)
    yield conn
    conn.close()

@pytest.fixture(scope='module')
def db_cursor(db_connection):
    cursor = db_connection.cursor(cursor_factory=RealDictCursor)
    yield cursor
    cursor.close()

def test_treecompanies(db_cursor):
    db_cursor.execute("""
        SELECT name, founding_year
        FROM Company
        ORDER BY founding_year
        LIMIT 3;
    """)
    result = db_cursor.fetchall()
    assert len(result) == 3
    assert result[0]['name'] is not None
    assert result[0]['founding_year'] is not None

def test_gamesposle2000(db_cursor):
    db_cursor.execute("""
        SELECT COUNT(g.game_id) AS game_count
        FROM Game g
        JOIN Company c ON g.company_id = c.company_id
        WHERE c.founding_year > 2000;
    """)
    result = db_cursor.fetchone()
    assert result['game_count'] >= 0

def test_realesed_data(db_cursor):
    db_cursor.execute("""
        SELECT g.title, vh.version_number, vh.release_date, vh.notes
        FROM Game g
        JOIN Version_History vh ON g.game_id = vh.game_id
        ORDER BY vh.release_date;
    """)
    result = db_cursor.fetchall()
    assert len(result) > 0
    assert result[0]['title'] is not None
    assert result[0]['release_date'] is not None

def test_vacancies(db_cursor):
    db_cursor.execute("""
        SELECT COUNT(vacancy_id) AS total_vacancies
        FROM Job_Vacancy;
    """)
    result = db_cursor.fetchone()
    assert result['total_vacancies'] >= 0

def test_gameplatforms(db_cursor):
    db_cursor.execute("""
        SELECT g.title, gp.platform_name
        FROM Game g
        JOIN GamePlatform gp ON g.game_id = gp.game_id;
    """)
    result = db_cursor.fetchall()
    assert len(result) > 0
    assert result[0]['title'] is not None
    assert result[0]['platform_name'] is not None

def test_fivevacancy(db_cursor):
    db_cursor.execute("""
        SELECT c.name, COUNT(jv.vacancy_id) AS vacancy_count
        FROM Company c
        LEFT JOIN Job_Vacancy jv ON c.company_id = jv.company_id
        GROUP BY c.name
        HAVING COUNT(jv.vacancy_id) < 5;
    """)
    result = db_cursor.fetchall()
    assert len(result) > 0
    for row in result:
        assert row['vacancy_count'] < 5

def test_highestsalary(db_cursor):
    db_cursor.execute("""
        SELECT c.name, AVG(jv.salary) AS avg_salary
        FROM Company c
        JOIN Job_Vacancy jv ON c.company_id = jv.company_id
        GROUP BY c.name
        ORDER BY avg_salary DESC
        LIMIT 1;
    """)
    result = db_cursor.fetchone()
    assert result['name'] is not None
    assert result['avg_salary'] > 0

def test_salary(db_cursor):
    db_cursor.execute("""
        SELECT position_title, AVG(salary) AS avg_salary
        FROM Job_Vacancy
        GROUP BY position_title;
    """)
    result = db_cursor.fetchall()
    assert len(result) > 0
    for row in result:
        assert row['position_title'] is not None
        assert row['avg_salary'] > 0

def test_gamesincompany(db_cursor):
    db_cursor.execute("""
        SELECT c.name, COUNT(g.game_id) AS game_count
        FROM Company c
        JOIN Game g ON c.company_id = g.company_id
        GROUP BY c.name;
    """)
    result = db_cursor.fetchall()
    assert len(result) > 0
    for row in result:
        assert row['name'] is not None
        assert row['game_count'] >= 0

def test_gamesafter2010(db_cursor):
    db_cursor.execute("""
        SELECT title, release_year
        FROM Game
        WHERE release_year > 2010
        ORDER BY release_year;
    """)
    result = db_cursor.fetchall()
    assert len(result) > 0
    for row in result:
        assert row['title'] is not None
        assert row['release_year'] > 2010

