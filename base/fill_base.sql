CREATE OR REPLACE FUNCTION fill_base()
RETURNS VOID AS $$
BEGIN
-- Ville
INSERT INTO Ville (code_postal_ville, nom_ville) VALUES
	(75000, 'Paris'),
	(31000, 'Toulouse'),
	(69000, 'Lyon'),
	(13000, 'Marseille'),
	(67000, 'Strasbourg'),
	(59000, 'Lille'),
	(33000, 'Bordeaux'),
	(06000, 'Cannes');



-- Lieu
INSERT INTO Lieu (nom_lieu, adresse_lieu, code_postal_ville, capacite_lieu) VALUES
       ('Musée Dapper', '35 bis rue Paul-Valéry', 75000, 100),
       ('Musée du Petit Palais', '15 avenue Winston Churchill',13000, 150),
       ('Musee Orsay', '1 rue de la Légion Honneur ', 75000, 500),
       ('Musee du Louvre', '10 Boulevard du Louvre', 75000, 800),
       ('Musee du Quaie Branly','37 Quai Branly', 75000, 400),
       ('Paris Expo', 'Porte de Versailles', 75000, 5000),

       ('La Comédie de Lille', '204 rue de Solférino', 59000, 80),
       ('Comédie-Française', 'Place Colette', 69000, 100),
       ('Théâtre National de Chaillot', '10 rue Duval', 31000, 200),
       ('Théâtre National de la Colline', '15 rue Malte Brun', 13000, 120),
       ('Théâtre National de Odéon', '2 rue Corneille', 75000, 320),	
       ('Théâtre National de Strasbourg', '1 Avenue de la Marseillaise', 67000, 100),

       ('Le palais des Festivals', 'Boulevard de la Croisette', 06000, 1000),
       ('Le palais des Congres', 'Boulevard de Bercy', 75000, 500),
       ('Hippodrome de Longchamp', '5 avenue de la Republic', 75000, 7000),
       ('Hippodrome de Vincennes', '54 rue des chevaux', 75000, 3000),
       ('Hippodrome du Bouscat', '4 rue de la Tour', 59000, 1000),
       ('Parc de la Citadelle', '10 Avenue Mathias Delobel', 13000 ,2000),
       ('Parc Orangerie', '12 Avenue Citron', 67000, 3000),
       ('Prairie des Filtres', '34 rue Toulouse centre', 31000, 25000);



