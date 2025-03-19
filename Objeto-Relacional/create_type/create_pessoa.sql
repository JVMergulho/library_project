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
    DataNascimento NUMBER,
    CPF NUMBER,
    Nome VARCHAR2(50),

    CONSTRUCTOR FUNCTION PessoaType(SELF IN OUT PessoaType, Telefones TelefonesType, DataNascimento NUMBER, CPF NUMBER, Nome VARCHAR2) RETURN SELF AS RESULT
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
END;
/

CREATE OR REPLACE TYPE LeitorType UNDER PessoaType (
    Email VARCHAR2(320),
    TipoLeitor CHAR(20),
    Senha VARCHAR2(30),

    CONSTRUCTOR FUNCTION LeitorType(SELF IN OUT LeitorType, Email VARCHAR2, TipoLeitor CHAR, Senha VARCHAR2) RETURN SELF AS RESULT
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
END;
/

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

CREATE OR REPLACE TYPE FuncionarioType UNDER FuncionarioPessoa (
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

ALTER TYPE FuncionarioType
ADD ATTRIBUTE (supervisor REF FuncionarioType) CASCADE;
/