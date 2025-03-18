DROP TABLE LivroGenero CASCADE CONSTRAINTS;
DROP TABLE LivroAutor CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Livro CASCADE CONSTRAINTS;
DROP TABLE LivroInfo CASCADE CONSTRAINTS;
DROP TABLE Permissao CASCADE CONSTRAINTS;

DROP SEQUENCE seq_id_livro;
DROP SEQUENCE seq_id_autor;

-- CRIAÇÃO DE TABELAS PARA CADASTRO DE LIVROS

-- sequência para gerar identificadores únicos
CREATE SEQUENCE seq_id_livro
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_autor
    START WITH 1
    INCREMENT BY 1;

-- Tipo e tabela do livro
CREATE TYPE LivroInfoType AS OBJECT (
    ISBN VARCHAR2(13),
    Titulo VARCHAR2(100),
    Editora VARCHAR2(50),
    AnoPublicacao INTEGER,
    SecaoID INTEGER,
    RestricaoUsuario CHAR(1)
);
/

CREATE TABLE LivroInfo OF LivroInfoType (
    CONSTRAINT livroinfo_pk PRIMARY KEY (ISBN),
    CONSTRAINT livroinfo_fk_secao FOREIGN KEY (SecaoID) REFERENCES Secao(ID),
    CONSTRAINT livroinfo_chk_restricao CHECK (RestricaoUsuario IN ('L', 'A', 'R'))
);

-- Tipo e tabela das permissões
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

-- Tipo e tabela do Autor
CREATE TYPE AutorType AS OBJECT (
    ID INTEGER,
    Nome VARCHAR2(50)
);
/

CREATE TABLE Autor OF AutorType (
    CONSTRAINT autor_pk PRIMARY KEY (ID)
);

-- Tipo e tabela LivroAutor
CREATE TYPE LivroAutorType AS OBJECT (
    ISBN VARCHAR2(13),
    AutorID INTEGER
);

CREATE TABLE LivroAutor OF LivroAutorType (
    CONSTRAINT livroautor_pk PRIMARY KEY (ISBN, AutorID),
    CONSTRAINT livroautor_fk_livro FOREIGN KEY (ISBN) REFERENCES LivroInfo(ISBN) ON DELETE CASCADE,
    CONSTRAINT livroautor_fk_autor FOREIGN KEY (AutorID) REFERENCES Autor(ID) ON DELETE CASCADE
);

-- Tipo e tabela LivroGenero
CREATE TYPE LivroGeneroType AS OBJECT (
    ISBN VARCHAR2(13),
    Genero VARCHAR2(50)
);

CREATE TABLE LivroGenero OF LivroGeneroType (
    CONSTRAINT livrogenero_pk PRIMARY KEY (ISBN, Genero),
    CONSTRAINT livrogenero_fk_livro FOREIGN KEY (ISBN) REFERENCES LivroInfo(ISBN) ON DELETE CASCADE
);

COMMIT;