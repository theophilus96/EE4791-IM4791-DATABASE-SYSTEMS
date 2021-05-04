CREATE TABLE IF NOT EXISTS `Artist` (
  `Artist_id` int(10) NOT NULL AUTO_INCREMENT,
  `Artist_name` varchar(50) NOT NULL,
  `contact_number` int(12) NOT NULL,
  PRIMARY KEY (`Artist_id`)
);
INSERT INTO `Artist` (`Artist_id`, `Artist_name`, `contact_number`) VALUES
  ('1', 'Andy Warhol', '94567895'),
  ('2', 'Pablo Picasso', '84356485'),
  ('3', 'Vincent van Gogh', '92134956'),
  ('4', 'Leonardo da Vinci', '98234512'),
  ('5', 'Michelangelo', '97843256'),
  ('6', 'Henri Matisse', '89532456'),
  ('7', 'Jackson Pollock', '92374524'),
  ('8', 'Edvard Munch', '84312211'),
  ('9', 'Claude Monet', '85334422'),
  ('10', 'Rene Magritte', '89955644');



CREATE TABLE IF NOT EXISTS `Art` (
  `Art_id` int(10) NOT NULL AUTO_INCREMENT,
  `Artist_id` int(10) NOT NULL,
  `Art_name` varchar(50) NOT NULL,
  PRIMARY KEY (`Art_id`),
  FOREIGN KEY (`Artist_id`) REFERENCES `Artist`(`Artist_id`)
);

INSERT INTO `Art` (`Art_id`, `Artist_id`, `Art_name`) VALUES
  ('1', '2', 'The Weeping Woman'),
  ('2', ' 3', 'The Starry Night'),
  ('3', '3', 'Sunflowers'),
  ('4', '4', 'Mona Lisa'),
  ('5', '4', 'The Last Supper'),
  ('6', '4', 'Salvator Mundi'),
  ('7', '5', 'David of Michelangelo'),
  ('8', '5', 'The Creation of Adam'),
  ('9', '9', 'Impression, Sunrise'),
  ('10', '9', 'Woman with a Parasol - Madame Monet and Her Son');


CREATE TABLE IF NOT EXISTS `Gallery` (
  `Gallery_id` int(10) NOT NULL AUTO_INCREMENT,
  `Gallery_name` varchar(50) NOT NULL,
  `Location` varchar(50) NOT NULL,
  PRIMARY KEY (`Gallery_id`)
);

INSERT INTO `Gallery` (`Gallery_id`, `Gallery_name`, `Location`) VALUES
  ('1', 'Louvre Museum', 'Paris, France'),
  ('2', ' The National Gallery', 'London, England'),
  ('3', 'The Metropolitan Museum of Art', 'New York City, USA'),
  ('4', 'Museo Nacional del Prado', 'Madrid,  Spain'),
  ('5', 'Rijksmuseum', 'Amsterdam, Netherlands'),
  ('6', 'State Hermitage Museum', 'Saint Petersburg, Russia');


CREATE TABLE IF NOT EXISTS `Art_Gallery` (
  `Art_Gallery_id` int(10) NOT NULL AUTO_INCREMENT,
  `Art_id` int(10) NOT NULL,
  `Gallery_id` int(10) NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`Art_Gallery_id`),
  FOREIGN KEY (`Art_id`) REFERENCES `Art`(`Art_id`),
  FOREIGN KEY (`Gallery_id`) REFERENCES `Gallery`(`Gallery_id`)
);


INSERT INTO `Art_Gallery` (`Art_Gallery_id`, `Art_id`, `Gallery_id`, `Date`) VALUES
  ('1', '3', '2', '2008-03-18'),
  ('2', '4', '1', '2010-02-12'),
  ('3', '1', '3', '2016-06-16'),
  ('4', '2', '4', '2019-07-11'),
  ('5', '5', '5', '2020-05-2');


CREATE TABLE IF NOT EXISTS `Employee` (
  `Employee_id` int(10) NOT NULL AUTO_INCREMENT,
  `Employee_name` varchar(50) NOT NULL,
  `contact_number` int(12) NOT NULL,
  PRIMARY KEY (`Employee_id`)
);


INSERT INTO `Employee` (`Employee_id`, `Employee_name`, `contact_number`) VALUES
  ('1', 'Bing Hui','91234567'),
  ('2', 'Theo','91234568'),
  ('3', 'Michael','91234569'),
  ('4', 'Jordan','91234570'),
  ('5', 'Lebron','91234571'),
  ('6', 'James','912345572'),
  ('7', 'Kobe','91234573'),
  ('8', 'Bryant','91234574'),
  ('9', 'Stephen','91234575'),
  ('10', 'Dwayne','91234576');


CREATE TABLE IF NOT EXISTS `Customer` (
  `Customer_id` int(10) NOT NULL AUTO_INCREMENT,
  `Customer_name` varchar(50) NOT NULL,
  `Contact_number` Int(10) NOT NULL,
  PRIMARY KEY (`Customer_id`)
);


INSERT INTO `Customer` (`Customer_id`, `Customer_name`, `Contact_number`) VALUES
  ('1', 'Adam', '99949995'),
  ('2', 'Eve', '99969997'),
  ('3', 'Lionel', '99912345'),
  ('4', 'Daniel', '99912346'),
  ('5', 'Abigail', '99912347'),
  ('6', 'Shannon', '99912348'),
  ('7', 'Serena', '99912349'),
  ('8', 'Godfrey', '99923456'),
  ('9', 'Haley', '99923457'),
  ('10', 'Louie', '99923458');



CREATE TABLE IF NOT EXISTS `Order` (
  `Order_id` int(10) NOT NULL AUTO_INCREMENT,
  `Art_id` int(10) NOT NULL,
  `Customer_id` int(10) NOT NULL,
  `Employee_id` int(10) NOT NULL,
  `Price` decimal(12,2) NOT NULL,
  PRIMARY KEY (`Order_id`),
  FOREIGN KEY (`Art_id`) REFERENCES `Art`(`Art_id`),
  FOREIGN KEY (`Customer_id`) REFERENCES `Customer`(`Customer_id`),
  FOREIGN KEY (`Employee_id`) REFERENCES `Employee`(`Employee_id`)
);


INSERT INTO `Order` (`Order_id`, `Art_id`, `Customer_id`, `Employee_id`, `Price`) VALUES
  ('1', '9', '1', '1', '110700000.00'),
  ('2', '10', '2', '2', '90000000.00'),
  ('3', '8', '3', '3', '100000000.5'),
  ('4', '7', '4', '4', '12000000.2'),
  ('5', '6', '5', '1', '30000000.3');
