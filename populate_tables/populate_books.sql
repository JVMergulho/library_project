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
INSERT ALL
    INTO Autor (Nome) VALUES ('Machado de Assis')
    INTO Autor (Nome) VALUES ('George Orwell')
    INTO Autor (Nome) VALUES ('Antoine de Saint-Exupéry')
    INTO Autor (Nome) VALUES ('Aldous Huxley')
    INTO Autor (Nome) VALUES ('Chico Buarque')
    INTO Autor (Nome) VALUES ('Ziraldo')
    INTO Autor (Nome) VALUES ('Dante Alighieri')
SELECT * FROM dual;

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
INSERT ALL
    INTO Livro (ISBN, Preco, CPFFuncionario) VALUES ('9788535902774', 39.90, '12345678901')
    INTO Livro (ISBN, Preco, CPFFuncionario) VALUES ('9786555320022', 49.90, '12345678901')
    INTO Livro (ISBN, Preco, CPFFuncionario) VALUES ('9788544002278', 59.90, '98765432100')
    INTO Livro (ISBN, Preco, CPFFuncionario) VALUES ('9788520937011', 29.90, '56789012345')
    INTO Livro (ISBN, Preco, CPFFuncionario) VALUES ('9788594318601', 45.00, '56789012345')
    INTO Livro (ISBN, Preco, CPFFuncionario) VALUES ('9788551301821', 19.90, '56789012345')
    INTO Livro (ISBN, Preco, CPFFuncionario) VALUES ('9788572326203', 25.00, '12345678901')
SELECT * FROM dual;

INSERT ALL
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('I', 'L')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('A', 'L')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('A', 'A')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('P', 'L')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('P', 'A')
    INTO Permissao (TipoUsuario, RestricaoUsuario) VALUES ('P', 'R')
SELECT * FROM dual;

COMMIT;
