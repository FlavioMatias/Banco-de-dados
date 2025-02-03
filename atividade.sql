CREATE DATABASE Clinica;
USE Clinica;

CREATE TABLE Pessoa (
    cpf CHAR(11) PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);

CREATE TABLE Paciente (
    cpf_pessoa CHAR(11) PRIMARY KEY,
    senha VARCHAR(255) NOT NULL,
    plano_saude VARCHAR(100),
    FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa(cpf)
);

CREATE TABLE Medico (
    cpf_pessoa CHAR(11) PRIMARY KEY,
    crm VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa(cpf)
);

CREATE TABLE Especialidade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE Medico_Especialidade (
    cpf_medico CHAR(11),
    id_especialidade INT,
    PRIMARY KEY (cpf_medico, id_especialidade),
    FOREIGN KEY (cpf_medico) REFERENCES Medico(cpf_pessoa),
    FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id)
);

CREATE TABLE Agendamento (
    cpf_paciente CHAR(11),
    dh_consulta DATETIME,
    cpf_medico CHAR(11),
    dh_agendamento DATETIME NOT NULL,
    valor_consulta DECIMAL(10,2),
    PRIMARY KEY (cpf_paciente, dh_consulta),
    FOREIGN KEY (cpf_paciente) REFERENCES Paciente(cpf_pessoa),
    FOREIGN KEY (cpf_medico) REFERENCES Medico(cpf_pessoa)
);
