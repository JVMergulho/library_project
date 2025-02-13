-- exemplo de grant e revoke
GRANT SELECT ON Pessoa TO usuario1;

GRANT SELECT, INSERT, UPDATE, DELETE ON Multa TO usuario2;

REVOKE ALL PRIVILEGES ON Leitor FROM usuario3;