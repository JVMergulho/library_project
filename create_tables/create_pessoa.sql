DROP TABLE Telefone CASCADE CONSTRAINTS;
DROP TABLE Leitor CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;
DROP TABLE Secao CASCADE CONSTRAINTS;
DROP TABLE Pessoa CASCADE CONSTRAINTS;
DROP TABLE Logradouro CASCADE CONSTRAINTS;

DROP SEQUENCE seq_id_secao;
DROP SEQUENCE seq_cadastro_funcionario;

-- CRIAÇÃO DE TABELAS PARA CADASTRO DE PESSOAS

-- sequências para gerar identificadores únicos
CREATE SEQUENCE seq_cadastro_funcionario
    START WITH 1000
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_secao
    START WITH 1
    INCREMENT BY 1;

-- levando em consideração que CEP pode ter hífen
-- e que o número de telefone pode ter parênteses e traço
-- e que o CPF pode ter pontos e traço
-- e que o número do endereço pode ter letras ou ser SN (sem número)
CREATE TABLE Logradouro (
    CEP VARCHAR2(8),
    Rua VARCHAR2(50),
    CONSTRAINT logradouro_pk PRIMARY KEY ( CEP )
);

CREATE TABLE Pessoa (
    CPF VARCHAR2(14),
    Nome VARCHAR2(50),
    DatadeNascimento DATE,
    CEP VARCHAR2(9),
    NumeroEndereco VARCHAR2(10),
    CONSTRAINT pessoa_pk PRIMARY KEY ( CPF ),
    CONSTRAINT pessoa_fk_logradouro FOREIGN KEY ( CEP ) REFERENCES Logradouro(CEP)
);

CREATE TABLE Telefone (
    CPF VARCHAR2(14),
    Fone VARCHAR2(20),
    CONSTRAINT telefone_pk PRIMARY KEY ( CPF, Fone ),
    CONSTRAINT telefone_fk_pessoa FOREIGN KEY ( CPF ) REFERENCES Pessoa(CPF)
);

-- Pessoa pode ser um Leitor ou um Funcionário (ou ambos)

-- Tipo de Leitor: 
-- I -> Infantil (não tem acesso a conteúdo adulto nem restrito),  
-- A -> Adulto (não tem acesso a conteúdo restrito), 
-- P -> Pesquisador (tem acesso a todo conteúdo)

-- ON DELETE CASCADE: Se uma Pessoa for excluída, seu registro em Leitor também será automaticamente removido.
CREATE TABLE Leitor (
    CPF VARCHAR2(14),
    TipodeLeitor CHAR(20),
    Email VARCHAR(320),
    Senha VARCHAR2(30),
    CONSTRAINT leitor_pk PRIMARY KEY (CPF),
    CONSTRAINT leitor_fk_pessoa FOREIGN KEY (CPF) REFERENCES Pessoa(CPF) ON DELETE CASCADE,
    CONSTRAINT check_tipo_leitor CHECK (TipodeLeitor IN ('I', 'A', 'P'))
);

-- seção onde os funcionários trabalham
CREATE TABLE Secao (
    ID INTEGER,
    Nome VARCHAR2(50),
    CONSTRAINT secao_pk PRIMARY KEY (ID)
);

CREATE TABLE Funcionario (
    CPF VARCHAR2(14),
    Cargo VARCHAR2(50),
    Supervisor VARCHAR2(14),
    CodigoFuncionario INTEGER,
    Email VARCHAR(320),
    Senha VARCHAR2(30),
    secao INTEGER,
    CONSTRAINT funcionario_pk PRIMARY KEY (CPF),
    CONSTRAINT funcionario_fk_pessoa FOREIGN KEY (CPF) REFERENCES Pessoa(CPF) ON DELETE CASCADE,
    CONSTRAINT funcionario_fk_supervisor FOREIGN KEY (Supervisor) REFERENCES Funcionario (CPF),CONSTRAINT funcionario_fk_secao FOREIGN KEY (secao) REFERENCES Secao (ID)
);

COMMIT;