--------+--------------------+-------+----------
Acidente(IdAcidente, VinculoPrevidencia, Tipo, NumeroBilheteSeguradora, SerieBilheteSeguradora, CBOREmpresa, #IdInternacao, #CNPJSeguradora, #CNPJEmpregadora)

Bairro(IdBairro, Nome, #CodigoMunicipioIBGE)

cidcausas(#Cid, #IdInternacao)

cidsecundario(#Cid, #IdInternacao)


clinica(CodigoClinica, Nome)

doenca(Cid, Descricao)

empregadora(CNPJ, CNAE, Nome)

estabelecimento(CNES, Nome)

estadofederativo(CodigoUFIBGE, Nome)

exame(IdExame, Tipo, Resultado)

examesdainternacao(#IdExame, #IdInternacao)

internacao(IdInternacao, DataAutorizacao, NumeroAutorizacao, CodigoOrgaoEmissorAutorizacao, Condicoes, DiagnosticoInicial, Carater, SinaisESintomas, DataSolicitacaoProcedimento, #IdPaciente, #Cid, #CodigoProcedimento, #IdProfissionalSolicitante, #CNESSolicitante, #CNESExecutor, #IdProfissionalAutorizador, #CodigoClinicaProcedimento)

logradouro(CEP, Nome, #IdBairro)

municipio(CodigoMunicipioIBGE, Nome, #CodigoUFIBGE)

paciente(IdPaciente, Nome, Sexo, Raca, Etnia, Teletone, TelefoneExtra, NomeResponsavel, DataNascimento, CNS, NumeroProntuario, NomeMae, NumeroResidencia, ComplementoResidencia, #CEP)

procedimento(CodigoProcedimento, Descricao)

profissional(IdProfissional, Nome, TipoDocumento, NumeroRegistroConselho, NumeroDocumento)

seguradora(CNPJ, Nome)
