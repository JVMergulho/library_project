DROP TABLE Telefone CASCADE CONSTRAINTS;
DROP TABLE Leitor CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;
DROP TABLE Secao CASCADE CONSTRAINTS;
DROP TABLE Pessoa CASCADE CONSTRAINTS;
DROP TABLE Logradouro CASCADE CONSTRAINTS;

DROP SEQUENCE seq_id_secao;
DROP SEQUENCE seq_cadastro_funcionario;

-- CRIAÇÃO DE TABELAS PARA CADASTRO DE PESSOAS

BEGIN
    FOR t IN (SELECT type_name FROM user_types) LOOP
        EXECUTE IMMEDIATE 'DROP TYPE BODY "' || t.type_name || '"';
        EXECUTE IMMEDIATE 'DROP TYPE "' || t.type_name || '" FORCE';
    END LOOP;
END;
/

CREATE OR REPLACE TYPE EnderecoType AS OBJECT (
    Logradouro VARCHAR2(50),
    Numero NUMBER,
    CEP NUMBER,

    CONSTRUCTOR FUNCTION EnderecoType(SELF IN OUT EnderecoType, Logradouro VARCHAR2, Numero NUMBER, CEP NUMBER) RETURN SELF AS RESULT
) NOT INSTANTIABLE;
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
    DataNascimento NUMBER,
    CPF NUMBER,
    Nome VARCHAR2(50),

    CONSTRUCTOR FUNCTION PessoaType(SELF IN OUT PessoaType, Telefones TelefonesType, DataNascimento NUMBER, CPF NUMBER, Nome VARCHAR2) RETURN SELF AS RESULT,

    MEMBER FUNCTION desconto RETURN NUMBER
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY PessoaType AS
    CONSTRUCTOR FUNCTION PessoaType(SELF IN OUT PessoaType, Telefones TelefonesType, DataNascimento NUMBER, CPF NUMBER, Nome VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Telefones := Telefones;
        SELF.DataNascimento := DataNascimento;
        SELF.CPF := CPF;
        SELF.Nome := Nome;
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

    CONSTRUCTOR FUNCTION LeitorType(SELF IN OUT LeitorType, Email VARCHAR2, TipoLeitor CHAR, Senha VARCHAR2) RETURN SELF AS RESULT,

    OVERRIDING MEMBER FUNCTION desconto RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY LeitorType AS
    CONSTRUCTOR FUNCTION LeitorType(SELF IN OUT LeitorType, Email VARCHAR2, TipoLeitor CHAR, Senha VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Email := Email;
        SELF.TipoLeitor := TipoLeitor;
        SELF.Senha := Senha;
        RETURN;
    END;

    OVERRIDING MEMBER FUNCTION desconto RETURN NUMBER IS
    BEGIN
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
    Secao REF SecaoType,

    CONSTRUCTOR FUNCTION FuncionarioType(SELF IN OUT FuncionarioType, Email VARCHAR2, CodigoFuncionario INTEGER, Cargo VARCHAR2, Senha VARCHAR2) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY FuncionarioType AS
    CONSTRUCTOR FUNCTION FuncionarioType(SELF IN OUT FuncionarioType, Email VARCHAR2, CodigoFuncionario INTEGER, Cargo VARCHAR2, Senha VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Email := Email;
        SELF.CodigoFuncionario := CodigoFuncionario;
        SELF.Cargo := Cargo;
        SELF.Senha := Senha;
        RETURN;
    END;
END;
/

CREATE TABLE Funcionario OF FuncionarioType (
    CONSTRAINT funcionario_pk PRIMARY KEY (CPF)
);

ALTER TYPE FuncionarioType
ADD ATTRIBUTE (supervisor REF FuncionarioType) CASCADE;
/