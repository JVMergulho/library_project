-- Inserindo dados na tabela LivroInfo
INSERT ALL
    INTO LivroInfo (ISBN, Titulo, Editora, AnoPublicacao, RestricaoUsuario) VALUES ('9788535902774', 'Dom Casmurro', 'Penguin Companhia', 1899, 'A')
    INTO LivroInfo (ISBN, Titulo, Editora, AnoPublicacao, RestricaoUsuario) VALUES ('9786555320022', 'A Revolução dos Bichos', 'Antofágica', 1945, 'L')
    INTO LivroInfo (ISBN, Titulo, Editora, AnoPublicacao, RestricaoUsuario) VALUES ('9788544002278', '1984', 'Companhia das Letras', 1949, 'A')
    INTO LivroInfo (ISBN, Titulo, Editora, AnoPublicacao, RestricaoUsuario) VALUES ('9788520937011', 'O Pequeno Príncipe', 'Agir', 1943, 'R')
    INTO LivroInfo (ISBN, Titulo, Editora, AnoPublicacao, RestricaoUsuario) VALUES ('9788594318601', 'Admirável Mundo Novo', 'Biblioteca Azul', 1932, 'L')
    INTO LivroInfo (ISBN, Titulo, Editora, AnoPublicacao, RestricaoUsuario) VALUES ('9788551301821', 'Chapeuzinho Amarelo', 'Autêntica', 1970, 'L')
    INTO LivroInfo (ISBN, Titulo, Editora, AnoPublicacao, RestricaoUsuario) VALUES ('9788572326203', 'O Inferno de Dante', 'Editora 34', 1321, 'R')
SELECT * FROM dual;

-- Inserindo dados na tabela Autor
INSERT INTO Autor (ID, Nome) VALUES (seq_id_autor.NEXTVAL, 'Machado de Assis');

INSERT INTO Autor (ID, Nome) VALUES (seq_id_autor.NEXTVAL, 'George Orwell');

INSERT INTO Autor (ID, Nome) VALUES (seq_id_autor.NEXTVAL, 'Antoine de Saint-Exupéry');

INSERT INTO Autor (ID, Nome) VALUES (seq_id_autor.NEXTVAL, 'Aldous Huxley');

INSERT INTO Autor (ID, Nome) VALUES (seq_id_autor.NEXTVAL, 'Chico Buarque');

INSERT INTO Autor (ID, Nome) VALUES (seq_id_autor.NEXTVAL, 'Ziraldo');

INSERT INTO Autor (ID, Nome) VALUES (seq_id_autor.NEXTVAL, 'Dante Alighieri');


-- Inserindo dados na tabela LivroAutor
INSERT ALL
    INTO LivroAutor (ISBN, AutorID) VALUES ('9788535902774', 1)
    INTO LivroAutor (ISBN, AutorID) VALUES ('9786555320022', 2)
    INTO LivroAutor (ISBN, AutorID) VALUES ('9788544002278', 2)
    INTO LivroAutor (ISBN, AutorID) VALUES ('9788520937011', 3)
    INTO LivroAutor (ISBN, AutorID) VALUES ('9788594318601', 4)
    INTO LivroAutor (ISBN, AutorID) VALUES ('9788551301821', 5)
    INTO LivroAutor (ISBN, AutorID) VALUES ('9788551301821', 6)
    INTO LivroAutor (ISBN, AutorID) VALUES ('9788572326203', 7)
SELECT * FROM dual;

-- Inserindo dados na tabela LivroGenero
INSERT ALL
    INTO LivroGenero (ISBN, Genero) VALUES ('9788535902774', 'Romance')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788535902774', 'Ficção Brasileira')
    INTO LivroGenero (ISBN, Genero) VALUES ('9786555320022', 'Fábula')
    INTO LivroGenero (ISBN, Genero) VALUES ('9786555320022', 'Sátira Política')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788544002278', 'Ficção Científica')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788544002278', 'Distopia')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788520937011', 'Infantil')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788520937011', 'Filosofia')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788594318601', 'Distopia')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788594318601', 'Ficção Científica')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788551301821', 'Infantil')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788572326203', 'Poesia')
    INTO LivroGenero (ISBN, Genero) VALUES ('9788572326203', 'Literatura Italiana')
SELECT * FROM dual;

-- Inserindo dados na tabela Livro
INSERT INTO Livro (CodigoTombamento, ISBN, Preco, CPFFuncionario) VALUES (seq_id_livro.NEXTVAL, '9788535902774', 39.90, '12345678901');

INSERT INTO Livro (CodigoTombamento, ISBN, Preco, CPFFuncionario) VALUES (seq_id_livro.NEXTVAL, '9786555320022', 49.90, '12345678901');

INSERT INTO Livro (CodigoTombamento, ISBN, Preco, CPFFuncionario) VALUES (seq_id_livro.NEXTVAL, '9788544002278', 59.90, '98765432100');

INSERT INTO Livro (CodigoTombamento, ISBN, Preco, CPFFuncionario) VALUES (seq_id_livro.NEXTVAL, '9788520937011', 29.90, '56789012345');

INSERT INTO Livro (CodigoTombamento, ISBN, Preco, CPFFuncionario) VALUES (seq_id_livro.NEXTVAL, '9788594318601', 45.00, '56789012345');

INSERT INTO Livro (CodigoTombamento, ISBN, Preco, CPFFuncionario) VALUES (seq_id_livro.NEXTVAL, '9788551301821', 19.90, '56789012345');

INSERT INTO Livro (CodigoTombamento, ISBN, Preco, CPFFuncionario) VALUES (seq_id_livro.NEXTVAL, '9788572326203', 25.00, '12345678901');


INSERT ALL
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('I', 'L')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('A', 'L')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('A', 'A')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('P', 'L')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('P', 'A')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('P', 'R')
SELECT * FROM dual;

COMMIT;
