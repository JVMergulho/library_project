DROP TABLE Autores_Table CASCADE CONSTRAINTS;
DROP TABLE Emprestimo CASCADE CONSTRAINTS;
DROP TABLE FUNCIONARIO CASCADE CONSTRAINTS;
DROP TABLE GENEROS_TABLE CASCADE CONSTRAINTS;
DROP TABLE LEITOR CASCADE CONSTRAINTS;
DROP TABLE LIVRO CASCADE CONSTRAINTS;
DROP TABLE LIVROINFO CASCADE CONSTRAINTS;
DROP TABLE MULTA CASCADE CONSTRAINTS;
DROP TABLE PERMISSAO CASCADE CONSTRAINTS;
DROP TABLE RESERVA CASCADE CONSTRAINTS;
DROP TABLE SECAO CASCADE CONSTRAINTS;
DROP TABLE PESSOA CASCADE CONSTRAINTS;

BEGIN
    FOR t IN (SELECT table_name FROM user_tables) LOOP
        BEGIN
            -- Tenta remover a tabela com CASCADE
            EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
        EXCEPTION
            WHEN OTHERS THEN
                -- Imprime um erro caso a exclusão falhe
                DBMS_OUTPUT.PUT_LINE('Erro ao tentar excluir a tabela ' || t.table_name || ': ' || SQLERRM);
        END;
    END LOOP;
END;
/

BEGIN
    FOR t IN (SELECT object_name FROM user_objects WHERE object_type = 'TYPE') LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP TYPE BODY "' || t.object_name || '"';
        EXCEPTION
            WHEN OTHERS THEN NULL; -- Ignora erro se o TYPE BODY não existir
        END;
        
        BEGIN
            EXECUTE IMMEDIATE 'DROP TYPE "' || t.object_name || '" FORCE';
        EXCEPTION
            WHEN OTHERS THEN NULL; -- Ignora erro se o TYPE estiver em uso
        END;
    END LOOP;
END;
/

COMMIT;

CREATE OR REPLACE TYPE EnderecoType AS OBJECT (
    Logradouro VARCHAR2(50),
    Numero NUMBER,
    CEP NUMBER,

    CONSTRUCTOR FUNCTION EnderecoType(SELF IN OUT EnderecoType, Logradouro VARCHAR2, Numero NUMBER, CEP NUMBER) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY EnderecoType AS
    CONSTRUCTOR FUNCTION EnderecoType(SELF IN OUT EnderecoType, Logradouro VARCHAR2, Numero NUMBER, CEP NUMBER) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Logradouro := Logradouro;
        SELF.Numero := Numero;
        SELF.CEP := CEP;
        RETURN;
    END;
END;
/

CREATE TYPE TelefonesType AS VARRAY(5) OF VARCHAR2(20);
/

CREATE OR REPLACE TYPE PessoaType AS OBJECT (
    Telefones TelefonesType,
    DataNascimento DATE,
    CPF NUMBER,
    Nome VARCHAR2(50),
    Endereco EnderecoType,

    CONSTRUCTOR FUNCTION PessoaType(SELF IN OUT PessoaType, Telefones TelefonesType, DataNascimento DATE, CPF NUMBER, Nome VARCHAR2, Endereco EnderecoType) RETURN SELF AS RESULT,

    MEMBER FUNCTION desconto RETURN NUMBER
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY PessoaType AS
    CONSTRUCTOR FUNCTION PessoaType(SELF IN OUT PessoaType, Telefones TelefonesType, DataNascimento DATE, CPF NUMBER, Nome VARCHAR2, Endereco EnderecoType) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Telefones := Telefones;
        SELF.DataNascimento := DataNascimento;
        SELF.CPF := CPF;
        SELF.Nome := Nome;
        SELF.Endereco := Endereco;
        RETURN;
    END;

    MEMBER FUNCTION desconto RETURN NUMBER IS
        dias NUMBER := SYSDATE - DataNascimento;
    BEGIN
        IF dias > 30 AND dias < 365 THEN
            RETURN 0.1;
        ELSIF dias > 365 THEN
            RETURN 0.2;
        END IF;

        RETURN 0;
    END;
END;
/

CREATE TABLE Pessoa OF PessoaType (
    CONSTRAINT pessoa_pk PRIMARY KEY (CPF)
);

CREATE OR REPLACE TYPE LeitorType UNDER PessoaType (
    Email VARCHAR2(320),
    TipoLeitor CHAR(20),
    Senha VARCHAR2(30),

    OVERRIDING MEMBER FUNCTION desconto RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY LeitorType AS
    -- Implementing the overriding member function "desconto"
    OVERRIDING MEMBER FUNCTION desconto RETURN NUMBER IS
    BEGIN
        -- Here you can add custom logic for discount calculation specific to LeitorType
        RETURN 0.3;
    END;
END;
/


CREATE TABLE Leitor OF LeitorType (
    CONSTRAINT leitor_pk PRIMARY KEY (CPF)
);

CREATE OR REPLACE TYPE SecaoType AS OBJECT (
    CodigoSecao INTEGER,
    Nome VARCHAR2(50),

    CONSTRUCTOR FUNCTION SecaoType(SELF IN OUT SecaoType, CodigoSecao INTEGER, Nome VARCHAR2) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY SecaoType AS
    CONSTRUCTOR FUNCTION SecaoType(SELF IN OUT SecaoType, CodigoSecao INTEGER, Nome VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.CodigoSecao := CodigoSecao;
        SELF.Nome := Nome;
        RETURN;
    END;
END;
/

CREATE TABLE Secao OF SecaoType (
    CONSTRAINT secao_pk PRIMARY KEY (CodigoSecao)
);

CREATE OR REPLACE TYPE FuncionarioType UNDER PessoaType (
    Email VARCHAR2(320),
    CodigoFuncionario INTEGER,
    Cargo VARCHAR2(50),
    Senha VARCHAR2(30),
    Secao REF SecaoType

);
/



CREATE TABLE Funcionario OF FuncionarioType (
    CONSTRAINT funcionario_pk PRIMARY KEY (CPF)
);

ALTER TYPE FuncionarioType
ADD ATTRIBUTE (supervisor REF FuncionarioType) CASCADE;
/