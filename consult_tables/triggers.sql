-- Triggers

-- Trigger de linha
CREATE OR REPLACE TRIGGER checa_data_limite 
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF :NEW.DataLimite IS NULL THEN
        :NEW.DataLimite := :NEW.DataReserva + 7;
    END IF;
END;

-- Trigger de comando
CREATE OR REPLACE TRIGGER log_livros
AFTER INSERT OR DELETE OR UPDATE ON Livro
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Livro(s) inserido(s)');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Livro(s) atualizado(s)');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Livro(s) deletado(s)');
    END IF;
END;

CREATE OR REPLACE TRIGGER checa_data_futura
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF :NEW.DataReserva > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20000, 'Data de reserva não pode ser uma data futura');
    END IF;
END checa_data_reserva;

COMMIT;
