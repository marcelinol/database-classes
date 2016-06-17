create user dba;
create user medico;
create user estagiario;
create user secretaria;


-- QUESTAO 1
create view viewNomesEDataConsulta as
  select medico.nome as nomeMedico, paciente.nome as nomePaciente, consulta.data
  from medico, paciente, consulta
  where consulta.crm = medico.crm
  and paciente.rg = consulta.rg;

grant select on viewNomesEDataConsulta to estagiario, secretaria;


--QUESTAO 2
grant insert on funcionario to estagiario;


-- QUESTAO 3
grant insert, update on paciente to medico, secretaria;

-- QUESTAO 4
grant select, update on funcionario(salario) to dba;

-- QUESTAO 5
create view MedicosDoQuartoAndar as
  select medico.* from medico, ambulatorio
  where medico.numeroA = ambulatorio.numeroA
  and ambulatorio.andar = 4;

grant select on MedicosDoQuartoAndar to secretaria;


-- QUESTAO 6
create role consultas;

grant select on doenca, cidade to consultas;

create user u1;
create user u2;
grant consultas to u1, u2;
