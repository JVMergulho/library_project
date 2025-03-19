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

CREATE OR REPLACE TYPE tp_endereco AS OBJECT (
    Logradouro VARCHAR2(50),
    Numero NUMBER,
    CEP NUMBER,

    CONSTRUCTOR FUNCTION tp_endereco(SELF IN OUT tp_endereco, Logradouro VARCHAR2, Numero NUMBER, CEP NUMBER) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY tp_endereco AS
    CONSTRUCTOR FUNCTION tp_endereco(SELF IN OUT tp_endereco, Logradouro VARCHAR2, Numero NUMBER, CEP NUMBER) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Logradouro := Logradouro;
        SELF.Numero := Numero;
        SELF.CEP := CEP;
        RETURN;
    END;
END;
/

CREATE TYPE tp_telefones AS VARRAY(5) OF VARCHAR2(20);
/

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    Telefones tp_telefones,
    DataNascimento NUMBER,
    CPF NUMBER,
    Nome VARCHAR2(50),

    CONSTRUCTOR FUNCTION tp_pessoa(SELF IN OUT tp_pessoa, Telefones tp_telefones, DataNascimento NUMBER, CPF NUMBER, Nome VARCHAR2) RETURN SELF AS RESULT
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY tp_pessoa AS
    CONSTRUCTOR FUNCTION tp_pessoa(SELF IN OUT tp_pessoa, Telefones tp_telefones, DataNascimento NUMBER, CPF NUMBER, Nome VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Telefones := Telefones;
        SELF.DataNascimento := DataNascimento;
        SELF.CPF := CPF;
        SELF.Nome := Nome;
        RETURN;
    END;
END;
/

CREATE OR REPLACE TYPE tp_leitor UNDER tp_pessoa (
    Email VARCHAR2(320),
    TipoLeitor CHAR(20),
    Senha VARCHAR2(30),

    CONSTRUCTOR FUNCTION tp_leitor(SELF IN OUT tp_leitor, Email VARCHAR2, TipoLeitor CHAR, Senha VARCHAR2) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY tp_leitor AS
    CONSTRUCTOR FUNCTION tp_leitor(SELF IN OUT tp_leitor, Email VARCHAR2, TipoLeitor CHAR, Senha VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Email := Email;
        SELF.TipoLeitor := TipoLeitor;
        SELF.Senha := Senha;
        RETURN;
    END;
END;
/

CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa (
    Email VARCHAR2(320),
    CodigoFuncionario INTEGER,
    Cargo VARCHAR2(50),
    Senha VARCHAR2(30),

    CONSTRUCTOR FUNCTION tp_funcionario(SELF IN OUT tp_funcionario, Email VARCHAR2, CodigoFuncionario INTEGER, Cargo VARCHAR2, Senha VARCHAR2) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY tp_funcionario AS
    CONSTRUCTOR FUNCTION tp_funcionario(SELF IN OUT tp_funcionario, Email VARCHAR2, CodigoFuncionario INTEGER, Cargo VARCHAR2, Senha VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.Email := Email;
        SELF.CodigoFuncionario := CodigoFuncionario;
        SELF.Cargo := Cargo;
        SELF.Senha := Senha;
        RETURN;
    END;
END;
/

ALTER TYPE tp_funcionario
ADD ATTRIBUTE (supervisor REF tp_funcionario) CASCADE;