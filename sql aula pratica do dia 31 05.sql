CREATE TABLE ambulatorio(
numeroA serial,
andar integer,
capacidade integer,
PRIMARY KEY (numeroA));

CREATE TABLE cidade(
codCidade serial,
descricao varchar(30),
UF varchar(2),
PRIMARY KEY (codCidade));

CREATE TABLE especialidade(
codEsp integer,
nome varchar(30),
PRIMARY KEY (codEsp));

CREATE TABLE medico(
CRM integer,
nome varchar(30),
idade integer,
codCidade integer,
codEsp integer,
numeroA integer,
PRIMARY KEY (CRM),
FOREIGN KEY (codCidade) REFERENCES cidade (codCidade) ON UPDATE RESTRICT ON DELETE RESTRICT,
FOREIGN KEY (codEsp) REFERENCES especialidade (codEsp) ON UPDATE RESTRICT ON DELETE RESTRICT,
FOREIGN KEY (numeroA) REFERENCES ambulatorio (numeroA) ON UPDATE RESTRICT ON DELETE RESTRICT);

CREATE TABLE doenca(
codDoenca serial,
descricao varchar(30),
PRIMARY KEY (codDoenca));

CREATE TABLE paciente(
RG integer,
nome varchar(30),
idade integer,
codCidade integer,
PRIMARY KEY (RG),
FOREIGN KEY (codCidade) REFERENCES cidade (codCidade) ON UPDATE RESTRICT ON DELETE RESTRICT);


CREATE TABLE consulta(
CRM integer,
RG integer,
data date,
hora timestamp,
codDoenca integer,
PRIMARY KEY (CRM, RG, data),
FOREIGN KEY (CRM) REFERENCES medico (CRM) ON UPDATE RESTRICT ON DELETE RESTRICT,
FOREIGN KEY (RG) REFERENCES paciente (RG) ON UPDATE RESTRICT ON DELETE RESTRICT,  FOREIGN KEY (codDoenca) REFERENCES doenca (codDoenca) ON UPDATE RESTRICT ON DELETE RESTRICT);

CREATE TABLE funcionario(
RG integer,
nome varchar(30),
idade integer,
codCidade integer,
salario float,
PRIMARY KEY (RG),
FOREIGN KEY (codCidade) REFERENCES cidade (codCidade) ON UPDATE RESTRICT ON DELETE RESTRICT);

-- INSERTIONS

-- CIDADES
insert into cidade values (1, 'Florianopolis', 'SC');
insert into cidade values (2, 'Porto Alegre', 'RS');
insert into cidade values (3, 'Gramado', 'RS');

-- FUNCIONARIOS
insert into funcionario values (300, 'Eduardo', 25, 1, 3000);
insert into funcionario values (320, 'Eduardo', 25, 1, 3001);
insert into funcionario values (400, 'Eduarda', 30, 1, 1000);
insert into funcionario values (500, 'Rodrigo', 40,  1, 15000);
insert into funcionario values (501, 'Rodrigo', 40,  2, 15000);

-- AMBULATORIOS
insert into ambulatorio values(10, 5, 100);
insert into ambulatorio values(20, 5, 50);
insert into ambulatorio values(30, 5, 300);

-- ESPECIALIDADES
insert into especialidade values (1, 'cardiologista');
insert into especialidade values (2, 'Pneumologista');
insert into especialidade values (3, 'Ortopedista');

-- MEDICOS
insert into medico values (111, 'Mario', 65, 1, 1, 10);
insert into medico values (46, 'Nazareno', 33, 1, 2, 20);
insert into medico values (79, 'Antoine', 70, 2, 3, 10);
insert into medico values (444, 'Ricardo', 60, 3, 1, 10);
insert into medico values (244, 'Rodrigo', 60, 3, 1, 10);

-- PACIENTES
insert into paciente values (300, 'Eduardo', 25, 1);
insert into paciente values (1320, 'Eduardinho', 18, 1);
insert into paciente values (1400, 'Eduardinha', 22, 1);
insert into paciente values (1500, 'Rodriguinho', 30,  2);

-- DOENCAS
insert into doenca values (1, 'sarampo');
insert into doenca values(2, 'cancer');

-- CONSULTAS
insert into consulta values(111, 300, '01/01/2016', '01/01/2016 10:00', 1);
insert into consulta values(111, 1400, '01/01/2016', '01/01/2016 10:30', 2);
insert into consulta values(111, 1500, '01/01/2016', '01/01/2016 11:00', 1);
insert into consulta values(111, 1500, '05/01/2016', '05/01/2016 11:00', 1);
insert into consulta values(46, 1500, '05/01/2016', '05/01/2016 11:00', 2);



-- EXERCICIOS

-- 1) buscar os dados dos pacientes que estão com sarampo

-- 2) buscar os dados dos médicos ortopedistas com mais de 40 anos
-- 3) recuperar a especialidade e o numero total de médicos de cada especialidade
-- 4) recupere os nomes dos médicos que não tem consultas na tabela de consultas
-- 5) buscar os dados das consultas, exceto aquelas marcadas para os médicos com CRM 46 e 79
-- 6) buscar os dados dos ambulatórios do quarto andar que ou tenham capacidade igual a 50 ou tenham número superior a 10
-- 7) buscar o nome dos médicos que têm consulta marcada e as datas das suas consultas, ordenando o nome dos médicos em ordem alfabética
-- 8) buscar o CRM dos médicos e as datas das consultas para os pacientes com RG 122 e 725
-- 9) buscar os números dos ambulatórios, exceto aqueles do segundo e quarto andares, que suportam mais de 50 pacientes
-- 10) buscar o número e a capacidade dos ambulatórios do quinto andar e o nome dos médicos que atendem neles
-- 11) buscar o nome dos médicos e o nome dos seus pacientes com consulta marcada, assim como a data destas consultas
-- 12) buscar os nomes dos pacientes, com consultas marcadas para os médicos João Carlos Santos ou Maria Souza, que estão com pneumonia
-- 13) buscar os nomes e idade dos médicos, pacientes e funcionários que residem em Florianópolis
-- 14) buscar os nomes e RGs dos funcionários que recebem salários abaixo de R$ 1300,00 e que não estão internados como pacientes
-- 15) buscar os números dos ambulatórios onde nenhum médico fornece atendimento
-- 16) buscar os nomes e os RGs dos funcionários que estão internados como pacientes
-- 17) buscar os nomes dos funcionários que nunca consultaram
-- 18) quais são as cidades cuja soma dos salários dos funcionários ultrapassa 1.000.000?
-- 19) recupere o nome dos médicos e dos pacientes e a cidade onde moram.
-- 20) buscar o total de médicos para cada especialidade