INSERT INTO Membre (nom_membre, prenom_membre, sexe_membre, login_membre, mail_membre, adresse_membre, code_postal_ville) VALUES
       ('Dupont', 'Xavier', 'H', 'Dupont_Xavier', 'dupont.xavier@gmail.com', '3 rue de la sabliere', 75000),
       ('Dupuis', 'Marine', 'F', 'Dupuis_Marine', 'dupuis.marine@gmail.com', '3 rue raymond point carree', 31000),
       ('Charles','Sofiane', 'H', 'Charle_Sofiane', 'Charles.Sofiane@gmail.com', '5 rue Charlemagne', 69000),
       ('Goliate', 'David' , 'H', 'Goliate_David', 'Hurst.David@gmail.com', '10 place de la faisandrie', 13000),
       ('Townsend','Wallace', 'H', 'Townsen_Wallace', 'Townsend.Wallace@gmail.com', '23 bis paul vaillant couturier', 33000),
       ('Saunders','Sabrina', 'F', 'Saunder_Sabrina', 'Saunders.Sabrina@gmail.com', '65 avenue de France' , 59000),
       ('Lancaster','Fatima', 'F', 'Lancaste_Fatima', 'Lancaster.Fatima@gmail.com', '456 boulevard hausseman', 33000),
       ('Kline','Jeanne', 'F', 'Klin_Jeanne', 'Kline.Jeanne@gmail.com', '455 rue du louvres', 59000),
       ('Valentine','Kevin', 'H', 'Valentin_Kevin', 'Valentine.Kevin@gmail.com', '432 rue James Watt', 06000),
       ('Morrow','Alan', 'H', 'Morro_Alan', 'Morrow.Alan@gmail.com', '34 avenue General leclerc', 75000),
       ('Garrison','Mathilda', 'F', 'Garriso_Mathilda', 'Garrison.Mathilda@gmail.com', '99 rue du merle', 13000),
       ('Underwood','John', 'H', 'Underwoo_John', 'Underwood.John@gmail.com', '5 avenue raymond Hemell', 75000),
       ('Stephens','Nadia', 'F', 'Stephen_Nadia', 'Stephens.Nadia@gmail.com', '56 rue duval', 31000),
       ('Shaffer', 'Jack', 'H', 'Shaffer_Jack', 'Shaffer.Jack@gmail.com', '44 avenue du role', 31000),
       ('Stanley','Brandon', 'H', 'Stanle_Brandon', 'Stanley.Brandon@gmail.com', '56 boulevard Duval', 75000),
       ('Valenzuela','Jimmy', 'F' , 'Valenzuel_Jimmy', 'Valenzuela.Jimmy@gmail.com', '17 rue Victor Hugo', 75000),
       ('Mathis','Jason', 'H', 'Mathi_Jason', 'Mathis.Jason@gmail.com', '1 avenue de la republique', 33000),
       ('Powell','Samia', 'F', 'Powel_Samia', 'Powell.Samia@gmail.com', '12 avenue Paul Doumere', 67000),
       ('Norton','Afida', 'F', 'Norto_Afida', 'Norton.Afida@gmail.com', '21 rue Saint Germain', 31000),
       ('Hurley','Farida', 'F', 'Hurle_Farida', 'Hurley.Farida@gmail.com', '87 boulevard Jean Monnet', 13000),
       ('Hunt','Daniel', 'H', 'Hun_Daniel', 'Hunt.Daniel@gmail.com', '442 avenue le Foll', 59000),
       ('Charles','Camelia', 'F', 'Charle_Camelia', 'Charles.Camelia@gmail.com', '676 rue du Lievre', 59000),
       ('Gould','Rachida', 'F', 'Goul_Rachida', 'Gould.Rachida@gmail.com', '23 rue Aristid Brillant', 67000),
       ('Mcdonald','Dominic', 'H', 'Mcdonal_Dominic', 'Mcdonald.Dominic@gmail.com', '90 boulevard Rouget de Lisle', 75000),
       ('Walter','Baxter', 'H', 'Walte_Baxter', 'Walter.Baxter@gmail.com', '10 rue du Président Wilson', 06000),
       ('Osborne','Paula', 'F', 'Osborn_Paula', 'Osborne.Paula@gmail.com', '56 avenue Saint Martin', 75000);



-- Festival
perform create_festival('Festival cinémarges', 13, '10:00:00', 'cinema', 'no', 1);
perform create_festival('Festival des outremers', 14, '10:00:00','culturel', 'no', 1);
perform create_festival('Festival Du Nouveau Cinéma Italien', 13, '10:00:00','cinema' , 'no', 2);
perform create_festival('Festival Paris Tout Court', 16, '10:00:00', 'culturel','yes',2);
perform create_festival('Festival des Chemins de Traverse', 13, '10:00:00', 'culturel', 'no', 2);
perform create_festival('Festival de la Rue', 18, '10:00:00', 'culturel', 'yes', 2);
perform create_festival('Festival de Cannes', 14, '10:00:00', 'cinema' ,'no', 3);
perform create_festival('Festival Solidays', 15, '10:00:00', 'musique', 'yes', 3);
perform create_festival('Festival Rock en Scène', 17, '10:00:00', 'musique', 'yes', 3);
perform create_festival('Festival Rock in Opposition', 18, '10:00:00', 'musique', 'yes', 3);
perform create_festival('Festival International de bande dessinee', 16, '10:00:00', 'musique', 'yes', 3);








