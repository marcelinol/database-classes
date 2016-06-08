--As consultas são feitas em cima das tabelas da aula pratica do dia 31/05

select nome, salario,
  case when salario < 600 then 'salario baixo'
    when salario >= 600 and salario <= 1200 then 'salario medio'
    when salario > 1200 then 'salario alto'
    end
  from funcionario;


select sum(capacidade), andar from ambulatorio
  group by andar
  having sum(capacidade) > 100;
