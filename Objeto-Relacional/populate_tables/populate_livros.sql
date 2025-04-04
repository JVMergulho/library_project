TRUNCATE TABLE LivroInfo;
TRUNCATE TABLE Livro;
TRUNCATE TABLE Permissao;


CREATE SEQUENCE seq_id_livro START WITH 1 INCREMENT BY 1;

INSERT INTO Permissao VALUES (PermissaoType('I', 'L'));
INSERT INTO Permissao VALUES (PermissaoType('I', 'A'));
INSERT INTO Permissao VALUES (PermissaoType('I', 'R'));
INSERT INTO Permissao VALUES (PermissaoType('A', 'L'));
INSERT INTO Permissao VALUES (PermissaoType('A', 'A'));
INSERT INTO Permissao VALUES (PermissaoType('A', 'R'));
INSERT INTO Permissao VALUES (PermissaoType('P', 'L'));
INSERT INTO Permissao VALUES (PermissaoType('P', 'A'));
INSERT INTO Permissao VALUES (PermissaoType('P', 'R'));

COMMIT;

INSERT INTO LivroInfo VALUES (
    '9788535902774', 
    'Dom Casmurro', 
    'Penguin Companhia', 
    1899, 
    (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 2),  
    'A', 
    Autor_nt(AutorType(1, 'Machado de Assis')),
    Genero_nt(
        GeneroType(1, 'Romance'), 
        GeneroType(2, 'Ficção Brasileira')
    )
);

INSERT INTO LivroInfo VALUES (
    '9786555320022', 
    'A Revolução dos Bichos', 
    'Companhia das Letras', 
    1945, 
    (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 2),
    'A', 
    Autor_nt(AutorType(2, 'George Orwell')),
    Genero_nt(
        GeneroType(3, 'Fábula'), 
        GeneroType(4, 'Sátira Política')
    )
);

INSERT INTO LivroInfo VALUES (
    '9788544002278', 
    '1984', 
    'Companhia das Letras', 
    1949, 
    (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 2),
    'A', 
    Autor_nt(AutorType(2, 'George Orwell')),
    Genero_nt(
        GeneroType(5, 'Ficção Científica'), 
        GeneroType(6, 'Distopia')
    )
);

INSERT INTO LivroInfo VALUES (
    '9788520937011', 
    'O Pequeno Príncipe', 
    'Agir', 
    1943, 
    (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 1),
    'R', 
    Autor_nt(AutorType(3, 'Antoine de Saint-Exupéry')),
    Genero_nt(
        GeneroType(7, 'Infantil'), 
        GeneroType(8, 'Filosofia')
    )
);

INSERT INTO LivroInfo VALUES (
    '9788594318601', 
    'Admirável Mundo Novo', 
    'Biblioteca Azul', 
    1932, 
    (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 2),
    'L', 
    Autor_nt(AutorType(4, 'Aldous Huxley')),
    Genero_nt(
        GeneroType(6, 'Distopia'), 
        GeneroType(5, 'Ficção Científica')
    )
);

INSERT INTO LivroInfo VALUES (
    '9788551301821', 
    'Chapeuzinho Amarelo', 
    'Autêntica', 
    1970, 
    (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 1),
    'L', 
    Autor_nt(
        AutorType(5, 'Chico Buarque'), 
        AutorType(6, 'Ziraldo')
    ),
    Genero_nt(
        GeneroType(7,  'Infantil'), 
        GeneroType(10, 'Literatura Infantil')
    )
);

COMMIT;



INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL,
    49.90,
    (SELECT REF(f) FROM Funcionario f 
      WHERE f.CPF = 12345678901),
    (SELECT REF(li) FROM LivroInfo li 
      WHERE li.ISBN = '9788535902774'),
    (SELECT REF(s) FROM Secao s 
      WHERE s.CodigoSecao = 2)
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL,
    39.90,
    (SELECT REF(f) FROM Funcionario f 
      WHERE f.CPF = 12345678901),
    (SELECT REF(li) FROM LivroInfo li 
      WHERE li.ISBN = '9786555320022'),
    (SELECT REF(s) FROM Secao s 
      WHERE s.CodigoSecao = 2)
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL,
    39.90,
    (SELECT REF(f) FROM Funcionario f 
      WHERE f.CPF = 98765432100),
    (SELECT REF(li) FROM LivroInfo li 
      WHERE li.ISBN = '9788544002278'),
    (SELECT REF(s) FROM Secao s 
      WHERE s.CodigoSecao = 2)
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL,
    29.90,
    (SELECT REF(f) FROM Funcionario f 
      WHERE f.CPF = 56789012345),
    (SELECT REF(li) FROM LivroInfo li 
      WHERE li.ISBN = '9788520937011'),
    (SELECT REF(s) FROM Secao s 
      WHERE s.CodigoSecao = 1)
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL,
    59.90,
    (SELECT REF(f) FROM Funcionario f 
      WHERE f.CPF = 56789012345),
    (SELECT REF(li) FROM LivroInfo li 
      WHERE li.ISBN = '9788594318601'),
    (SELECT REF(s) FROM Secao s 
      WHERE s.CodigoSecao = 2)
);

INSERT INTO Livro VALUES (
    seq_id_livro.NEXTVAL,
    19.90,
    (SELECT REF(f) FROM Funcionario f 
      WHERE f.CPF = 56789012345),
    (SELECT REF(li) FROM LivroInfo li 
      WHERE li.ISBN = '9788551301821'),
    (SELECT REF(s) FROM Secao s 
      WHERE s.CodigoSecao = 1)
);

COMMIT;
