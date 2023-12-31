CREATE TABLE IF NOT EXISTS `LOG_LOCALIDADE` (
    `LOC_NU` INT PRIMARY KEY,
    `UFE_SG` VARCHAR(255),
    `LOC_NO` VARCHAR(255),
    `CEP` VARCHAR(255),
    `LOC_IN_SIT` VARCHAR(255),
    `LOC_IN_TIPO_LOC` VARCHAR(255),
    `LOC_NU_SUB` INT,
    `LOC_NO_ABREV` VARCHAR(255),
    `MUN_NU` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `LOG_BAIRRO` (
    `BAI_NU` INT PRIMARY KEY,
    `UFE_SG` VARCHAR(255),
    `LOC_NU` INT,
    `BAI_NO` VARCHAR(255),
    `BAI_NO_ABREV` VARCHAR(255),
    `LOG_LOCALIDADE` INT,
    CONSTRAINT fk_LOG_BAIRRO_LOG_LOCALIDADE1 FOREIGN KEY (LOC_NU) REFERENCES LOG_LOCALIDADE (LOC_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_CPC` (
    `CPC_NU` INT PRIMARY KEY,
    `UFE_SG` VARCHAR(255),
    `LOC_NU` INT,
    `CPC_NO` VARCHAR(255),
    `CPC_ENDERECO` VARCHAR(255),
    `CEP` VARCHAR(255),
    CONSTRAINT fk_LOG_CPC_LOG_LOCALIDADE1 FOREIGN KEY (LOC_NU) REFERENCES LOG_LOCALIDADE (LOC_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_FAIXA_BAIRRO`  (
    `BAI_NU` INT,
    `FCB_CEP_INI` VARCHAR(255),
    `FCB_CEP_FIM` VARCHAR(255) PRIMARY KEY,
    CONSTRAINT fk_LOG_FAIXA_BAIRRO_LOG_BAIRRO1 FOREIGN KEY (BAI_NU) REFERENCES LOG_BAIRRO (BAI_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS
  `LOG_FAIXA_CPC` (
    `CPC_NU` int DEFAULT NULL,
    `CPC_INICIAL` varchar(6) DEFAULT NULL,
    `CPC_FINAL` varchar(6) NOT NULL,
    `id` int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id`),
    KEY `fk_LOG_FAIXA_CPC_LOG_CPC1_idx` (`CPC_NU`),
    CONSTRAINT `fk_LOG_FAIXA_CPC_LOG_CPC1` FOREIGN KEY (`CPC_NU`) REFERENCES `LOG_CPC` (`CPC_NU`)
  )

CREATE TABLE IF NOT EXISTS `LOG_FAIXA_LOCALIDADE` (
    `LOC_NU` int DEFAULT NULL,
    `LOC_CEP_INI` char(8) DEFAULT NULL,
    `LOC_TIPO_FAIXA` char(1) DEFAULT NULL,
    `LOC_CEP_FIM` char(8) NOT NULL,
    `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    KEY `fk_LOG_FAIXA_LOCALIDADE_LOG_LOCALIDADE1_idx` (`LOC_NU`),
    CONSTRAINT `fk_LOG_FAIXA_LOCALIDADE_LOG_LOCALIDADE1` FOREIGN KEY (`LOC_NU`) REFERENCES `LOG_LOCALIDADE` (`LOC_NU`)
  );

CREATE TABLE IF NOT EXISTS `LOG_FAIXA_UF` (
    `UFE_SG` VARCHAR(255),
    `UFE_CEP_INI` VARCHAR(255),
    `UFE_CEP_FIM` VARCHAR(255) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS `LOG_FAIXA_UOP` (
    `UOP_NU` INT,
    `FNC_INICIAL` INT,
    `FNC_FINAL` INT PRIMARY KEY,
    CONSTRAINT fk_LOG_FAIXA_UOP_LOG_UNID_OPER1 FOREIGN KEY (UOP_NU) REFERENCES LOG_UNID_OPER (UOP_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_GRANDE_USUARIO` (
    `GRU_NU` INT PRIMARY KEY,
    `UFE_SG` VARCHAR(255),
    `LOC_NU` INT,
    `BAI_NU` INT,
    `LOG_NU` INT,
    `GRU_NO` VARCHAR(255),
    `GRU_ENDERECO` VARCHAR(255),
    `CEP` VARCHAR(255),
    `GRU_NO_ABREV` VARCHAR(255),
    CONSTRAINT fk_LOG_GRANDE_USUARIO_LOG_LOCALIDADE1 FOREIGN KEY (LOC_NU) REFERENCES LOG_LOCALIDADE (LOC_NU) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_LOG_GRANDE_USUARIO_LOG_LOGRADOURO1 FOREIGN KEY (LOG_NU) REFERENCES LOG_LOGRADOURO (LOG_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);



CREATE TABLE IF NOT EXISTS `LOG_LOGRADOURO` (
    `LOG_NU` INT PRIMARY KEY,
    `UFE_SG` VARCHAR(255),
    `LOC_NU` INT,
    `BAI_NU_INI` INT,
    `BAI_NU_FIM` INT,
    `LOG_NO` VARCHAR(255),
    `LOG_COMPLEMENTO` VARCHAR(255),
    `CEP` VARCHAR(255),
    `TLO_TX` VARCHAR(255),
    `LOG_STA_TLO` VARCHAR(255),
    `LOG_NO_ABREV` VARCHAR(255),
    CONSTRAINT fk_LOG_LOGRADOURO_LOG_LOCALIDADE1 FOREIGN KEY (LOC_NU) REFERENCES LOG_LOCALIDADE (LOC_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_NUM_SEC` (
    `LOG_NU` INT PRIMARY KEY,
    `SEC_NU_INI` VARCHAR(255),
    `SEC_NU_FIM` VARCHAR(255),
    `SEC_IN_LADO` VARCHAR(255),
    CONSTRAINT fk_LOG_NUM_SEC_LOG_LOGRADOURO1 FOREIGN KEY (LOG_NU) REFERENCES LOG_LOGRADOURO (LOG_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_UNID_OPER` (
    `UOP_NU` INT PRIMARY KEY,
    `UFE_SG` VARCHAR(255),
    `LOC_NU` INT,
    `BAI_NU` INT,
    `LOG_NU` INT,
    `UOP_NO` VARCHAR(255),
    `UOP_ENDERECO` VARCHAR(255),
    `CEP` VARCHAR(255),
    `UOP_IN_CP` VARCHAR(255),
    `UOP_NO_ABREV` VARCHAR(255),
    CONSTRAINT fk_LOG_UNID_OPER_LOG_LOCALIDADE1 FOREIGN KEY (LOC_NU) REFERENCES LOG_LOCALIDADE (LOC_NU) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_LOG_UNID_OPER_LOG_LOGRADOURO1 FOREIGN KEY (BAI_NU) REFERENCES LOG_LOGRADOURO (LOG_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_VAR_BAI` (
    `BAI_NU` INT,
    `VDB_NU` INT,
    `VDB_TX` VARCHAR(255) PRIMARY KEY,
    CONSTRAINT fk_LOG_VAR_BAI_LOG_BAIRRO1 FOREIGN KEY (BAI_NU) REFERENCES LOG_BAIRRO (BAI_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_VAR_LOC` (
    `LOC_NU` INT,
    `VAL_NU` INT,
    `VAL_TX` VARCHAR(255) PRIMARY KEY,
    CONSTRAINT fk_LOG_VAR_LOC_LOG_LOCALIDADE1 FOREIGN KEY (LOC_NU) REFERENCES LOG_LOCALIDADE (LOC_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `LOG_VAR_LOG` (
    `LOG_NU` INT,
    `VLO_NU` INT,
    `VLO_TX` VARCHAR(255),
    `TLO_TX` VARCHAR(255),
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT fk_LOG_VAR_LOG_LOG_LOGRADOURO1 FOREIGN KEY (LOG_NU) REFERENCES LOG_LOGRADOURO (LOG_NU) ON DELETE NO ACTION ON UPDATE NO ACTION
);