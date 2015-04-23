-- Ville
INSERT INTO Ville (code_postal_ville, nom_ville) VALUES
	('75000', 'Paris'),
	('31000', 'Toulouse'),
	('69000', 'Lyon'),
	('13000', 'Marseille')
;

-- Lieu
INSERT INTO Lieu (nom_lieu, adresse_lieu, code_postal_ville) VALUES 
	('Théâtre de la main d\'or', '15 Passage de la Main d\'Or', '75000'),
	('Palais Omnisports de Paris Bercy', '8 Boulevard de Bercy', '75000'),
	('Hippodrome de Longchamp', '2 Route des Tribunes', '75000')
;