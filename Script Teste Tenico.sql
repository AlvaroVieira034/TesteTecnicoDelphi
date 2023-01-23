Create Database TesteDelphiWK

-- Tabela USUARIOS

CREATE TABLE pessoa
(
  idpessoa       INT	PRIMARY KEY IDENTITY(1,1),
  flnatureza     INT NOT NULL,
  dsdocumento    VARCHAR(20), 
  nmprimeiro     VARCHAR(100), 
  nmsegundo      VARCHAR(100),
  dtregistro     DATETIME,
);

INSERT INTO pessoa (flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro) values (1,'12345678901','ALVARO', 'VIEIRA', '08/01/2023')
INSERT INTO pessoa (flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro) values (2,'64238959000142', 'AMV', 'INFORMATICA','08/01/2023')

CREATE TABLE endereco
(
  idendereco     INT PRIMARY KEY IDENTITY(1,1),
  idpessoa       INT NOT NULl,
  dscep          VARCHAR(15) NOT NULL,
  CONSTRAINT endereco_fk_pessoa FOREIGN KEY (idpessoa) REFERENCES pessoa(idpessoa) ON DELETE cascade
);

INSERT INTO endereco (idpessoa, dscep) values (1,'34004645')
INSERT INTO endereco (idpessoa, dscep) values (1,'30112010')
INSERT INTO endereco (idpessoa, dscep) values (2,'30112010')


CREATE TABLE endereco_integracao (
  idendereco INT NOT NULL,
  dsuf varchar(50) NULL,
  nmcidade VARCHAR(100) NULL,
  nmbairro varchar(50) NULL,
  nmlogradouro varchar(100) NULL,
  dscomplemento varchar(100) NULL,
  CONSTRAINT enderecointegracao_ok_ PRIMARY KEY (idendereco),
  CONSTRAINT enderecointegracao_fk_endereco FOREIGN KEY (idendereco) REFERENCES endereco(idendereco) ON DELETE cascade 
);

INSERT INTO endereco_integracao (idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento ) 
values (1,'MINAS GERAIS', 'NOVA LIMA', 'PAU POMBO', 'RUA MANOEL MOREIRA DA SILVA, 70', 'APTO 202 - BLOCO2')

INSERT INTO endereco_integracao (idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento ) 
values (2,'MINAS GERAIS', 'BELO HORIZONTE', 'SAVASSI', 'RUA ANTONIO DE ALBUQUERQUE, 377', 'SALA 6')

INSERT INTO endereco_integracao (idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento ) 
values (3,'MINAS GERAIS', 'BELO HORIZONTE', 'SAVASSI', 'RUA ANTONIO DE ALBUQUERQUE, 377', 'SALA 6')



