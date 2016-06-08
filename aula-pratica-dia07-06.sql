--As consultas são feitas em cima das tabelas da aula pratica do dia 31/05

-- exemplo de uso do CASE
select nome, salario,
  case when salario < 600 then 'salario baixo'
    when salario >= 600 and salario <= 1200 then 'salario medio'
    when salario > 1200 then 'salario alto'
    end
  from funcionario;

-- exemplo de uso do HAVING
select sum(capacidade), andar from ambulatorio
  group by andar
  having sum(capacidade) > 100;

-- exemplos de uso do DATE_PART
select date_part('month', data) from consulta;

select count(consulta.*), medico.nome from consulta, medico
  where consulta.crm = medico.crm
  and date_part('month', consulta.data) = 5
  group by medico.nome;

select (max(data) - min(data)) as difference, count(rg), rg from consulta
  group by rg
  having count(rg) > 1;

-- exemplo de LEFT JOIN
select ambulatorio.numeroA, medico.crm, medico.nome from ambulatorio left join medico
  on ambulatorio.numeroA = medico.numeroA;