-- Piece de Theatre
perform create_piece_theatre('Le bal des Vampire', 7, '00:40:00', 'Comedie Musical', 'Fabien Pascal', 5);
perform create_piece_theatre('Aristo du Coeur', 12, '00:40:00', 'Bulresque', 'Facco Charlotte', 5);
perform create_piece_theatre('Entre pere et fils', 11, '00:40:00', 'Comique', 'Sabourin François', 5);
perform create_piece_theatre('La femme de mouss est partie', 9, '00:40:00', 'Comique', 'Segui Elodie', 5);
perform create_piece_theatre('Tailleur pour Dame', 8, '00:40:00', 'Bulresque', 'Calvo Ernesto', 5);
perform create_piece_theatre('La Bonne Moitié', 10, '00:40:00', 'Comique', 'Pepi Guillaume', 6);
perform create_piece_theatre('La Bonne Planque', 11, '00:40:00', 'Comique', 'Cacheux Fred',6);
perform create_piece_theatre('La Bonne Soupe', 9, '00:40:00', 'Tragedie', 'Lecono Pierre', 6);
perform create_piece_theatre('Britannicus (Racine)', 12, '00:40:00', 'Tragedie', 'Rians Johan', 1);
perform create_piece_theatre('La Brouette du vinaigrier', 8, '00:40:00', 'Bulresque', 'Pellerin Gille', 1);
perform create_piece_theatre('La Brune que voilà', 10, '00:40:00', 'Comedie Romantique', 'Lannister Anne', 1);
perform create_piece_theatre('Le Dédale', 11, '00:40:00', 'Tragedie', 'Stark Daniel', 1);
perform create_piece_theatre('Délire à deux', 12, '00:40:00', 'Vaudeville', 'Salvador Gabriel', 1);
perform create_piece_theatre('Démocrite amoureux', 9, '00:40:00', 'Vaudeville', 'Hanouno Camille', 1);
perform create_piece_theatre('Démocrite prétendu fou', 7, '00:40:00', 'Bulresque', 'Camus Emmanuel', 1);
perform create_piece_theatre('Le Dénouement imprévu', 8, '00:40:00', 'Tragedie', 'Bourdieu Paul', 1);
perform create_piece_theatre('Le Dépit amoureux', 10, '00:40:00', 'Comedie Romantique', 'Callier Lydie', 4);
perform create_piece_theatre('La Dernière Nuit pour Marie Stuart', 11, '00:40:00', 'Comedie Musical', 'Dove attia', 4);
perform create_piece_theatre('Des boulons dans mon yaourt', 8, '00:40:00', 'Comique', 'Gilbert Damien', 4);
perform create_piece_theatre('Des journées entières dans les arbres', 10, '00:40:00', 'Comedie', 'Lecomte  Lucille', 4);
perform create_piece_theatre('Le Déserteur ', 9, '00:40:00', 'Opéra', 'Moya Carlos', 5);







-- Info Exposition
perform create_exposition('Paris Games Week', 6, '24:00:00', 'Jeux', 5);
perform create_exposition('Japan Expo', 6, '10:00:00', 'Culture Japonaise', 5);
perform create_exposition('Expo jean paul gaultier : de la rue aux étoiles', 1, '10:00:00', 'Mode',5);
perform create_exposition('Exposition oracles du design', 2, '10:00:00', 'Design', 6);
perform create_exposition('Le bord des mondes', 3, '10:00:00', 'Peinture', 6);
perform create_exposition('Exposition Felice Varini', 4, '10:00:00', 'Peinture', 6);
perform create_exposition('Exposition Velazquez', 2, '10:00:00', 'Peinture', 6);
perform create_exposition('Exposition Jeff Koons', 3, '10:00:00', 'Musique', 6);
perform create_exposition('Exposition Cuisine du monde ', 1, '10:00:00', 'Cuisine', 6);
perform create_exposition('Exposition De Carmen à mélisande', 5, '10:00:00', 'Architecture', 6);
perform create_exposition('Exposition les cahiers dessinés', 1, '10:00:00', 'Peinture', 6);



--Date Evenement
INSERT INTO Date_Evenement(id_evenement, date_evenement, prix_date_evenement) VALUES
       (12, '2015-01-12 20:30:00', 20),
       (13, '2015-01-12 20:30:00', 22),
       (14, '2015-01-12 20:30:00', 32),
       (15, '2015-01-12 20:30:00', 34),
       (16, '2015-01-12 20:30:00', 50),
       (17, '2015-01-12 20:30:00', 70),
       (18, '2015-01-12 20:30:00', 200),
       (19, '2015-01-12 20:30:00', 160),
       (20, '2015-01-12 20:30:00', 80),
       (21, '2015-01-12 20:30:00', 60),
       (22, '2015-01-12 20:30:00', 55),
       (23, '2015-01-12 20:30:00', 60),
       (24, '2015-01-12 20:30:00', 55),
       (25, '2015-01-12 20:30:00', 50),
       (26, '2015-01-12 20:30:00', 45),
       (27, '2015-01-12 20:30:00', 45),
       (28, '2015-01-12 20:30:00', 140),
       (29, '2015-01-12 20:30:00', 25),
       (30, '2015-01-12 20:30:00', 40),
       (31, '2015-01-12 20:30:00', 30),
       (32, '2015-01-12 20:30:00', 35), --21


       (1, '2015-01-12 10:30:00', 60),
       (2, '2015-01-12 10:30:00', 60),
       (3, '2015-01-12 10:30:00', 60),
       (4, '2015-01-12 10:30:00', 160),
       (5, '2015-01-12 10:30:00', 6),
       (6, '2015-01-12 10:30:00', 30),
       (7, '2015-02-14 10:30:00', 70),
       (8, '2015-06-26 10:30:00', 41),
       (8, '2015-06-27 10:30:00', 51),
       (8, '2015-06-28 10:30:00', 61),
       (9, '2015-04-17 10:30:00', 10),
       (10, '2016-06-22 10:30:00', 9),
       (11, '2016-01-02 10:30:00', 20), --34
       
       (33, '2015-01-12 10:30:00', 22),
       (34, '2015-03-16 10:30:00', 27),
       (35, '2015-06-15 10:30:00', 18),
       (36, '2015-03-23 10:30:00', 12),
       (37, '2015-05-12 10:30:00', 23),
       (38, '2015-01-12 10:30:00', 14),
       (39, '2015-07-30 10:30:00', 15),
       (40, '2015-09-11 10:30:00', 10),
       (41, '2015-10-09 10:30:00', 30),
       (42, '2015-01-03 10:30:00', 20),
       (43, '2015-02-01 10:30:00', 21);





