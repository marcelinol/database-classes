-- Luciano Medeiros Marcelino - Matricula UFSC 14101386

CREATE TABLE EstadoFederativo (
  CodigoUFIBGE SMALLINT PRIMARY KEY,
  Nome VARCHAR(25) NOT NULL
);

CREATE TABLE Municipio (
  Nome VARCHAR(40) NOT NULL,
  CodigoMunicipioIBGE BIGINT PRIMARY KEY,
  CodigoUFIBGE SMALLINT NOT NULL,
  FOREIGN KEY(CodigoUFIBGE) REFERENCES EstadoFederativo(CodigoUFIBGE) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Bairro (
  IdBairro SERIAL PRIMARY KEY,
  Nome VARCHAR(30) NOT NULL,
  CodigoMunicipioIBGE BIGINT NOT NULL,
  FOREIGN KEY(CodigoMunicipioIBGE) REFERENCES Municipio(CodigoMunicipioIBGE) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Logradouro (
  CEP VARCHAR(10) PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  IdBairro SERIAL NOT NULL,
  FOREIGN KEY(IdBairro) REFERENCES Bairro (IdBairro) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Exame (
  IdExame SERIAL PRIMARY KEY,
  Resultado TEXT NOT NULL,
  Tipo VARCHAR(20) UNIQUE
);

CREATE TYPE doctype AS ENUM ('cns', 'cpf');
CREATE TABLE Profissional (
  Nome VARCHAR(50) NOT NULL,
  TipoDocumento doctype NOT NULL,
  NumeroRegistroConselho VARCHAR(15) UNIQUE NOT NULL,
  NumeroDocumento VARCHAR(15) UNIQUE NOT NULL,
  IdProfissional SERIAL PRIMARY KEY
);

CREATE TABLE Clinica (
  Nome VARCHAR(30) UNIQUE NOT NULL,
  CodigoClinica SERIAL PRIMARY KEY
);

CREATE TABLE Seguradora (
  CNPJ VARCHAR(14) PRIMARY KEY,
  Nome VARCHAR(30) NOT NULL
);

CREATE TABLE Empregadora (
  CNPJ VARCHAR(14) PRIMARY KEY,
  CNAE VARCHAR(7) NOT NULL,
  Nome VARCHAR(30) NOT NULL
);

CREATE TYPE genero AS ENUM('masculino', 'feminino');
CREATE TABLE Paciente (
  IdPaciente SERIAL PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  Sexo genero NOT NULL,
  Raca VARCHAR(10) NOT NULL,
  Etnia VARCHAR(10) NOT NULL,
  Telefone VARCHAR(13),
  TelefoneExtra VARCHAR(10),
  NomeResponsavel VARCHAR(50),
  DataNascimento DATE NOT NULL,
  CNS VARCHAR(15) NOT NULL,
  NumeroProntuario VARCHAR(20) NOT NULL,
  NomeMae VARCHAR(50),
  NumeroResidencia VARCHAR(10) NOT NULL,
  ComplementoResidencia VARCHAR(20),
  CEP VARCHAR(10) NOT NULL,
  FOREIGN KEY(CEP) REFERENCES Logradouro (CEP) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Doenca (
  Descricao VARCHAR(30),
  Cid VARCHAR(6) PRIMARY KEY
);

CREATE TABLE Procedimento (
  CodigoProcedimento SERIAL PRIMARY KEY,
  Descricao VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Estabelecimento (
  CNES VARCHAR(7) PRIMARY KEY,
  Nome VARCHAR(30)
);

CREATE TABLE Internacao (
  IdInternacao SERIAL,
  DataAutorizacao DATE NOT NULL,
  NumeroAutorizacao VARCHAR(20) UNIQUE NOT NULL,
  CodigoOrgaoEmissorAutorizacao VARCHAR(10) NOT NULL,
  Condicoes TEXT NOT NULL,
  DiagnosticoInicial VARCHAR(30),
  Carater VARCHAR(20) NOT NULL,
  SinaisESintomas TEXT NOT NULL,
  DataSolicitacaoProcedimento DATE NOT NULL,
  IdPaciente SERIAL NOT NULL,
  Cid VARCHAR(6) NOT NULL,
  CodigoProcedimento SERIAL NOT NULL,
  CNESSolicitante VARCHAR(7) NOT NULL,
  CNESExecutor VARCHAR(7) NOT NULL,
  IdProfissionalAutorizador SERIAL NOT NULL,
  IdProfissionalSolicitante SERIAL NOT NULL,
  CodigoClinicaProcedimento SERIAL NOT NULL,
  PRIMARY KEY(IdInternacao),
  FOREIGN KEY(CodigoClinicaProcedimento) REFERENCES Clinica (CodigoClinica)ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdPaciente) REFERENCES Paciente (IdPaciente) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(Cid) REFERENCES Doenca (Cid) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(CodigoProcedimento) REFERENCES Procedimento (CodigoProcedimento) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdProfissionalAutorizador) REFERENCES Profissional (IdProfissional) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdProfissionalSolicitante) REFERENCES Profissional (IdProfissional) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(CNESSolicitante) REFERENCES Estabelecimento (CNES) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(CNESExecutor) REFERENCES Estabelecimento (CNES) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT autorizacao_mais_recente_que_solicitacao CHECK (DataAutorizacao >= DataSolicitacaoProcedimento)
);

CREATE TABLE CidSecundario (
  Cid VARCHAR(6),
  IdInternacao SERIAL,
  PRIMARY KEY(Cid,IdInternacao),
  FOREIGN KEY(Cid) REFERENCES Doenca (Cid),
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE CidCausas (
  Cid VARCHAR(6),
  IdInternacao SERIAL,
  PRIMARY KEY(Cid,IdInternacao),
  FOREIGN KEY(Cid) REFERENCES Doenca (Cid) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE ExamesDaInternacao (
  IdExame SERIAL,
  IdInternacao SERIAL,
  PRIMARY KEY(IdExame, IdInternacao),
  FOREIGN KEY(IdExame) REFERENCES Exame (IdExame) ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TYPE vinculoprev AS ENUM('empregado', 'empregador', 'autonomo', 'desempregado', 'aposentado', 'nao segurado');
CREATE TYPE tipoacidente AS ENUM('transito', 'trabalho tipico', 'trabalho trajeto');
CREATE TABLE Acidente (
  IdAcidente SERIAL PRIMARY KEY,
  VinculoPrevidencia vinculoprev NOT NULL,
  Tipo tipoacidente NOT NULL,
  NumeroBilheteSeguradora VARCHAR(20),
  SerieBilheteSeguradora VARCHAR(20),
  CBOREmpresa VARCHAR(20),
  IdInternacao SERIAL NOT NULL,
  CNPJSeguradora VARCHAR(14),
  CNPJEmpregadora VARCHAR(14),
  FOREIGN KEY(CNPJSeguradora) REFERENCES Seguradora (CNPJ) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY(CNPJEmpregadora) REFERENCES Empregadora (CNPJ) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY(IdInternacao) REFERENCES Internacao (IdInternacao) ON DELETE RESTRICT ON UPDATE RESTRICT
);
