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
insert into consulta values(111, 300, '05/21/2015','05/21/2015 10:00', 2);
insert into consulta values(111, 1500, '10/22/2015','10/22/2015 10:00',2);
insert into consulta values(46, 300, '08/25/2015','08/25/2015 10:00',2);



-- EXERCICIOS

-- 1) buscar os dados dos pacientes que estão com sarampo
select paciente.* from paciente, consulta, doenca where paciente.rg = consulta.rg and doenca.descricao = 'sarampo' and consulta.codDoenca = doenca.codDoenca;

/*
rg  |    nome     | idade | codcidade
------+-------------+-------+-----------
300 | Eduardo     |    25 |         1
1500 | Rodriguinho |    30 |         2
1500 | Rodriguinho |    30 |         2
(3 rows)
*/

-- 2) buscar os dados dos médicos ortopedistas com mais de 40 anos
select medico.* from medico, especialidade where especialidade.nome = 'Ortopedista' and medico.codEsp = especialidade.codEsp and idade > 40;

/*
crm |  nome   | idade | codcidade | codesp | numeroa
-----+---------+-------+-----------+--------+---------
 79 | Antoine |    70 |         2 |      3 |      10
*/

-- 3) recuperar a especialidade e o numero total de médicos de cada especialidade
select especialidade.nome, count(medico.*) as medicosPorEspecialidades
  from especialidade, medico
  where medico.codEsp = especialidade.codEsp
  group by especialidade.nome;

/*
  nome      | medicosporespecialidades
---------------+--------------------------
Pneumologista |                        1
cardiologista |                        3
Ortopedista   |                        1
(3 rows)
*/

-- 4) recupere os nomes dos médicos que não tem consultas na tabela de consultas
select nome from medico
  where crm not in (select crm from consulta);

/*
  nome
---------
Antoine
Ricardo
Rodrigo
(3 rows)
*/

-- 5) buscar os dados das consultas, exceto aquelas marcadas para os médicos com CRM 46 e 79
select consulta.* from consulta, medico
  where medico.crm not in (46, 79)
  and consulta.crm = medico.crm;

/*
crm |  rg  |    data    |        hora         | coddoenca
-----+------+------------+---------------------+-----------
111 |  300 | 2016-01-01 | 2016-01-01 10:00:00 |         1
111 | 1400 | 2016-01-01 | 2016-01-01 10:30:00 |         2
111 | 1500 | 2016-01-01 | 2016-01-01 11:00:00 |         1
111 | 1500 | 2016-05-01 | 2016-05-01 11:00:00 |         1
(4 rows)
*/

-- 6) buscar os dados dos ambulatórios do quinto andar que ou tenham capacidade igual a 50 ou tenham número superior a 10
select * from ambulatorio
  where ambulatorio.andar = 5
  and (
    ambulatorio.capacidade = 50
    or ambulatorio.numeroA > 10
  );

/*
numeroa | andar | capacidade
---------+-------+------------
     20 |     5 |         50
     30 |     5 |        300
(2 rows)
*/

-- 7) buscar o nome dos médicos que têm consulta marcada e as datas das suas consultas, ordenando o nome dos médicos em ordem alfabética
select medico.nome, consulta.data from medico, consulta
  where medico.crm = consulta.crm
  order by medico.nome;

/*
nome   |    data
----------+------------
Mario    | 2016-01-01
Mario    | 2016-01-01
Mario    | 2016-01-01
Mario    | 2016-05-01
Nazareno | 2016-05-01
(5 rows)
*/

-- 8) buscar o CRM dos médicos e as datas das consultas para os pacientes com RG 300 e 1500 (ALTEREI OS RGS PARA BATER COM MEUS DADOS)
select medico.crm, consulta.data, paciente.rg from medico, consulta, paciente
  where medico.crm = consulta.crm
  and paciente.rg = consulta.rg
  and paciente.rg in (300,1500);