--Animation
INSERT INTO Animation(id_date_evenement, heure_animation, nom_animation, duree_animation) VALUES		
       (35, '2015-01-12 10:30:00', 'Initiation aux art martiaux', '00:40:00'),
       (35, '2015-01-12 10:30:00', 'Demonstration nouveaux jeux', '00:40:00'),		
       (36, '2015-03-16 10:30:00', 'Conférence mangaka', '01:00:00'),
       (36, '2015-03-16 10:30:00', 'Atelier Lecture ', '00:40:00'),
       (37, '2015-06-15 10:30:00', 'Initiation à la Couture', '00:40:00'),		
       (37, '2015-06-15 10:30:00', 'Nouvelles tendances', '00:40:00'),
       (38, '2015-03-23 10:30:00', 'Nouvelles tendances du design', '00:55:00'),
       (39, '2015-05-12 10:30:00', 'Atelier Lecture ', '00:40:00'),
       (39, '2015-05-12 10:30:00', 'Buffet à Volonté', '03:00:00'),
       (40, '2015-01-12 10:30:00', 'Buffet à Volonté', '03:00:00'),
       (40, '2015-01-12 10:30:00', 'Conference Art Abstrait', '00:40:00'),
       (41, '2015-07-30 10:30:00', 'Atelier Peinture PopArt', '00:40:00'),	
       (43, '2015-10-09 10:30:00', 'Labo Culinaire', '00:40:00'),
       (43, '2015-10-09 10:30:00', 'Initiation Cuisine Africaine', '00:40:00'),
       (43, '2015-10-09 10:30:00', 'Atelier Les Coulisses du Chef', '00:40:00'),
       (45, '2015-02-01 10:30:00', 'Buffet à Volonté', '02:00:00'),
       (45, '2015-02-01 10:30:00', 'Atelier Lecture', '00:40:00');



INSERT INTO Concert(id_date_evenement, heure_concert, artiste_concert, duree_concert) VALUES		
       (24, '2015-01-12 10:30:00', 'Maroon Five', '00:40:00'),
       (28, '2015-02-14 10:30:00', 'Mika', '00:40:00'),
       (29, '2015-06-26 10:30:00', 'The Avener', '00:40:00'),
       (29, '2015-06-26 10:30:00', 'Madeon', '00:40:00'),		
       (29, '2015-06-26 10:30:00', 'Clean Bandit', '00:40:00'),
       (30, '2015-06-27 10:30:00', 'Xavier Rudd', '00:40:00'),
       (30, '2015-06-27 10:30:00', 'Tairo', '00:40:00'),
       (31, '2015-06-28 10:30:00', 'Mademoiselle K', '00:55:00'),
       (31, '2015-06-28 10:30:00', 'Moriarty', '00:55:00'),
       (31, '2015-06-28 10:30:00', 'Lilly Wood And The Prick', '00:55:00');



-- Membre



--Reservation

