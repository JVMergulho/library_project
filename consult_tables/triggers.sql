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

CREATE OR REPLACE TRIGGER checa_restricao_datas
BEFORE INSERT ON Reserva
FOR EACH ROW
DECLARE
    data_futura EXCEPTION;
    data_trocada EXCEPTION;
    data_muito_proxima EXCEPTION;
BEGIN
    IF :NEW.DataReserva > SYSDATE THEN
        RAISE data_futura;
    ELSIF :NEW.DataReserva < SYSDATE - 7 THEN
        RAISE data_muito_proxima;
    ELSIF :NEW.DataReserva > :NEW.DataLimite THEN
        RAISE data_trocada;
    END IF;
EXCEPTION
    WHEN data_futura THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data de reserva futura');
    WHEN data_muito_proxima THEN
        RAISE_APPLICATION_ERROR(-20002, 'Data de reserva muito próxima');
    WHEN data_trocada THEN
        RAISE_APPLICATION_ERROR(-20003, 'Datas trocadas');
END checa_restricao_datas;

COMMIT;
