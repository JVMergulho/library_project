CREATE OR REPLACE PROCEDURE cadastrar_pessoa(
    p_cpf           IN VARCHAR2,
    p_nome          IN VARCHAR2,
    p_data_nasc     IN DATE,
    p_cep           IN VARCHAR2,
    p_rua           IN VARCHAR2,
    p_numero_end    IN VARCHAR2,
    p_telefone      IN VARCHAR2, 
    p_e_funcionario IN BOOLEAN,
    p_cargo         IN VARCHAR2 DEFAULT NULL,
    p_supervisor    IN VARCHAR2 DEFAULT NULL,
    p_secao         IN INTEGER DEFAULT NULL,
    p_e_leitor      IN BOOLEAN,
    p_tipo_leitor   IN CHAR DEFAULT NULL,
    p_email         IN VARCHAR2 DEFAULT NULL,
    p_senha         IN VARCHAR2 DEFAULT NULL
) AS
    v_cod_funcionario INTEGER;
    v_cod_leitor INTEGER;
    v_cep_existente INTEGER;
    v_pessoa_existente INTEGER;
    v_telefone_existe INTEGER;
BEGIN
    -- Verifica se o cpf foi informado
    IF p_cpf IS NULL OR TRIM(p_cpf) = '' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: O CPF é obrigatório.');
    ELSE
            -- Verifica se o CPF já foi registrado
            SELECT COUNT(*) INTO v_pessoa_existente FROM Pessoa WHERE CPF = p_cpf;
        
        IF v_pessoa_existente > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Pessoa já cadastrada: ' || p_nome || ' (CPF: ' || p_cpf || ')');
        ELSIF v_pessoa_existente = 0 THEN
            -- Caso o CPF não seja duplicado, prossegue com o cadastro da pessoa

            -- Verifica se o CEP já existe na tabela Logradouro
            SELECT COUNT(*) INTO v_cep_existente FROM Logradouro WHERE CEP = p_cep;
            IF v_cep_existente = 0 THEN
                INSERT INTO Logradouro (CEP, Rua) VALUES (p_cep, p_rua);
                DBMS_OUTPUT.PUT_LINE('Logradouro criado: ' || p_rua || ' (CEP: ' || p_cep || ')');
            END IF;

            -- Insere a Pessoa
            INSERT INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) 
            VALUES (p_cpf, p_nome, p_data_nasc, p_cep, p_numero_end);

             -- Verifica se o telefone já está cadastrado para o CPF fornecido
            SELECT COUNT(*) INTO v_telefone_existe FROM Telefone WHERE CPF = p_cpf AND Fone = p_telefone;
            IF v_telefone_existe = 0 THEN
                INSERT INTO Telefone (CPF, Fone) VALUES (p_cpf, p_telefone);
                DBMS_OUTPUT.PUT_LINE('Telefone cadastrado: ' || p_telefone);
            END IF;

            DBMS_OUTPUT.PUT_LINE('Pessoa criada: ' || p_nome || ' (CPF: ' || p_cpf || ')');
        END IF;
    END IF;

    -- Se for Funcionário, insere na tabela Funcionario
    IF p_e_funcionario THEN
        -- Se já for um funcionário, só faz a atualização ou inserção, conforme necessário
        SELECT COUNT(*) INTO v_pessoa_existente FROM Funcionario WHERE CPF = p_cpf;

        IF v_pessoa_existente = 0 THEN
            -- Gera um novo código para o funcionário usando a sequência
            SELECT seq_cadastro_funcionario.NEXTVAL INTO v_cod_funcionario FROM DUAL;

            -- Verifica se o supervisor informado existe
            IF p_supervisor IS NOT NULL THEN
                DECLARE v_count INTEGER;
                BEGIN
                    SELECT COUNT(*) INTO v_count FROM Funcionario WHERE CPF = p_supervisor;
                    IF v_count = 0 THEN
                        RAISE_APPLICATION_ERROR(-20003, 'Erro: Supervisor com CPF ' || p_supervisor || ' não encontrado.');
                    END IF;
                END;
            END IF;

            -- Inserção do funcionário
            INSERT INTO Funcionario (CodigoFuncionario, CPF, Cargo, Supervisor, Email, Senha, secao)
            VALUES (v_cod_funcionario, p_cpf, p_cargo, p_supervisor, p_email, p_senha, p_secao);

            DBMS_OUTPUT.PUT_LINE('Funcionário cadastrado: ' || p_nome || ' (Cargo: ' || p_cargo || ')');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Funcionário já cadastrado: ' || p_nome || ' (CPF: ' || p_cpf || ')');
        END IF;
    END IF;

    -- Se for Leitor, insere na tabela Leitor
    IF p_e_leitor THEN
        -- Se já for um leitor, só faz a atualização ou inserção
        SELECT COUNT(*) INTO v_pessoa_existente FROM Leitor WHERE CPF = p_cpf;

        IF v_pessoa_existente = 0 THEN

            -- Inserção do leitor
            INSERT INTO Leitor (CPF, TipodeLeitor, Email, Senha)
            VALUES (p_cpf, p_tipo_leitor, p_email, p_senha);

            DBMS_OUTPUT.PUT_LINE('Leitor cadastrado: ' || p_nome || ' (Tipo: ' || p_tipo_leitor || ')');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Leitor já cadastrado: ' || p_nome || ' (CPF: ' || p_cpf || ')');
        END IF;
    END IF;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cadastro concluído com sucesso.');
    
EXCEPTION
    -- Inserção de CPF duplicado
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: CPF ' || p_cpf || ' já cadastrado.');
        ROLLBACK;
    -- Quando o supervisor não é encontrado
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Supervisor não encontrado.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
        ROLLBACK;
END;
/
