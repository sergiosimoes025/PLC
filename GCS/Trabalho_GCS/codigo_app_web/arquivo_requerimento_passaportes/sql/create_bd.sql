-- phpMyAdmin SQL Dump
-- version 4.2.5
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Jan 26, 2015 at 02:58 AM
-- Server version: 5.5.38
-- PHP Version: 5.5.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `ARP`
--

-- --------------------------------------------------------

--
-- Table structure for table `Acompanhante`
--

CREATE TABLE `Acompanhante` (
`id` int(11) NOT NULL,
  `num_processo` varchar(100) NOT NULL,
  `nome_acompanhante` text NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `relacao` text,
  `Entidade_bi` int(11) NOT NULL,
  `Processo_num_processo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Destino_Entidade`
--

CREATE TABLE `Destino_Entidade` (
`id` int(11) NOT NULL,
  `pais` text,
  `cidade` text,
  `data_prevista_saida` text NOT NULL,
  `profissao_futura` text,
  `local` text,
  `Entidade_bi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Entidade`
--

CREATE TABLE `Entidade` (
  `bi` int(11) NOT NULL,
  `nome` text NOT NULL,
  `freguesia` text NOT NULL,
  `local_nascimento` text NOT NULL,
  `data` date NOT NULL,
  `nome_pai` text,
  `nome_mae` text NOT NULL,
  `conjugue` text,
  `estado_civil` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Habilitacoes_entidade`
--

CREATE TABLE `Habilitacoes_entidade` (
`id` int(11) NOT NULL,
  `profissao` text,
  `habilitacoes` text,
  `local_trabalho` text,
  `Entidade_bi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Processo`
--

CREATE TABLE `Processo` (
  `num_processo` varchar(100) NOT NULL,
  `ano` int(11) NOT NULL,
  `camara` text,
  `data_envio` date NOT NULL,
  `num_passaporte` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Processo_Entidade`
--

CREATE TABLE `Processo_Entidade` (
`id` int(11) NOT NULL,
  `Entidade_bi` int(11) NOT NULL,
  `Processo_num_processo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Acompanhante`
--
ALTER TABLE `Acompanhante`
 ADD PRIMARY KEY (`id`), ADD KEY `Acompanhante_Entidade` (`Entidade_bi`), ADD KEY `Acompanhante_Processo` (`Processo_num_processo`);

--
-- Indexes for table `Destino_Entidade`
--
ALTER TABLE `Destino_Entidade`
 ADD PRIMARY KEY (`id`), ADD KEY `Destino_Entidade_Entidade` (`Entidade_bi`);

--
-- Indexes for table `Entidade`
--
ALTER TABLE `Entidade`
 ADD PRIMARY KEY (`bi`);

--
-- Indexes for table `Habilitacoes_entidade`
--
ALTER TABLE `Habilitacoes_entidade`
 ADD PRIMARY KEY (`id`), ADD KEY `Habilitacoes_entidade_Entidade` (`Entidade_bi`);

--
-- Indexes for table `Processo`
--
ALTER TABLE `Processo`
 ADD PRIMARY KEY (`num_processo`);

--
-- Indexes for table `Processo_Entidade`
--
ALTER TABLE `Processo_Entidade`
 ADD PRIMARY KEY (`id`), ADD KEY `Processo_Entidade_Entidade` (`Entidade_bi`), ADD KEY `Processo_Entidade_Processo` (`Processo_num_processo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Acompanhante`
--
ALTER TABLE `Acompanhante`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Destino_Entidade`
--
ALTER TABLE `Destino_Entidade`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Habilitacoes_entidade`
--
ALTER TABLE `Habilitacoes_entidade`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Processo_Entidade`
--
ALTER TABLE `Processo_Entidade`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Acompanhante`
--
ALTER TABLE `Acompanhante`
ADD CONSTRAINT `Acompanhante_Entidade` FOREIGN KEY (`Entidade_bi`) REFERENCES `Entidade` (`bi`),
ADD CONSTRAINT `Acompanhante_Processo` FOREIGN KEY (`Processo_num_processo`) REFERENCES `Processo` (`num_processo`);

--
-- Constraints for table `Destino_Entidade`
--
ALTER TABLE `Destino_Entidade`
ADD CONSTRAINT `Destino_Entidade_Entidade` FOREIGN KEY (`Entidade_bi`) REFERENCES `Entidade` (`bi`);

--
-- Constraints for table `Habilitacoes_entidade`
--
ALTER TABLE `Habilitacoes_entidade`
ADD CONSTRAINT `Habilitacoes_entidade_Entidade` FOREIGN KEY (`Entidade_bi`) REFERENCES `Entidade` (`bi`);

--
-- Constraints for table `Processo_Entidade`
--
ALTER TABLE `Processo_Entidade`
ADD CONSTRAINT `Processo_Entidade_Entidade` FOREIGN KEY (`Entidade_bi`) REFERENCES `Entidade` (`bi`),
ADD CONSTRAINT `Processo_Entidade_Processo` FOREIGN KEY (`Processo_num_processo`) REFERENCES `Processo` (`num_processo`);
