-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

CREATE TABLE EstadoFederativo (
  CodigoUFIBGE SMALLINT PRIMARY KEY,
  Nome VARCHAR(25)
);

CREATE TABLE Municipio (
  Nome VARCHAR(40),
  CodigoMunicipioIBGE BIGINT PRIMARY KEY,
  CodigoUFIBGE SMALLINT,
  FOREIGN KEY(CodigoUFIBGE) REFERENCES EstadoFederativo(CodigoUFIBGE) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Bairro (
  IdBairro SERIAL PRIMARY KEY,
  Nome VARCHAR(30),
  CodigoMunicipioIBGE BIGINT,
  FOREIGN KEY(CodigoMunicipioIBGE) REFERENCES Municipio(CodigoMunicipioIBGE) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Logradouro (
  CEP VARCHAR(10) PRIMARY KEY,
  Nome VARCHAR(50),
  IdBairro SERIAL,
  FOREIGN KEY(IdBairro) REFERENCES Bairro (IdBairro) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Exame (
  IdExame SERIAL PRIMARY KEY,
  Tipo VARCHAR(10),
  Resultado TEXT
);

CREATE TYPE doctype AS ENUM ('cns', 'cpf');
CREATE TABLE Profissional (
  Nome VARCHAR(50),
  TipoDocumento doctype,
  NumeroRegistroConselho VARCHAR(15),
  NumeroDocumento VARCHAR(15),
  IdProfissional SERIAL PRIMARY KEY
);

CREATE TABLE Clinica (
  Nome VARCHAR(30),
  CodigoClinica SERIAL PRIMARY KEY
);

CREATE TABLE Seguradora (
  CNPJ VARCHAR(14) PRIMARY KEY,
  Nome VARCHAR(30)
);

CREATE TABLE Empregadora (
  CNPJ VARCHAR(14) PRIMARY KEY,
  CNAE VARCHAR(7),
  Nome VARCHAR(30)
);

CREATE TYPE genero AS ENUM('masculino', 'feminino');
CREATE TABLE Paciente (
  Nome VARCHAR(50),
  Sexo genero,
  Raca VARCHAR(10),
  Etnia VARCHAR(10),
  TelefoneExtra VARCHAR(10),
  NomeResponsavel VARCHAR(50),
  Telefone VARCHAR(13),
  DataNascimento DATE,
  IdPaciente SERIAL PRIMARY KEY,
  CNS VARCHAR(15),
  NumeroProntuario VARCHAR(20),
  NomeMae VARCHAR(50),
  NumeroResidencia VARCHAR(10),
  ComplementoResidencia VARCHAR(20),
  CEP VARCHAR(10),
  FOREIGN KEY(CEP) REFERENCES Logradouro (CEP) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Doenca (
  Descricao VARCHAR(30),
  Cid VARCHAR(6) PRIMARY KEY
);

CREATE TABLE Procedimento (
  CodigoProcedimento SERIAL PRIMARY KEY,
  Descricao VARCHAR(20),
  CodigoClinica SERIAL,
  IdProfissional SERIAL,
  FOREIGN KEY(CodigoClinica) REFERENCES Clinica (CodigoClinica)ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdProfissional) REFERENCES Profissional (IdProfissional) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Estabelecimento (
  CNES VARCHAR(7) PRIMARY KEY,
  Nome VARCHAR(30)
);

CREATE TABLE Internacao (
  DataAutorizacao DATE,
  NumeroAutorizacao VARCHAR(20),
  CodigoOrgaoEmissorAutorizacao VARCHAR(10),
  Condicoes TEXT,
  IdInternacao SERIAL,
  DiagnosticoInicial VARCHAR(30),
  Carater VARCHAR(20),
  SinaisESintomas TEXT,
  DataSolicitacaoProcedimento DATE,
  IdPaciente SERIAL,
  Cid VARCHAR(6),
  CodigoProcedimento SERIAL,
  IdProfissional SERIAL,
  CNESSolicitante VARCHAR(7),
  CNESExecutor VARCHAR(7),
  PRIMARY KEY(IdInternacao),
  FOREIGN KEY(IdPaciente) REFERENCES Paciente (IdPaciente) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(Cid) REFERENCES Doenca (Cid) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(CodigoProcedimento) REFERENCES Procedimento (CodigoProcedimento) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdProfissional) REFERENCES Profissional (IdProfissional) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(CNESSolicitante) REFERENCES Estabelecimento (CNES) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(CNESExecutor) REFERENCES Estabelecimento (CNES) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE CidSecundario (
  Cid VARCHAR(6),
  IdInternacao INTEGER,
  FOREIGN KEY(Cid) REFERENCES Doenca (Cid),
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE CidCausas (
  Cid VARCHAR(6),
  IdInternacao SERIAL,
  FOREIGN KEY(Cid) REFERENCES Doenca (Cid) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE ExamesDaInternacao (
  IdExame SERIAL,
  IdInternacao SERIAL,
  FOREIGN KEY(IdExame) REFERENCES Exame (IdExame) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TYPE vinculoprev AS ENUM('empregado', 'empregador', 'autonomo', 'desempregado', 'aposentado', 'nao segurado');
CREATE TYPE tipoacidente AS ENUM('transito', 'trabalho tipico', 'trabalho trajeto');
CREATE TABLE Acidente (
  IdAcidente SERIAL PRIMARY KEY,
  VinculoPrevidencia vinculoprev,
  Tipo tipoacidente,
  NumeroBilheteSeguradora VARCHAR(20),
  SerieBilheteSeguradora VARCHAR(20),
  CBOREmpresa VARCHAR(20),
  IdInternacao SERIAL,
  CNPJSeguradora VARCHAR(14),
  CNPJEmpregadora VARCHAR(14),
  FOREIGN KEY(CNPJSeguradora) REFERENCES Seguradora (CNPJ) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY(CNPJEmpregadora) REFERENCES Empregadora (CNPJ) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON DELETE RESTRICT ON UPDATE RESTRICT
);
