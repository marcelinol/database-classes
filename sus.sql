-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Bairro (
IdBairro VARCHAR(10) PRIMARY KEY,
Nome VARCHAR(10),
CodigoIBGE INTEGER
)

CREATE TABLE Municipio (
Nome VARCHAR(30),
CodigoIBGE INTEGER PRIMARY KEY,
IdEstadoFederativo INTEGER
)

CREATE TABLE EstadoFederativo (
IdEstadoFederativo INTEGER PRIMARY KEY,
Nome VARCHAR(10)
)

CREATE TABLE Clinica (
Nome VARCHAR(10),
CodigoClinica VARCHAR(10) PRIMARY KEY
)

CREATE TABLE Exame (
IdExame INTEGER PRIMARY KEY,
Tipo VARCHAR(10),
Resultado VARCHAR(10)
)

CREATE TABLE Doenca (
Descricao VARCHAR(10),
Cid VARCHAR(10) PRIMARY KEY
)

CREATE TABLE Logradouro (
CEP INTEGER PRIMARY KEY,
Nome VARCHAR(10),
IdBairro VARCHAR(10),
FOREIGN KEY(IdBairro) REFERENCES Bairro (IdBairro)
)

CREATE TABLE Profissional (
Nome VARCHAR(10),
TipoDocumento VARCHAR(10),
NumeroRegistroConselho INTEGER,
NumeroDocumento INTEGER,
IdProfissional INTEGER PRIMARY KEY
)

CREATE TABLE Seguradora (
CNPJ NUMERIC(14) PRIMARY KEY
)

CREATE TABLE Empregadora (
CNPJ NUMERIC(14) PRIMARY KEY,
CNAE VARCHAR(10)
)

CREATE TABLE Acidente (
IdAcidente VARCHAR(10) PRIMARY KEY,
VinculoPrevidencia VARCHAR(10),
Tipo VARCHAR(10),
NumeroBilheteSeguradora VARCHAR(10),
SerieBilheteSeguradora VARCHAR(10),
CBOREmpresa VARCHAR(10),
IdInternacao INTEGER,
CNPJSeguradora NUMERIC(14),
CNPJEmpregadora NUMERIC(14),
FOREIGN KEY(CNPJSeguradora) REFERENCES Seguradora (CNPJ),
FOREIGN KEY(CNPJEmpregadora) REFERENCES Empregadora (CNPJ)
)

CREATE TABLE Paciente (
Nome VARCHAR(10),
Sexo VARCHAR(10),
Raca VARCHAR(10),
Etnia VARCHAR(10),
TelefoneExtra VARCHAR(10),
NomeResponsavel VARCHAR(10),
Telefone INTEGER,
DataNascimento SMALLDATETIME,
IdPaciente BIGINT(10) PRIMARY KEY,
CNS INTEGER,
NumeroProntuario INTEGER,
NomeMae VARCHAR(10),
NumeroResidencia VARCHAR(10),
ComplementoResidencia VARCHAR(10),
CEP INTEGER,
FOREIGN KEY(CEP) REFERENCES Logradouro (CEP)
)

CREATE TABLE Estabelecimento (
CNES VARCHAR(10) PRIMARY KEY
)

CREATE TABLE ExamesDaInternacao (
IdInternacao INTEGER,
IdExame INTEGER,
FOREIGN KEY(IdExame) REFERENCES Exame (IdExame)
)

CREATE TABLE CidSecundario (
Cid VARCHAR(10),
IdInternacao INTEGER,
FOREIGN KEY(Cid) REFERENCES Doenca (Cid)
)

CREATE TABLE CidCausas (
Cid VARCHAR(10),
IdInternacao INTEGER,
FOREIGN KEY(Cid) REFERENCES Doenca (Cid)
)

CREATE TABLE Procedimento (
CodigoProcedimento VARCHAR(10) PRIMARY KEY,
Descricao VARCHAR(10),
CodigoClinica VARCHAR(10),
IdProfissional INTEGER,
FOREIGN KEY(CodigoClinica) REFERENCES Clinica (CodigoClinica),
FOREIGN KEY(IdProfissional) REFERENCES Profissional (IdProfissional)
)

CREATE TABLE AutorizacaoInternacao (
Data VARCHAR(10),
NumeroAutorizacao INTEGER,
CodigoOrgaoEmissor VARCHAR(10),
Condicoes VARCHAR(10),
IdInternacao INTEGER,
DiagnosticoInicial VARCHAR(10),
Carater VARCHAR(10),
SinaisESintomas VARCHAR(10),
DataSolicitacaoProcedimento VARCHAR(10),
IdPaciente BIGINT(10),
Cid VARCHAR(10),
CodigoProcedimento VARCHAR(10),
IdProfissional INTEGER,
CNESSolicitante VARCHAR(10),
CNESExecutor VARCHAR(10),
PRIMARY KEY(NumeroAutorizacao,IdInternacao),
FOREIGN KEY(IdPaciente) REFERENCES Paciente (IdPaciente),
FOREIGN KEY(Cid) REFERENCES Doenca (Cid),
FOREIGN KEY(CodigoProcedimento) REFERENCES Procedimento (CodigoProcedimento),
FOREIGN KEY(IdProfissional) REFERENCES Profissional (IdProfissional),
FOREIGN KEY(CNESSolicitante) REFERENCES Estabelecimento (CNES),
FOREIGN KEY(CNESExecutor) REFERENCES Estabelecimento (CNES)
)

ALTER TABLE Bairro ADD FOREIGN KEY(CodigoIBGE) REFERENCES Municipio (CodigoIBGE)
ALTER TABLE Municipio ADD FOREIGN KEY(IdEstadoFederativo) REFERENCES EstadoFederativo (IdEstadoFederativo)
ALTER TABLE Acidente ADD FOREIGN KEY(NumeroAutorizacao,IdInternacao) REFERENCES AutorizacaoInternacao (NumeroAutorizacao,IdInternacao)
