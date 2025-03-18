-- cadastro de pessoas
-- cpf, nome, data de nascimento, cep, rua, número, telefone, é funcionário, cargo, supervisor, seção, é leitor, tipo leitor, email, senha
BEGIN cadastrar_pessoa(
    '111.222.333-44', 'Roberto Lima', TO_DATE('01/01/1990', 'DD/MM/YYYY'),
    '76543210', 'Avenida Verde', '50', '81977776666', 
    FALSE, NULL, NULL, NULL, 
    FALSE, NULL, NULL, NULL
);
END;
/

-- cadastro de funcionário
-- cpf, nome, data de nascimento, cep, rua, número, telefone, é funcionário, cargo, supervisor, seção, é leitor, tipo leitor, email, senha
BEGIN cadastrar_pessoa(
    '111.222.333-44', 'Roberto Lima', TO_DATE('01/01/1990', 'DD/MM/YYYY'),
    '76543210', 'Avenida Verde', '50', '81977776666', 
    TRUE, 'Bibliotecário', '98765432100', 2, 
    FALSE, NULL, 'roberto.lima@email.com', 'senha123'
);
END;
/

-- casdastro de leitor
-- cpf, nome, data de nascimento, cep, rua, número, telefone, é funcionário, cargo, supervisor, seção, é leitor, tipo leitor, email, senha
BEGIN cadastrar_pessoa(
    '111.222.333-44', 'Roberto Lima', TO_DATE('01/01/1990', 'DD/MM/YYYY'),
    '76543210', 'Avenida Verde', '50', '81977776666', 
    FALSE, NULL, NULL, NULL,  
    TRUE, 'P', 'roberto.lima@email.com', 'senha123'
);
END;
/

-- cadastro de funcionário e leitor
BEGIN cadastrar_pessoa(
    '111.111.111-22', 'Pedro Vaz', TO_DATE('01/01/1980', 'DD/MM/YYYY'),
    '76543210', 'Avenida Verde', '50', '81988880000', 
    TRUE, 'Bibliotecário', '98765432100', 2, 
    TRUE, 'A', 'pedro.vaz@email.com', '112358'
);
END;
/

COMMIT;