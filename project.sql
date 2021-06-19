DROP TABLE games;
DROP TABLE categories;
DROP TABLE logs;

-- 1
CREATE TABLE categories (
    id NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    name VARCHAR2(30),
    description VARCHAR2(500),
    isActive NUMBER(1,0) DEFAULT 1 NOT NULL
);

CREATE TABLE games (
    id NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    name VARCHAR2(30),
    description VARCHAR2(1000),
    category_id NUMBER NOT NULL,
    isActive NUMBER(1,0) DEFAULT 1 NOT NULL
);


CREATE TABLE logs (
    id NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    operation_name VARCHAR2(20),
    operation_date DATE,
    table_name VARCHAR2(20)
);

ALTER TABLE games ADD FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE;


-- 2
INSERT INTO categories (name, description)
    VALUES ('Kategoria 1', 'Opis kategorii 1');
INSERT INTO categories (name, description)
    VALUES ('Kategoria 2', 'Opis kategorii 2');
INSERT INTO categories (name, description)
    VALUES ('Kategoria 3', 'Opis kategorii 3');

INSERT INTO games (name, description, category_id)
    VALUES ('Gra 1', 'Gra 1 z kategorii 1', 1);
INSERT INTO games (name, description, category_id)
    VALUES ('Gra 2', 'Gra 2 z kategorii 1', 1);
INSERT INTO games (name, description, category_id)
    VALUES ('Gra 3', 'Gra 3 z kategorii 2', 2);
INSERT INTO games (name, description, category_id)
    VALUES ('Gra 4', 'Gra 4 z kategorii 2', 2);
INSERT INTO games (name, description, category_id)
    VALUES ('Gra 5', 'Gra 5 z kategorii 3', 3);
INSERT INTO games (name, description, category_id)
    VALUES ('Gra 6', 'Gra 6 z kategorii 3', 3);


-- 3a
CREATE OR REPLACE PROCEDURE AddCategory(V_Name VARCHAR2, V_Description VARCHAR2)
    IS
    Duplicate_Name EXCEPTION;
    PRAGMA EXCEPTION_INIT (Duplicate_Name, -2001);
BEGIN
    IF  IsCategoryNameDuplicated(V_Name) = 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Zduplikowana nazwa kategorii');
    END IF;

    INSERT INTO categories (name, description)
        VALUES(V_Name, V_Description);

    EXCEPTION
        WHEN Duplicate_Name THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE RemoveCategory(P_Category_Id NUMBER)
IS
BEGIN
    DELETE FROM categories WHERE id = P_Category_Id;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE EditCategoryName(P_Category_Id NUMBER, V_Name VARCHAR2)
IS
BEGIN
    UPDATE categories SET name = V_Name where id = P_Category_Id;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE EditCategoryDescription(P_Category_Id NUMBER, V_Description VARCHAR2)
IS
BEGIN
    UPDATE categories SET description = V_Description where id = P_Category_Id;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE AddGame(V_Name VARCHAR2, V_Description VARCHAR2, V_Category_Id NUMBER)
IS
    Duplicate_Name EXCEPTION;
    PRAGMA EXCEPTION_INIT (Duplicate_Name, -2001);
BEGIN
    IF  IsGameNameDuplicated(V_Name) = 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Zduplikowana nazwa gry');
    END IF;

    INSERT INTO games (name, description, category_id)
        VALUES(V_Name, V_Description, V_Category_Id);

    EXCEPTION
        WHEN Duplicate_Name THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE RemoveGame(P_Game_Id NUMBER)
IS
BEGIN
    DELETE FROM games WHERE id = P_Game_Id;
    COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE EditGameName(P_Game_Id NUMBER, V_Name VARCHAR2)
IS
BEGIN
    UPDATE games SET name = V_Name where id = P_Game_Id;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE EditGameDescription(P_Game_Id NUMBER, V_Description VARCHAR2)
IS
BEGIN
    UPDATE games SET description = V_Description where id = P_Game_Id;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Bledne dane wejsciowe');
            DBMS_OUTPUT.PUT_LINE('Kod bledu ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('Komunikat ' || SQLERRM);
END;


-- 3b
DROP TABLE games_archive;
DROP TABLE categories_archive;

CREATE TABLE categories_archive (
    id NUMBER,
    name VARCHAR2(30),
    description VARCHAR2(500),
    isActive NUMBER(1,0)
);

CREATE TABLE games_archive (
    id NUMBER,
    name VARCHAR2(30),
    description VARCHAR2(1000),
    category_id NUMBER NOT NULL,
    isActive NUMBER(1,0)
);


CREATE OR REPLACE TRIGGER ArchiveCategory
    BEFORE DELETE
    ON categories
    FOR EACH ROW
BEGIN
    INSERT INTO categories_archive (id, name, description, isActive)
    VALUES (:OLD.id, :OLD.name, :OLD.description, :OLD.isActive);
END;

CREATE OR REPLACE TRIGGER ArchiveGame
    BEFORE DELETE
    ON games
    FOR EACH ROW
BEGIN
    INSERT INTO games_archive (id, name, description, category_id, isActive)
    VALUES (:OLD.id, :OLD.name, :OLD.description, :OLD.category_id, :OLD.isActive);
END;

-- 3c
CREATE OR REPLACE TRIGGER LogCategoriesChange
    AFTER INSERT OR UPDATE OR DELETE
    ON categories
    FOR EACH ROW
DECLARE
    V_Source_Action VARCHAR2(20);
BEGIN
    IF INSERTING THEN
        V_Source_Action := 'INSERT';
    ELSIF UPDATING THEN
        V_Source_Action := 'UPDATE';
    ELSIF DELETING THEN
        V_Source_Action := 'DELETE';
    END IF;

    INSERT INTO logs (operation_name, operation_date, table_name)
        VALUES (V_Source_Action, SYSDATE, 'categories');
END;


CREATE OR REPLACE TRIGGER LogGamesChange
    AFTER INSERT OR UPDATE OR DELETE
    ON games
    FOR EACH ROW
DECLARE
    V_Source_Action VARCHAR2(20);
BEGIN
    IF INSERTING THEN
        V_Source_Action := 'INSERT' ;
    ELSIF UPDATING THEN
        V_Source_Action := 'UPDATE';
    ELSIF DELETING THEN
        V_Source_Action := 'DELETE';
    END IF;

    INSERT INTO logs (operation_name, operation_date, table_name)
        VALUES (V_Source_Action, SYSDATE, 'games');
END;


-- 3f
CREATE OR REPLACE FUNCTION IsCategoryNameDuplicated(V_Name VARCHAR2) RETURN NUMERIC
IS
    CountInDB NUMBER;
BEGIN
    SELECT COUNT(name) INTO CountInDB FROM categories WHERE name like V_Name;
        IF CountInDB > 1 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;

CREATE OR REPLACE FUNCTION IsGameNameDuplicated(V_Name VARCHAR2) RETURN NUMERIC
IS
    CountInDB NUMBER;
BEGIN
    SELECT COUNT(name) INTO CountInDB FROM games WHERE name like V_Name;
    IF CountInDB > 1 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;


-- 4
CREATE OR REPLACE VIEW GamesDetailsView (
    GameId,
    GameName,
    GameDescription,
    IsActive,
    CategoryName
)
AS SELECT
    g.id,
    g.name,
    g.description,
    g.isActive,
    c.name
FROM 
    games g INNER JOIN categories c
    ON g.category_id = c.id
WITH READ ONLY;

COMMIT;