-- MySQL Script generated by MySQL Workbench
-- Tue Sep 11 19:44:33 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_usuario` (
  `tu_cod` INT NOT NULL AUTO_INCREMENT,
  `tu_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tu_cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `usu_cod` INT NOT NULL AUTO_INCREMENT,
  `usu_email` VARCHAR(45) NOT NULL,
  `usu_senha` VARCHAR(45) NOT NULL,
  `tu_cod` INT NOT NULL,
  PRIMARY KEY (`usu_cod`),
  INDEX `fk_usuario_tipo_usuario1_idx` (`tu_cod` ASC),
  CONSTRAINT `fk_usuario_tipo_usuario1`
    FOREIGN KEY (`tu_cod`)
    REFERENCES `mydb`.`tipo_usuario` (`tu_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professor` (
  `pro_cod` INT NOT NULL AUTO_INCREMENT,
  `pro_nome` VARCHAR(45) NOT NULL,
  `pro_siape` INT NOT NULL,
  `pro_formacao` VARCHAR(70) NOT NULL,
  `usu_cod` INT NULL,
  PRIMARY KEY (`pro_cod`),
  INDEX `fk_professor_usuario1_idx` (`usu_cod` ASC),
  CONSTRAINT `fk_professor_usuario1`
    FOREIGN KEY (`usu_cod`)
    REFERENCES `mydb`.`usuario` (`usu_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_ativ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_ativ` (
  `ta_cod` INT NOT NULL AUTO_INCREMENT,
  `ta_nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ta_cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ativ_complementares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ativ_complementares` (
  `atv_cod` INT NOT NULL AUTO_INCREMENT,
  `atv_desc` VARCHAR(100) NULL DEFAULT NULL,
  `ta_cod` INT NOT NULL,
  `pro_cod` INT NOT NULL,
  PRIMARY KEY (`atv_cod`),
  INDEX `fk_ativ_complementares_tipo_ativ1_idx` (`ta_cod` ASC),
  INDEX `fk_ativ_complementares_professor1_idx` (`pro_cod` ASC),
  CONSTRAINT `fk_ativ_complementares_tipo_ativ1`
    FOREIGN KEY (`ta_cod`)
    REFERENCES `mydb`.`tipo_ativ` (`ta_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ativ_complementares_professor1`
    FOREIGN KEY (`pro_cod`)
    REFERENCES `mydb`.`professor` (`pro_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_projeto` (
  `tp_cod` INT NOT NULL AUTO_INCREMENT,
  `tp_nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tp_cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`projeto` (
  `proj_cod` INT NOT NULL AUTO_INCREMENT,
  `tp_cod` INT NOT NULL,
  `pro_cod` INT NOT NULL,
  `proj_status` VARCHAR(45) NOT NULL,
  `proj_numero` INT NULL DEFAULT NULL,
  `proj_data_ini` DATE NULL DEFAULT NULL,
  `proj_data_fim` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`proj_cod`),
  INDEX `fk_projeto_tipo_projeto1_idx` (`tp_cod` ASC),
  INDEX `fk_projeto_professor1_idx` (`pro_cod` ASC),
  CONSTRAINT `fk_projeto_tipo_projeto1`
    FOREIGN KEY (`tp_cod`)
    REFERENCES `mydb`.`tipo_projeto` (`tp_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projeto_professor1`
    FOREIGN KEY (`pro_cod`)
    REFERENCES `mydb`.`professor` (`pro_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`nivel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`nivel` (
  `niv_cod` INT NOT NULL AUTO_INCREMENT,
  `niv_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`niv_cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
  `cur_cod` INT NOT NULL AUTO_INCREMENT,
  `cur_nome` VARCHAR(45) NOT NULL,
  `cur_hrtotal` INT NOT NULL,
  `niv_cod` INT NOT NULL,
  PRIMARY KEY (`cur_cod`),
  INDEX `fk_curso_nivel1_idx` (`niv_cod` ASC),
  CONSTRAINT `fk_curso_nivel1`
    FOREIGN KEY (`niv_cod`)
    REFERENCES `mydb`.`nivel` (`niv_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ppc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`matriz` (
  `mat_cod` INT NOT NULL AUTO_INCREMENT,
  `mat_info` VARCHAR(45) NOT NULL,
  `cur_cod` INT NOT NULL,
  PRIMARY KEY (`mat_cod`),
  INDEX `fk_ppc_curso1_idx` (`cur_cod` ASC),
  CONSTRAINT `fk_ppc_curso1`
    FOREIGN KEY (`cur_cod`)
    REFERENCES `mydb`.`curso` (`cur_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`serie` (
  `ser_cod` INT NOT NULL AUTO_INCREMENT,
  `ser_modulo` VARCHAR(45) NOT NULL,
  `ser_ano` INT NOT NULL,
  `mat_cod` INT NOT NULL,
  PRIMARY KEY (`ser_cod`),
  INDEX `fk_serie_ppc1_idx` (`mat_cod` ASC),
  CONSTRAINT `fk_serie_ppc1`
    FOREIGN KEY (`mat_cod`)
    REFERENCES `mydb`.`matriz` (`mat_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplina` (
  `dis_cod` INT NOT NULL AUTO_INCREMENT,
  `dis_nome` VARCHAR(45) NOT NULL,
  `dis_carga` INT NOT NULL,
  `dis_ementa` VARCHAR(150) NOT NULL,
  `dis_referencias` VARCHAR(150) NOT NULL,
  `ser_cod` INT NOT NULL,
  PRIMARY KEY (`dis_cod`),
  INDEX `fk_disciplina_serie1_idx` (`ser_cod` ASC),
  CONSTRAINT `fk_disciplina_serie1`
    FOREIGN KEY (`ser_cod`)
    REFERENCES `mydb`.`serie` (`ser_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bloco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bloco` (
  `blo_cod` INT NOT NULL AUTO_INCREMENT,
  `blo_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`blo_cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sala` (
  `sal_cod` INT NOT NULL AUTO_INCREMENT,
  `sal_desc` VARCHAR(45) NOT NULL,
  `dis_cod` INT NULL DEFAULT NULL,
  `blo_cod` INT NOT NULL,
  PRIMARY KEY (`sal_cod`),
  INDEX `fk_sala_disciplina1_idx` (`dis_cod` ASC),
  INDEX `fk_sala_bloco1_idx` (`blo_cod` ASC),
  CONSTRAINT `fk_sala_disciplina1`
    FOREIGN KEY (`dis_cod`)
    REFERENCES `mydb`.`disciplina` (`dis_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sala_bloco1`
    FOREIGN KEY (`blo_cod`)
    REFERENCES `mydb`.`bloco` (`blo_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`turma` (
  `tur_cod` INT NOT NULL AUTO_INCREMENT,
  `tur_nome` VARCHAR(45) NOT NULL,
  `tur_ano` VARCHAR(45) NOT NULL,
  `mat_cod` INT NOT NULL,
  PRIMARY KEY (`tur_cod`),
  INDEX `fk_turma_ppc1_idx` (`mat_cod` ASC),
  CONSTRAINT `fk_turma_ppc1`
    FOREIGN KEY (`mat_cod`)
    REFERENCES `mydb`.`matriz` (`mat_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dia_semana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dia_semana` (
  `ds_cod` INT NOT NULL AUTO_INCREMENT,
  `ds_nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ds_cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hora_aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`horario` (
  `hor_cod` INT NOT NULL AUTO_INCREMENT,
  `hor_periodo` INT NOT NULL,
  `ds_cod` INT NOT NULL,
  PRIMARY KEY (`hor_cod`),
  INDEX `fk_aula_dia_semana1_idx` (`ds_cod` ASC),
  CONSTRAINT `fk_aula_dia_semana1`
    FOREIGN KEY (`ds_cod`)
    REFERENCES `mydb`.`dia_semana` (`ds_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`serie_has_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`serie_has_turma` (
  `ser_cod` INT NOT NULL,
  `tur_cod` INT NOT NULL,
  PRIMARY KEY (`ser_cod`, `tur_cod`),
  INDEX `fk_serie_has_turma_turma1_idx` (`tur_cod` ASC),
  INDEX `fk_serie_has_turma_serie1_idx` (`ser_cod` ASC),
  CONSTRAINT `fk_serie_has_turma_serie1`
    FOREIGN KEY (`ser_cod`)
    REFERENCES `mydb`.`serie` (`ser_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_serie_has_turma_turma1`
    FOREIGN KEY (`tur_cod`)
    REFERENCES `mydb`.`turma` (`tur_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professor_has_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professor_has_disciplina` (
  `pd_cod` INT NOT NULL AUTO_INCREMENT,
  `dis_cod` INT NOT NULL,
  `pro_cod` INT NOT NULL,
  PRIMARY KEY (`pd_cod`),
  INDEX `fk_professor_has_disciplina_disciplina1_idx` (`dis_cod` ASC),
  INDEX `fk_professor_has_disciplina_professor1_idx` (`pro_cod` ASC),
  CONSTRAINT `fk_professor_has_disciplina_disciplina1`
    FOREIGN KEY (`dis_cod`)
    REFERENCES `mydb`.`disciplina` (`dis_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_disciplina_professor1`
    FOREIGN KEY (`pro_cod`)
    REFERENCES `mydb`.`professor` (`pro_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`oferta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`oferta` (
  `ofe_cod` INT NOT NULL AUTO_INCREMENT,
  `ser_cod` INT NOT NULL,
  `tur_cod` INT NOT NULL,
  `pd_cod` INT NOT NULL,
  `ofe_ano` INT NULL DEFAULT NULL,
  INDEX `fk_professor_has_disciplina_has_serie_has_turma_serie_has_t_idx` (`ser_cod` ASC, `tur_cod` ASC),
  PRIMARY KEY (`ofe_cod`),
  INDEX `fk_oferta_professor_has_disciplina1_idx` (`pd_cod` ASC),
  CONSTRAINT `fk_professor_has_disciplina_has_serie_has_turma_serie_has_tur1`
    FOREIGN KEY (`ser_cod` , `tur_cod`)
    REFERENCES `mydb`.`serie_has_turma` (`ser_cod` , `tur_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_oferta_professor_has_disciplina1`
    FOREIGN KEY (`pd_cod`)
    REFERENCES `mydb`.`professor_has_disciplina` (`pd_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aula` (
  `aula_cod` INT NOT NULL AUTO_INCREMENT,
  `aula_status` VARCHAR(45) NOT NULL,
  `sal_cod` INT NOT NULL,
  `hor_cod` INT NOT NULL,
  `ofe_cod` INT NOT NULL,
  INDEX `fk_aula_sala1_idx` (`sal_cod` ASC),
  PRIMARY KEY (`aula_cod`),
  INDEX `fk_horário_aula1_idx` (`hor_cod` ASC),
  INDEX `fk_horario_Oferta1_idx` (`ofe_cod` ASC),
  CONSTRAINT `fk_aula_sala1`
    FOREIGN KEY (`sal_cod`)
    REFERENCES `mydb`.`sala` (`sal_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horário_aula1`
    FOREIGN KEY (`hor_cod`)
    REFERENCES `mydb`.`horario` (`hor_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_Oferta1`
    FOREIGN KEY (`ofe_cod`)
    REFERENCES `mydb`.`oferta` (`ofe_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hora_projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hora_projeto` (
  `hp_cod` INT NOT NULL AUTO_INCREMENT,
  `proj_cod` INT NOT NULL,
  `hor_cod` INT NOT NULL,
  INDEX `fk_hora_projeto_projeto1_idx` (`proj_cod` ASC),
  PRIMARY KEY (`hp_cod`),
  INDEX `fk_hora_projeto_hora_aula1_idx` (`hor_cod` ASC),
  CONSTRAINT `fk_hora_projeto_projeto1`
    FOREIGN KEY (`proj_cod`)
    REFERENCES `mydb`.`projeto` (`proj_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hora_projeto_hora_aula1`
    FOREIGN KEY (`hor_cod`)
    REFERENCES `mydb`.`horario` (`hor_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hora_ativ_comp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hora_ativ_comp` (
  `hac_cod` INT NOT NULL AUTO_INCREMENT,
  `atv_cod` INT NOT NULL,
  `hor_cod` INT NOT NULL,
  PRIMARY KEY (`hac_cod`),
  INDEX `fk_hora_ativ_ativ_complementares1_idx` (`atv_cod` ASC),
  INDEX `fk_hora_ativ_hora_aula1_idx` (`hor_cod` ASC),
  CONSTRAINT `fk_hora_ativ_ativ_complementares1`
    FOREIGN KEY (`atv_cod`)
    REFERENCES `mydb`.`ativ_complementares` (`atv_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hora_ativ_hora_aula1`
    FOREIGN KEY (`hor_cod`)
    REFERENCES `mydb`.`horario` (`hor_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pde` (
  `pde_cod` INT NOT NULL AUTO_INCREMENT,
  `pde_carga` INT NOT NULL,
  `ofe_cod` INT NOT NULL,
  `pde_conteudo` VARCHAR(150) NOT NULL,
  `pde_objetivos` VARCHAR(150) NOT NULL,
  `pde_ementa` VARCHAR(150) NOT NULL,
  `pde_propostadeaulas` VARCHAR(150) NOT NULL,
  `pde_procedimentos` VARCHAR(150) NOT NULL,
  `pde_avaliacoes` VARCHAR(150) NULL DEFAULT NULL,
  `pde_referencias` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`pde_cod`),
  INDEX `fk_Plano_ensino_Oferta1_idx` (`ofe_cod` ASC),
  CONSTRAINT `fk_Plano_ensino_Oferta1`
    FOREIGN KEY (`ofe_cod`)
    REFERENCES `mydb`.`oferta` (`ofe_cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
