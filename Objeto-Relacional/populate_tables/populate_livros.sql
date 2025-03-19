-- Inserindo permissões
INSERT INTO Permissao VALUES (PermissaoType('I', 'L'));
INSERT INTO Permissao VALUES (PermissaoType('I', 'A'));
INSERT INTO Permissao VALUES (PermissaoType('I', 'R'));
INSERT INTO Permissao VALUES (PermissaoType('A', 'L'));
INSERT INTO Permissao VALUES (PermissaoType('A', 'A'));
INSERT INTO Permissao VALUES (PermissaoType('A', 'R'));
INSERT INTO Permissao VALUES (PermissaoType('P', 'L'));
INSERT INTO Permissao VALUES (PermissaoType('P', 'A'));
INSERT INTO Permissao VALUES (PermissaoType('P', 'R'));

-- Inserindo autores
INSERT INTO Autor VALUES (1, 'Machado de Assis');
INSERT INTO Autor VALUES (2, 'George Orwell');
INSERT INTO Autor VALUES (3, 'Antoine de Saint-Exupéry');
INSERT INTO Autor VALUES (4, 'Aldous Huxley');
INSERT INTO Autor VALUES (5, 'Chico Buarque');
INSERT INTO Autor VALUES (6, 'Ziraldo');
INSERT INTO Autor VALUES (7, 'Dante Alighieri');

-- Inserindo gêneros
INSERT INTO Genero VALUES (1, 'Romance');
INSERT INTO Genero VALUES (2, 'Ficção Brasileira');
INSERT INTO Genero VALUES (3, 'Fábula');
INSERT INTO Genero VALUES (4, 'Sátira Política');
INSERT INTO Genero VALUES (5, 'Ficção Científica');
INSERT INTO Genero VALUES (6, 'Distopia');
INSERT INTO Genero VALUES (7, 'Infantil');
INSERT INTO Genero VALUES (8, 'Filosofia');
INSERT INTO Genero VALUES (9, 'Poesia');
INSERT INTO Genero VALUES (10, 'Literatura Infantil');

-- Inserindo informações de livros
INSERT INTO LivroInfo VALUES (
    '9788535902774', 'Dom Casmurro', 'Penguin Companhia', 1899, 'A', 2,
    Autor_nt(AutorType(1, 'Machado de Assis')),
    Genero_nt(GeneroType(1, 'Romance'), GeneroType(2, 'Ficção Brasileira'))
);

INSERT INTO LivroInfo VALUES (
    '9786555320022', 'A Revolução dos Bichos', 'Companhia das Letras', 1945, 'A', 2,
    Autor_nt(AutorType(2, 'George Orwell')),
    Genero_nt(GeneroType(3, 'Fábula'), GeneroType(4, 'Sátira Política'))
);

INSERT INTO LivroInfo VALUES (
    '9788544002278', '1984', 'Companhia das Letras', 1949, 'A', 2,
    Autor_nt(AutorType(2, 'George Orwell')),
    Genero_nt(GeneroType(5, 'Ficção Científica'), GeneroType(6, 'Distopia'))
);

INSERT INTO LivroInfo VALUES (
    '9788520937011', 'O Pequeno Príncipe', 'Agir', 1943, 'R', 1,
    Autor_nt(AutorType(3, 'Antoine de Saint-Exupéry')),
    Genero_nt(GeneroType(7, 'Infantil'), GeneroType(8, 'Filosofia'))
);

INSERT INTO LivroInfo VALUES (
    '9788594318601', 'Admirável Mundo Novo', 'Biblioteca Azul', 1932, 'L', 2,
    Autor_nt(AutorType(4, 'Aldous Huxley')),
    Genero_nt(GeneroType(6, 'Distopia'), GeneroType(5, 'Ficção Científica'))
);

INSERT INTO LivroInfo VALUES (
    '9788551301821', 'Chapeuzinho Amarelo', 'Autêntica', 1970, 'L', 1,
    Autor_nt(AutorType(5, 'Chico Buarque'), AutorType(6, 'Ziraldo')),
    Genero_nt(GeneroType(7, 'Infantil'), GeneroType(10, 'Literatura Infantil'))
);

-- Inserindo livros no acervo
INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL, 49.90, NULL,
    (SELECT REF(li) FROM LivroInfo li WHERE li.ISBN = '9788535902774'),
    NULL
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL, 39.90, NULL,
    (SELECT REF(li) FROM LivroInfo li WHERE li.ISBN = '9786555320022'),
    NULL
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL, 39.90, NULL,
    (SELECT REF(li) FROM LivroInfo li WHERE li.ISBN = '9788544002278'),
    NULL
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL, 29.90, NULL,
    (SELECT REF(li) FROM LivroInfo li WHERE li.ISBN = '9788520937011'),
    NULL
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL, 59.90, NULL,
    (SELECT REF(li) FROM LivroInfo li WHERE li.ISBN = '9788594318601'),
    NULL
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL, 19.90, NULL,
    (SELECT REF(li) FROM LivroInfo li WHERE li.ISBN = '9788551301821'),
    NULL
);

COMMIT;