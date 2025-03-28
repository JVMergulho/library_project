DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Livro CASCADE CONSTRAINTS;
DROP TABLE LivroInfo CASCADE CONSTRAINTS;
DROP TABLE Permissao CASCADE CONSTRAINTS;
DROP TABLE Autores_Table CASCADE CONSTRAINTS;
DROP TABLE Generos_Table CASCADE CONSTRAINTS;

BEGIN
    FOR t IN (SELECT type_name FROM user_types) LOOP
        EXECUTE IMMEDIATE 'DROP TYPE BODY "' || t.type_name || '"';
        EXECUTE IMMEDIATE 'DROP TYPE "' || t.type_name || '" FORCE';
    END LOOP;
END;
/


CREATE TYPE PermissaoType AS OBJECT (
    TipoUsuario CHAR(1),
    RestricaoUsuario CHAR(1)
);
/

CREATE TABLE Permissao OF PermissaoType (
    CONSTRAINT permissao_pk PRIMARY KEY (TipoUsuario, RestricaoUsuario),
    CONSTRAINT permissao_chk_tipo CHECK (TipoUsuario IN ('I', 'A', 'P')),
    CONSTRAINT permissao_chk_restricao CHECK (RestricaoUsuario IN ('L', 'A', 'R'))
);

-- Criando um tipo de objeto para autores
CREATE TYPE AutorType AS OBJECT (
    ID INTEGER,
    Nome VARCHAR2(50)
);
/

-- Criando um tipo de coleção para armazenar múltiplos autores
CREATE TYPE Autor_nt AS TABLE OF AutorType;
/

-- Criando um tipo de objeto para gêneros
CREATE TYPE GeneroType AS OBJECT (
    ID INTEGER,
    Nome VARCHAR2(50)
);
/

-- Criando um tipo de coleção para armazenar múltiplos gêneros
CREATE TYPE Genero_nt AS TABLE OF GeneroType;
/

-- Criando o tipo do Livro, agora incluindo nested tables para autores e gêneros
CREATE TYPE LivroInfoType AS OBJECT (
    ISBN VARCHAR2(13),
    Titulo VARCHAR2(100),
    Editora VARCHAR2(50),
    AnoPublicacao INTEGER,
    Secao REF SecaoType,
    RestricaoUsuario CHAR(1),
    Autores Autor_nt, 
    Generos Genero_nt
);
/

-- Criando a tabela do Livro
CREATE TABLE LivroInfo OF LivroInfoType (
    CONSTRAINT livroinfo_pk PRIMARY KEY (ISBN),
    CONSTRAINT livroinfo_chk_restricao CHECK (RestricaoUsuario IN ('L', 'A', 'R')),
    Secao WITH ROWID REFERENCES Secao
)
NESTED TABLE Autores STORE AS Autores_Table,
NESTED TABLE Generos STORE AS Generos_Table;

-- Tipo e tabela do livro
CREATE TYPE LivroType AS OBJECT (
    CodigoTombamento INTEGER,
    Preco DECIMAL(10, 2),
    Funcionario REF FuncionarioType,
    LivroInfo REF LivroInfoType,
    Secao REF SecaoType
);
/

CREATE TABLE Livro OF LivroType (
    CONSTRAINT livro_pk PRIMARY KEY (CodigoTombamento),
    LivroInfo WITH ROWID REFERENCES LivroInfo,
    Funcionario SCOPE IS Funcionario
);

COMMIT;