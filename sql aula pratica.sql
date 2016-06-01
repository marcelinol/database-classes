create database aula_pratica;

CREATE TABLE cidades (
  cod_cidade integer,
  descricao varchar(50),
  uf varchar(30),
  PRIMARY KEY (cod_cidade)
);

CREATE TABLE funcionarios (
  rg INTEGER PRIMARY KEY,
  nome VARCHAR(30),
  idade INTEGER,
  salario INTEGER,
  cod_cidade integer,
  FOREIGN KEY (cod_cidade) REFERENCES cidades (cod_cidade)
);

CREATE TABLE ambulatorios (
  numeroA integer PRIMARY KEY,
  andar integer,
  capacidade integer
);

CREATE TABLE medicos (
  crm integer PRIMARY KEY,
  nome varchar(50),
  idade integer,
  cod_cidade integer,
  especialidade varchar(20),
  numeroA integer,
  FOREIGN KEY (cod_cidade) REFERENCES cidades (cod_cidade),
  FOREIGN KEY (numeroA) REFERENCES ambulatorios (numeroA)
);

-- insertions

insert into cidades values (1, 'Florianopolis', 'SC');
insert into cidades values (2, 'Porto Alegre', 'RS');
insert into cidades values (3, 'Gramado', 'RS');

insert into funcionarios values (300, 'Eduardo', 25, 3000, 1);
insert into funcionarios values (320, 'Eduardo', 25, 3001, 1);
insert into funcionarios values (400, 'Eduarda', 30, 1000, 1);
insert into funcionarios values (500, 'Rodrigo', 40, 15000, 1);
insert into funcionarios values (501, 'Rodrigo', 40, 15000, 2);

insert into ambulatorios values(10, 5, 100);
insert into ambulatorios values(20, 5, 50);
insert into ambulatorios values(30, 5, 300);

insert into medicos values (111, 'Mario', 65, 1, 'cardiologista',10);
insert into medicos values (46, 'Nazareno', 33, 1, 'Pneumologista',20);
insert into medicos values (79, 'Antoine', 70, 2, 'Ortopedista',10);
insert into medicos values (444, 'Ricardo', 60, 3, 'cardiologista',10);
insert into medicos values (244, 'Rodrigo', 60, 3, 'cardiologista',10);


-- queries

select nome from funcionarios where nome like 'Edu%';
select nome from funcionarios where nome like 'edu%';
select nome from funcionarios where nome ilike 'edu%';
select nome from funcionarios where nome like '%ar%';

select nome from medicos
intersect
select nome from funcionarios;

select nome from medicos
union
select nome from funcionarios;

select nome from funcionarios;
select distinct nome from funcionarios;
select distinct nome from medicos order by nome;
select distinct nome from medicos order by nome desc;

select avg (salario) from funcionarios;
select count (*) from medicos;

select cidades.descricao, count(medicos.*) as quantidadeDeMedicos
  from medicos, cidades
  where medicos.cod_cidade = cidades.cod_cidade
    group by cidades.descricao;

select cidades.descricao, sum(funcionarios.salario)
  from cidades, funcionarios
  where funcionarios.cod_cidade = cidades.cod_cidade
    group by cidades.descricao
    having sum (funcionarios.salario) > 20000;


-- this one will fail :arrow_down:
select cidades.descricao, sum(funcionarios.salario)
  from cidades, funcionarios
  where funcionarios.cod_cidade = cidades.cod_cidade
    and sum (funcionarios.salario) > 5000
    group by cidades.descricao;

select nome from funcionarios
  where nome in (select nome from medicos);
