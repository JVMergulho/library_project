DROP TABLE LivroGenero CASCADE CONSTRAINTS;
DROP TABLE LivroAutor CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Livro CASCADE CONSTRAINTS;
DROP TABLE LivroInfo CASCADE CONSTRAINTS;
DROP TABLE Permissao CASCADE CONSTRAINTS;

-- CRIAÇÃO DE TABELAS PARA CADASTRO DE LIVROS

-- sequência para gerar identificadores únicos
CREATE SEQUENCE seq_id_livro
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_autor
    START WITH 1
    INCREMENT BY 1;

-- metadados de um livro
-- ISBN é um identificador único para cada edição e variação de um livro publicado comercialmente
-- TipoUsuario: I - Infantil, A - Adulto, P - Pesquisador

-- RestricaoUsuario: L - Livre, A - Adulto (+18), R - Restrito
-- I tem acesso a L
-- A tem acesso a L e A
-- P tem acesso a L, A e R

CREATE TABLE LivroInfo (
    ISBN VARCHAR2(13),
    Titulo VARCHAR2(100),
    Editora VARCHAR2(50),
    AnoPublicacao INTEGER,
    RestricaoUsuario CHAR(1) CHECK (RestricaoUsuario IN ('L', 'A', 'R')),
    CONSTRAINT livroinfo_pk PRIMARY KEY (ISBN)
);

CREATE TABLE Permissao (
    TipoUsuario CHAR(1) CHECK (TipoUsuario IN ('I', 'A', 'P')),
    RestricaoUsuario CHAR(1) CHECK (RestricaoUsuario IN ('L', 'A', 'R')),
    CONSTRAINT permissao_pk PRIMARY KEY (TipoUsuario, RestricaoUsuario)
);

-- unidades de um livro
CREATE TABLE Livro (
    CodigoTombamento INTEGER DEFAULT seq_id_livro.NEXTVAL, -- código de tombamento
    ISBN VARCHAR2(13),
    Preco DECIMAL(10, 2),
    CPFFuncionario VARCHAR2(14),
    CONSTRAINT livro_pk PRIMARY KEY (CodigoTombamento),
    CONSTRAINT livro_fk_info FOREIGN KEY (ISBN) REFERENCES LivroInfo(ISBN),
    CONSTRAINT livro_fk_funcionario FOREIGN KEY (CPFFuncionario) REFERENCES Funcionario(CPF)
);

-- Tabela de autores (apenas para armazenar autores)
CREATE TABLE Autor (
    ID INTEGER,
    Nome VARCHAR2(50),
    CONSTRAINT autor_pk PRIMARY KEY (ID)
);

-- Tabela de relacionamento Livro <-> Autor (N:N)
CREATE TABLE LivroAutor (
    ISBN VARCHAR2(13),
    AutorID INTEGER,
    CONSTRAINT livroautor_pk PRIMARY KEY (ISBN, AutorID),
    CONSTRAINT livroautor_fk_livro FOREIGN KEY (ISBN) REFERENCES LivroInfo(ISBN) ON DELETE CASCADE,
    CONSTRAINT livroautor_fk_autor FOREIGN KEY (AutorID) REFERENCES Autor(ID) ON DELETE CASCADE
);

-- Tabela de relacionamento Livro <-> Genero (N:N)
CREATE TABLE LivroGenero (
    ISBN VARCHAR2(13),
    Genero VARCHAR2(50),
    CONSTRAINT livrogenero_pk PRIMARY KEY (ISBN, Genero),
    CONSTRAINT livrogenero_fk_livro FOREIGN KEY (ISBN) REFERENCES LivroInfo(ISBN) ON DELETE CASCADE
);