INSERT INTO Reservation(id_membre, id_date_evenement) VALUES
       (26,26),(21,13),(15,15),(16,31),(1,18),(16,39),(7,5),(3,25),(1,7),(16,3),
       (8,43),(8,9),(3,2),(13,15),(1,26),(10,9),(1,39),(23,21),(13,9),(3,8),
       (5,33),(21,40),(18,6),(4,13),(17,4),(1,12),(2,4),(19,1),(10,14),(8,26),
       (26,17),(10,7),(5,1),(7,3),(24,33),(6,28),(5,17),(7,5),(16,23),(19,33),
       (25,5),(13,6),(24,7),(4,35),(19,9),(2,7),(19,13),(25,19),(9,24),(18,10),
       (14,12),(13,33),(10,24),(9,1),(26,13),(16,32),(26,17),(21,13),(12,24),(22,15),
       (25,43),(5,15),(17,5),(19,39),(25,42),(12,8),(10,10),(14,11),(10,20),(20,18),
       (17,33),(16,23),(21,14),(17,25),(23,27),(12,3),(25,36),(16,8),(10,19),(14,42),
       (9,14),(8,30),(2,35),(23,22),(23,36),(14,20),(23,4),(25,41),(21,11),(20,25),
       (5,12),(16,28),(2,9),(5,33),(19,18),(4,7),(4,40),(3,28),(1,26),(3,39),
       (5,26),(18,24),(22,30),(26,8),(1,20),(24,40),(23,4),(12,18),(12,33),(22,21),
       (5,32),(13,28),(16,20),(20,5),(4,9),(14,20),(6,38),(8,21),(5,21),(8,8),
       (20,22),(25,25),(7,37),(18,28),(5,10),(26,40),(15,27),(8,26),(19,25),(21,22),
       (4,10),(15,16),(20,21),(11,9),(5,15),(21,36),(12,15),(22,6),(22,21),(9,39),
       (19,37),(2,31),(7,2),(7,21),(21,39),(24,38),(13,43),(3,2),(26,22),(19,25),
       (17,20),(5,39),(10,17),(2,3),(26,28),(13,40),(16,17),(5,31),(23,3),(3,30),
       (17,8),(10,28),(4,18),(9,12),(15,8),(5,27),(5,16),(13,43),(11,31),(17,2),
       (18,7),(24,34),(12,25),(5,30),(8,9),(15,37),(21,18),(22,31),(6,37),(23,29),
       (12,41),(6,31),(7,15),(10,14),(8,13),(15,43),(17,36),(22,18),(6,28),(26,2),
       (17,29),(5,35),(13,14),(1,24),(9,26),(5,42),(6,31),(12,26),(21,27),(8,20),
       (22,33),(9,4),(22,8),(14,4),(14,29),(13,9),(14,19),(16,1),(14,32),(25,2),
       (25,36),(15,17),(14,38),(15,21),(6,9),(8,15),(20,11),(21,11),(7,18),(15,2),
       (23,10),(22,22),(18,38),(1,22),(18,6),(10,9),(12,41),(5,41),(21,26),(7,11),
       (13,7),(15,41),(4,23),(2,16),(26,40),(6,39),(25,32),(19,1),(4,23),(8,25),
       (19,6),(13,23),(19,10),(16,20),(11,26),(7,38),(6,34),(12,42),(18,5),(21,17),
       (5,11),(25,19),(6,16),(20,25),(23,4),(12,19),(1,5),(14,28),(14,28),(19,9),
       (14,7),(11,23),(21,18),(5,18),(23,32),(15,23),(11,11),(17,1),(13,28),(7,4),
       (23,34),(20,7),(5,8),(16,5),(4,13),(21,17),(1,7),(4,21),(7,36),(13,20),
       (24,9),(11,35),(23,13),(7,28),(17,31),(23,41),(23,5),(22,1),(15,2),(6,4),
       (8,10),(9,31),(12,32),(20,43),(3,7),(7,9),(5,34),(6,10),(22,27),(13,43),
       (22,8),(2,8),(25,13),(7,4),(17,30),(12,13),(10,23),(3,16),(16,36),(14,7),
       (18,1),(13,29),(24,18),(23,22),(11,32),(19,42),(25,17),(20,20),(9,1),(1,3),
       (6,35),(13,8),(2,13),(11,31),(10,32),(25,17),(20,30),(20,2),(5,1),(16,19),
       (3,24),(25,33),(11,15),(25,17),(20,18),(8,26),(7,35),(14,19),(1,37),(16,43),
       (13,38),(19,26),(16,18),(24,39),(9,30),(24,24),(17,20),(16,34),(25,35),(9,28),
       (7,27),(18,33),(14,18),(4,23),(3,5),(4,24),(10,39),(9,25),(9,31),(26,37),
       (8,12),(12,27),(23,9),(12,38),(11,7),(19,10),(4,33),(14,21),(11,2),(19,5),
       (17,35),(6,32),(8,38),(13,12),(15,1),(2,40),(20,7),(2,25),(10,35),(9,7),
       (11,20),(8,2),(25,12),(25,35),(3,6),(9,24),(26,12),(12,33),(10,32),(24,11),
       (19,9),(8,25),(21,11),(6,19),(6,39),(23,8),(25,43),(13,1),(26,12),(3,35),
       (6,33),(15,23),(7,4),(1,23),(1,40),(21,23),(26,15),(19,16),(1,23),(1,8),
       (13,25),(9,41),(11,31),(16,23),(15,39),(9,36),(2,39),(3,12),(20,9),(16,24),
       (5,8),(23,29),(7,39),(12,27),(13,10),(3,37),(9,19),(10,13),(3,40),(6,41),
       (1,13),(3,28),(3,10),(11,38),(3,5),(12,31),(23,43),(8,18),(13,22),(24,40),
       (5,40),(25,26),(17,5),(24,7),(4,35),(23,15),(8,4),(1,4),(3,23),(15,3),
       (2,28),(5,7),(23,29),(12,19),(2,29),(11,5),(6,3),(10,38),(20,24),(5,29),
       (9,22),(20,4),(7,10),(4,24),(11,32),(18,41),(19,36),(6,2),(12,13),(23,13),
       (1,36),(11,14),(25,41),(4,16),(23,19),(8,15),(15,17),(6,9),(7,32),(12,17),
       (16,43),(3,21),(13,42),(20,19),(9,24),(18,33),(17,33),(20,32),(11,16),(25,28),
       (4,42),(12,35),(1,36),(24,38),(7,19),(25,15),(4,9),(26,29),(11,41),(5,10),
       (17,27),(10,21),(4,20),(1,9),(13,37),(4,22),(8,15),(11,27),(12,26),(1,28),
       (16,13),(10,38),(10,19),(6,32),(22,41),(8,5),(3,7),(6,6),(2,1),(22,27),
       (8,28),(25,33),(26,17),(15,25),(18,32),(19,11),(8,1),(25,20),(10,14),(13,2),
       (19,11),(4,15),(14,11),(20,39),(7,30),(22,30),(20,18),(18,9),(6,25),(25,15),
       (11,22),(26,26),(11,42),(19,32),(20,24),(17,37),(14,9),(14,29),(24,30),(6,12),
       (18,14),(1,35),(4,35),(6,23),(18,32),(21,19),(14,19),(26,39),(4,27),(16,37),
       (7,19),(14,3),(12,3),(1,37),(8,35),(4,2),(24,5),(4,21),(20,32),(2,18),
       (13,34),(22,43),(24,7),(11,9),(10,12),(18,39),(18,24),(26,11),(13,19),(26,2),
       (16,22),(5,12),(13,25),(2,31),(8,43),(6,21),(5,42),(5,35),(2,30),(8,17),
       (3,10),(12,15),(15,7),(6,43),(1,42),(13,5),(6,21),(18,29),(14,25),(24,30),
       (13,26),(17,20),(13,20),(9,11),(17,2),(21,31),(10,17),(14,23),(19,18),(14,7),
       (16,16),(1,13),(22,10),(19,32),(17,1),(2,4),(22,7),(18,34),(14,2),(16,38),
       (20,2),(21,33),(13,13),(12,41),(18,13),(19,26),(3,17),(19,7),(8,2),(24,40),
       (10,9),(23,11),(12,22),(12,38),(13,21),(9,38),(15,29),(19,6),(17,17),(20,1),
       (8,43),(12,42),(3,14),(8,13),(26,11),(26,14),(26,13),(17,36),(26,37),(14,40),
       (18,7),(22,27),(20,31),(15,26),(7,39),(17,41),(26,22),(6,27),(3,11),(9,4),
       (7,20),(24,31),(9,16),(13,4),(4,37),(19,3),(6,10),(18,40),(1,21),(11,34),
       (20,14),(24,6),(17,42),(7,9),(2,4),(5,35),(16,8),(14,13),(11,32),(16,37);

END $$ LANGUAGE plpgsql;

select * from fill_base();
