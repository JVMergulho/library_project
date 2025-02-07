-- Inserindo dados na tabela Emprestimo
INSERT ALL 
    INTO Emprestimo (Leitor, Funcionario, Livro, DataEmprestimo, DataDevolucao, Estado) 
    VALUES ('15468718901', '12345678901', 6, TO_DATE('02/10/2024', 'DD/MM/YYYY'), TO_DATE('06/10/2024', 'DD/MM/YYYY'), 'D')
    
    INTO Emprestimo (Leitor, Funcionario, Livro, DataEmprestimo, DataDevolucao, Estado) 
    VALUES ('56234565444', '98765432100', 3, TO_DATE('02/10/2024', 'DD/MM/YYYY'), TO_DATE('17/10/2024', 'DD/MM/YYYY'), 'D')
    
    INTO Emprestimo (Leitor, Funcionario, Livro, DataEmprestimo, DataDevolucao, Estado) 
    VALUES ('56234565444', '98765432100', 3, TO_DATE('17/10/2024', 'DD/MM/YYYY'), TO_DATE('27/10/2024', 'DD/MM/YYYY'), 'D')
    
    INTO Emprestimo (Leitor, Funcionario, Livro, DataEmprestimo, DataDevolucao, Estado) 
    VALUES ('98765432110', '98765432100', 7, TO_DATE('01/02/2025', 'DD/MM/YYYY'), NULL, 'E')
    
    INTO Emprestimo (Leitor, Funcionario, Livro, DataEmprestimo, DataDevolucao, Estado) 
    VALUES ('15468718901', '12345678901', 4, TO_DATE('02/01/2025', 'DD/MM/YYYY'), NULL, 'A')
SELECT * FROM dual;

-- Inserindo dados na tabela Reserva
INSERT ALL
    INTO Reserva (Leitor, Funcionario, Livro, DataReserva, DataLimite, Estado) 
    VALUES ('15468718901', '12345678901', 6, TO_DATE('06/02/2025', 'DD/MM/YYYY'), TO_DATE('16/02/2025', 'DD/MM/YYYY'), 'R')
    
    INTO Reserva (Leitor, Funcionario, Livro, DataReserva, DataLimite, Estado) 
    VALUES ('56234565444', '98765432100', 1, TO_DATE('27/10/2024', 'DD/MM/YYYY'), TO_DATE('06/11/2024', 'DD/MM/YYYY'), 'F')
SELECT * FROM dual;

-- Inserindo dados na tabela Multa
INSERT ALL
    INTO Multa (Leitor, Funcionario, Livro, DataMulta, DataEmprestimo, Status, TaxaDiaria, ValorMaximo) VALUES ('15468718901', '12345678901', 4, TO_DATE('16/01/2025', 'DD/MM/YYYY'), TO_DATE('02/01/2025', 'DD/MM/YYYY'), 'A', 0.50, 100.00)
SELECT * FROM dual;

COMMIT;