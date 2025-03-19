
INSERT INTO Emprestimo
VALUES (
    EmprestimoType(
       (SELECT REF(l) FROM Leitor l 
         WHERE l.CPF = 15468718901),
       (SELECT REF(f) FROM Funcionario f
         WHERE f.CPF = 12345678901),
       (SELECT REF(li) FROM Livro li
         WHERE li.CodigoTombamento = 6),
       TO_DATE('02/10/2024','DD/MM/YYYY'),
       TO_DATE('06/10/2024','DD/MM/YYYY'),
       'D'
    )
);


INSERT INTO Emprestimo
VALUES (
    EmprestimoType(
       (SELECT REF(l) FROM Leitor l 
         WHERE l.CPF = 56234565444),
       (SELECT REF(f) FROM Funcionario f
         WHERE f.CPF = 98765432100),
       (SELECT REF(li) FROM Livro li
         WHERE li.CodigoTombamento = 3),
       TO_DATE('02/10/2024','DD/MM/YYYY'),
       TO_DATE('17/10/2024','DD/MM/YYYY'),
       'D'
    )
);


INSERT INTO Emprestimo
VALUES (
    EmprestimoType(
       (SELECT REF(l) FROM Leitor l 
         WHERE l.CPF = 56234565444),
       (SELECT REF(f) FROM Funcionario f
         WHERE f.CPF = 98765432100),
       (SELECT REF(li) FROM Livro li
         WHERE li.CodigoTombamento = 3),
       TO_DATE('17/10/2024','DD/MM/YYYY'),
       TO_DATE('27/10/2024','DD/MM/YYYY'),
       'D'
    )
);


INSERT INTO Emprestimo
VALUES (
    EmprestimoType(
       (SELECT REF(l) FROM Leitor l
         WHERE l.CPF = 98765432110),
       (SELECT REF(f) FROM Funcionario f
         WHERE f.CPF = 98765432100),
       (SELECT REF(li) FROM Livro li
         WHERE li.CodigoTombamento = 7),
       TO_DATE('01/02/2025','DD/MM/YYYY'),
       NULL,
       'E'
    )
);

INSERT INTO Emprestimo
VALUES (
    EmprestimoType(
       (SELECT REF(l) FROM Leitor l
         WHERE l.CPF = 15468718901),
       (SELECT REF(f) FROM Funcionario f
         WHERE f.CPF = 12345678901),
       (SELECT REF(li) FROM Livro li
         WHERE li.CodigoTombamento = 4),
       TO_DATE('02/01/2025','DD/MM/YYYY'),
       NULL,
       'A'
    )
);

COMMIT;


INSERT INTO Reserva
VALUES (
    Reserva(
        (SELECT REF(l) FROM Leitor l 
          WHERE l.CPF = 15468718901),
        (SELECT REF(f) FROM Funcionario f
          WHERE f.CPF = 12345678901),
        (SELECT REF(li) FROM Livro li
          WHERE li.CodigoTombamento = 6),
        TO_DATE('06/02/2025','DD/MM/YYYY'),
        TO_DATE('16/02/2025','DD/MM/YYYY'),
        'R'
    )
);

INSERT INTO Reserva
VALUES (
    Reserva(
        (SELECT REF(l) FROM Leitor l 
          WHERE l.CPF = 56234565444),
        (SELECT REF(f) FROM Funcionario f
          WHERE f.CPF = 98765432100),
        (SELECT REF(li) FROM Livro li
          WHERE li.CodigoTombamento = 1),
        TO_DATE('27/10/2024','DD/MM/YYYY'),
        TO_DATE('06/11/2024','DD/MM/YYYY'),
        'F'
    )
);

COMMIT;



INSERT INTO Multa
VALUES (
    MultaType(
        (SELECT REF(e)
           FROM Emprestimo e
          WHERE e.Leitor = (SELECT REF(lt) FROM Leitor lt WHERE lt.CPF=15468718901)
            AND e.Funcionario = (SELECT REF(f) FROM Funcionario f WHERE f.CPF=12345678901)
            AND e.Livro = (SELECT REF(li) FROM Livro li WHERE li.CodigoTombamento=4)
            AND e.DataEmprestimo = TO_DATE('02/01/2025','DD/MM/YYYY')
        ),
        TO_DATE('16/01/2025','DD/MM/YYYY'),
        'A',
        0.50,
        100.00
    )
);

COMMIT;

INSERT INTO Multa
VALUES (
    MultaType(
        (SELECT REF(e)
           FROM Emprestimo e
          WHERE e.Leitor = (SELECT REF(l) FROM Leitor l 
                             WHERE l.CPF = 56234565444)
            AND e.Funcionario = (SELECT REF(f) FROM Funcionario f
                                  WHERE f.CPF = 98765432100)
            AND e.Livro = (SELECT REF(li) FROM Livro li
                             WHERE li.CodigoTombamento = 3)
            AND e.DataEmprestimo = TO_DATE('17/10/2024','DD/MM/YYYY')
        ),
        TO_DATE('29/10/2024','DD/MM/YYYY'), 
        'A',                                
        0.30,                               
        80.00                              
    )
);

COMMIT;
