Consulta 1: Buscar todos os pacientes residentes em Florianopolis
select paciente.nome as nome_paciente, municipio.nome as nome_municipio from paciente
join logradouro on logradouro.cep = paciente.cep
join bairro on logradouro.idbairro = bairro.idbairro
join municipio on bairro.CodigoMunicipioIBGE = municipio.CodigoMunicipioIBGE
where municipio.nome = 'Florianopolis';


Consulta 2: Contar quantos pacientes existem por cidade
select municipio.nome as nome_municipio, count (paciente.*) from paciente
join logradouro on logradouro.cep = paciente.cep
join bairro on logradouro.idbairro = bairro.idbairro
join municipio on bairro.CodigoMunicipioIBGE = municipio.CodigoMunicipioIBGE
group by municipio.nome;

Consulta 3: Buscar o nome de todas as empresas que tiveram algum funcionário que se acidentou no transito

select empregadora.nome from empregadora
join acidente on acidente.CNPJEmpregadora = empregadora.CNPJ
where acidente.tipo = 'transito';


Consulta 4: Buscar o nome de todos os bairros cadastrados para Santa Catarina

select bairro.nome from bairro
join municipio on bairro.CodigoMunicipioIBGE = municipio.CodigoMunicipioIBGE
join estadofederativo on estadofederativo.CodigoUFIBGE = municipio.CodigoUFIBGE
where estadofederativo.nome = 'Santa Catarina';

Consulta 5: Buscar o nome dos pacientes e a data de solicitacao de procedimento daqueles que foram amputados depois de 2014

select paciente.nome, internacao.DataSolicitacaoProcedimento from paciente
join internacao on paciente.idpaciente = internacao.idpaciente
join procedimento on procedimento.CodigoProcedimento = internacao.CodigoProcedimento
where procedimento.descricao = 'amputacao'
and internacao.DataSolicitacaoProcedimento > '12/31/2014';
