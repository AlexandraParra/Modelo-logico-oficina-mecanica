-- Criação de tabelas

-- Tabela Cliente
CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    endereço VARCHAR(150),
    telefone VARCHAR(20)
);

-- Tabela Veículo
CREATE TABLE Veículo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20),
    modelo VARCHAR(50),
    ano INT,
    cliente_id INT,
    constrain fk_veiculo_cliente FOREIGN KEY(cliente_id) REFERENCES Cliente(id)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

-- Tabela Ordem_Servico
CREATE TABLE Ordem_Servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_emissão DATE,
    data_conclusão DATE,
    valor_total FLOAT,
    status VARCHAR(20),
    veiculo_id INT,
    equipe_id INT,
    constrain fk_ordem_servico_veiculo FOREIGN KEY(veiculo_id) REFERENCES Veículo(id),
    constrain fk_ordem_servico_equipe FOREIGN KEY(equipe_id) REFERENCES Equipe(id)
);

-- Tabela Servico
CREATE TABLE Servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descrição VARCHAR(255),
    valor_mão_obra FLOAT
);

-- Tabela Peca
CREATE TABLE Peca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descrição VARCHAR(255),
    valor FLOAT
);

-- Tabela Mecanico
CREATE TABLE Mecanico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    endereço VARCHAR(150),
    especialidade VARCHAR(50),
    equipe_id INT,
    constrain fk_mecanico_equipe FOREIGN KEY(equipe_id) REFERENCES Equipe(id)
);

-- Tabela relacional Relation_OrdemServico_Servico
CREATE TABLE Relation_OrdemServico_Servico (
    ordem_servico_id INT,
    servico_id INT,
    PRIMARY KEY (ordem_servico_id, servico_id),
    constrain fk_relation_ordemservico_ordem FOREIGN KEY(ordem_servico_id) REFERENCES Ordem_Servico(id),
    constrain fk_relation_ordemservico_servico FOREIGN KEY(servico_id) REFERENCES Servico(id)
);

-- Tabela relacional Relation_OrdemServico_Peca
CREATE TABLE Relation_OrdemServico_Peca (
    ordem_servico_id INT,
    peca_id INT,
    PRIMARY KEY (ordem_servico_id, peca_id),
    constrain fk_relation_ordemservico_ordem FOREIGN KEY(ordem_servico_id) REFERENCES Ordem_Servico(id),
    constrain fk_relation_ordemservico_peca FOREIGN KEY(peca_id) REFERENCES Peca(id)
);