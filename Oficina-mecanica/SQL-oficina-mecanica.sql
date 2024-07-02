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

-- Persistência de dados

-- Inserções para a tabela Cliente
INSERT INTO Cliente (nome, endereço, telefone) VALUES
('João Silva', 'Rua das Flores, 123', '(11) 98765-4321'),
('Maria Oliveira', 'Avenida Central, 456', '(21) 91234-5678'),
('Carlos Pereira', 'Praça da Liberdade, 789', '(31) 99876-5432');

-- Inserções para a tabela Veículo
INSERT INTO Veículo (placa, modelo, ano, cliente_id) VALUES
('ABC1234', 'Fiat Uno', 2010, 1),
('XYZ5678', 'Volkswagen Gol', 2015, 2),
('DEF9101', 'Chevrolet Onix', 2020, 3);

-- Inserções para a tabela Equipe
INSERT INTO Equipe (nome) VALUES
('Equipe Alfa'),
('Equipe Beta'),
('Equipe Gama');

-- Inserções para a tabela Ordem_Servico
INSERT INTO Ordem_Servico (data_emissão, data_conclusão, valor_total, status, veiculo_id, equipe_id) VALUES
('2024-01-10', '2024-01-15', 1500.00, 'Concluída', 1, 1),
('2024-02-20', '2024-02-25', 2000.00, 'Em andamento', 2, 2),
('2024-03-30', '2024-04-05', 2500.00, 'Aguardando peças', 3, 3);

-- Inserções para a tabela Servico
INSERT INTO Servico (descrição, valor_mão_obra) VALUES
('Troca de óleo', 100.00),
('Alinhamento', 150.00),
('Balanceamento', 200.00);

-- Inserções para a tabela Peca
INSERT INTO Peca (descrição, valor) VALUES
('Filtro de óleo', 50.00),
('Pneu', 400.00),
('Bateria', 250.00);

-- Inserções para a tabela Mecanico
INSERT INTO Mecanico (nome, endereço, especialidade, equipe_id) VALUES
('José Santos', 'Rua Nova, 101', 'Motor', 1),
('Ana Lima', 'Avenida Velha, 202', 'Suspensão', 2),
('Paulo Sousa', 'Travessa Antiga, 303', 'Elétrica', 3);

-- Inserções para a tabela relacional Relation_OrdemServico_Servico
INSERT INTO Relation_OrdemServico_Servico (ordem_servico_id, servico_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserções para a tabela relacional Relation_OrdemServico_Peca
INSERT INTO Relation_OrdemServico_Peca (ordem_servico_id, peca_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Recuperações simples com SELECT Statement;
SELECT * FROM Cliente;
SELECT * FROM Equipe;
SELECT * FROM Mecanico;
SELECT * FROM Ordem_Servico;
SELECT * FROM Peca;
SELECT * FROM Servico;
SELECT * FROM Veículo;

-- Filtros com WHERE Statement;

-- Seleccionar todos los servicios realizados com valor de mão de obra acima de 100
SELECT * FROM Servico WHERE valor_mão_obra > 100;

-- Seleccionar os clientes que começam com a letra M
SELECT * FROM cliente WHERE nome LIKE 'M%';

-- Crie expressões para gerar atributos derivados;
-- Duración Total del Servicio en Días para cada Orden de Servicio
SELECT Ordem_Servico.id AS ordem_servico_id, DATEDIFF(data_conclusão, data_emissão) AS duracao_servico_dias
FROM Ordem_Servico;

-- Defina ordenações dos dados com ORDER BY;
SELECT * FROM cliente ORDER BY nome;
SELECT * FROM ordem_servico ORDER BY data_conclusão;

-- Condições de filtros aos grupos – HAVING Statement;

-- Total de ordens de serviço por equipe com filtro
SELECT e.nome AS nome_equipe, COUNT(os.id) AS total_ordens_servico FROM Equipe e
JOIN Ordem_Servico os ON e.id = os.equipe_id GROUP BY e.nome
HAVING COUNT(os.id) > 1;

-- Total de valor de ordens de serviço por cliente acima de um valor específico
SELECT c.nome AS nome_cliente, SUM(os.valor_total) AS total_valor_ordens_servico
FROM Cliente c
JOIN Veículo v ON c.id = v.cliente_id
JOIN Ordem_Servico os ON v.id = os.veiculo_id
GROUP BY c.nome
HAVING SUM(os.valor_total) > 1500.00;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;

-- Seleccionar todos los vehículos y mostrar el nombre del cliente asociado
SELECT Veículo.*, Cliente.nome AS cliente_nome
FROM Veículo
JOIN Cliente ON Veículo.cliente_id = Cliente.id;

-- Seleccionar todas las órdenes de servicio y mostrar la placa del vehículo y el nombre de la equipe asociada
SELECT Ordem_Servico.*, Veículo.placa AS veiculo_placa, Equipe.nome AS equipe_nome
FROM Ordem_Servico
JOIN Veículo ON Ordem_Servico.veiculo_id = Veículo.id
JOIN Equipe ON Ordem_Servico.equipe_id = Equipe.id;

-- Seleccionar todos los mecánicos y mostrar el nombre de la equipe asociada
SELECT Mecanico.*, Equipe.nome AS equipe_nome
FROM Mecanico
JOIN Equipe ON Mecanico.equipe_id = Equipe.id;

-- Seleccionar todas las órdenes de servicio junto con los servicios y piezas asociados
SELECT Ordem_Servico.*, Servico.descrição AS servico_descrição, Peca.descrição AS peca_descrição
FROM Ordem_Servico
LEFT JOIN Relation_OrdemServico_Servico ON Ordem_Servico.id = Relation_OrdemServico_Servico.ordem_servico_id
LEFT JOIN Servico ON Relation_OrdemServico_Servico.servico_id = Servico.id
LEFT JOIN Relation_OrdemServico_Peca ON Ordem_Servico.id = Relation_OrdemServico_Peca.ordem_servico_id
LEFT JOIN Peca ON Relation_OrdemServico_Peca.peca_id = Peca.id;