/* crm |    data    |  rg
-----+------------+------
 111 | 2016-01-01 |  300
 111 | 2016-01-01 | 1500
 111 | 2016-05-01 | 1500
  46 | 2016-05-01 | 1500
(4 rows)
*/

-- 9) buscar os números dos ambulatórios, exceto aqueles do segundo e quarto andares, que suportam mais de 50 pacientes
explain select numeroA from ambulatorio
  where andar not in (2,4)
  and capacidade > 50;

explain select numeroA from ambulatorio
  where andar <> 2
  and andar <> 4
  and capacidade > 50;

/*
numeroa
---------
     10
     30
(2 rows)
*/

-- 10) buscar o número e a capacidade dos ambulatórios do quinto andar e o nome dos médicos que atendem neles
select ambulatorio.numeroA, ambulatorio.capacidade, medico.nome from ambulatorio, medico
  where medico.numeroA = ambulatorio.numeroA
  and ambulatorio.andar = 5;

/*
numeroa | capacidade |   nome
---------+------------+----------
     10 |        100 | Mario
     20 |         50 | Nazareno
     10 |        100 | Antoine
     10 |        100 | Ricardo
     10 |        100 | Rodrigo
(5 rows)
*/

-- 11) buscar o nome dos médicos e o nome dos seus pacientes com consulta marcada, assim como a data destas consultas
select medico.nome, paciente.nome, consulta.data from medico, paciente, consulta
  where medico.crm = consulta.crm
  and paciente.rg = consulta.rg;

/*
nome   |    nome     |    data
----------+-------------+------------
Mario    | Eduardo     | 2016-01-01
Mario    | Eduardinha  | 2016-01-01
Mario    | Rodriguinho | 2016-01-01
Mario    | Rodriguinho | 2016-05-01
Nazareno | Rodriguinho | 2016-05-01
(5 rows)
*/

-- 12) buscar os nomes dos pacientes, com consultas marcadas para os médicos João Carlos Santos ou Maria Souza, que estão com pneumonia
select paciente.nome from paciente, consulta, medico, doenca
  where (medico.nome = 'João Carlos Santos' or medico.nome = 'Maria Souza')
  and consulta.crm = medico.crm
  and doenca.descricao = 'pneumonia'
  and doenca.codDoenca = consulta.codDoenca;

/*
nome
------
(0 rows)
*/

-- 13) buscar os nomes e idade dos médicos, pacientes e funcionários que residem em Florianópolis
select medico.nome, medico.idade from medico, cidade
  where cidade.descricao = 'Florianopolis'
  and medico.codCidade = cidade.codCidade
  UNION
select funcionario.nome, funcionario.idade from funcionario, cidade
  where cidade.descricao = 'Florianopolis'
  and funcionario.codCidade = cidade.codCidade
  UNION
select paciente.nome, paciente.idade from paciente, cidade
  where cidade.descricao = 'Florianopolis'
  and paciente.codCidade = cidade.codCidade;

/*
nome    | idade
------------+-------
Eduardo    |    25
Mario      |    65
Rodrigo    |    40
Eduarda    |    30
Eduardinho |    18
Eduardinha |    22
Nazareno   |    33
(7 rows)
*/

-- 14) buscar os nomes e RGs dos funcionários que recebem salários abaixo de R$ 1300,00 e que não estão internados como pacientes
select nome, rg from funcionario
  where salario < 1300
  and rg not in (select rg from paciente);

/*
nome   | rg
---------+-----
Eduarda | 400
(1 row)
*/
-- 15) buscar os números dos ambulatórios onde nenhum médico fornece atendimento
-- 16) buscar os nomes e os RGs dos funcionários que estão internados como pacientes
-- 17) buscar os nomes dos funcionários que nunca consultaram
-- 18) quais são as cidades cuja soma dos salários dos funcionários ultrapassa 1.000.000?
-- 19) recupere o nome dos médicos e dos pacientes e a cidade onde moram.
-- 20) buscar o total de médicos para cada especialidade
