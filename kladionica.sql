CREATE TABLE IF NOT EXISTS `tomic_kladionica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tim1` tinytext NOT NULL,
  `tim2` tinytext NOT NULL,
  `kec` tinytext NOT NULL,
  `x` tinytext NOT NULL,
  `dvojka` tinytext NOT NULL,
  `status` longtext DEFAULT 'Nije Pocelo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `tomic_kladjenja` (
  `igrac` varchar(255) NOT NULL DEFAULT '',
  `imeigraca` longtext DEFAULT NULL,
  `x12` longtext DEFAULT NULL,
  `tekma` int(11) unsigned NOT NULL,
  `ulog` int(11) NOT NULL,
  KEY `tekma` (`tekma`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Ukoliko zelite Kladionica job, ubacite i ovo dole. :) 

INSERT INTO `addon_account` (name, label, shared) VALUES 
  ('society_kladionica','Kladionica',1);

INSERT INTO `datastore` (name, label, shared) VALUES 
  ('society_kladionica','Kladionica',1);

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
  ('society_kladionica','Kladionica',1);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
  ('kladionica', 'Kladionica', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
  ('kladionica', 3, 'boss', 'Sef', 0, '{}', '{}');
