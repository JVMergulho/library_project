CREATE INDEX idx_livroinfo_titulo ON LivroInfo(Titulo);
CREATE INDEX idx_livroinfo_editora ON LivroInfo(Editora);

CREATE INDEX idx_livro_isbn ON Livro(ISBN);
CREATE INDEX idx_livro_funcionario ON Livro(CPFFuncionario);

CREATE INDEX idx_livroautor_isbn ON LivroAutor(ISBN);
CREATE INDEX idx_livroautor_autor ON LivroAutor(AutorID);

CREATE INDEX idx_livrogenero_isbn ON LivroGenero(ISBN);

COMMIT;