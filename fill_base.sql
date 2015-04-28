-- import des fonctions de creation d'evenement
\i create_event.sql

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
INSERT INTO Lieu (nom_lieu, adresse_lieu) VALUES
       ('Musée Dapper', '35 bis rue Paul-Valéry'),
       ('Musée du Petit Palais', '15 avenue Winston Churchill'),
       ('Musee Orsay', '1 rue de la Légion Honneur '),
       ('Musee du Louvre', '10 Boulevard du Louvre'),
       ('Musee du Quaie Branly','37 Quai Branly'),
       ('Paris Expo', 'Porte de Versailles'),

       ('La Comédie de Lille', '204 rue de Solférino'),
       ('Comédie-Française', 'Place Colette'),
       ('Théâtre National de Chaillot', '10 rue Duval'),
       ('Théâtre National de la Colline', '15 rue Malte Brun'),
       ('Théâtre National de Odéon', '2 rue Corneille'),	
       ('Théâtre National de Strasbourg', '1 Avenue de la Marseillaise'),

       ('Atelier renault café', '53, avenue des champs-elysées '),
       ('Le balm', '6, rue valois'),
       ('Bon', '25, rue de la pompe'),
       ('Café de la jatte', '60, boulevard vital-bouhot'),
       ('Café marly', '93, rue de rivoli - paris 1er'),
       ('Le ciel de paris', '33, avenue du maine'),
       ('Ma cocotte', '106, rue des rosiers'),
       ('Cristal room baccarat', '11, place des Etats-Unis'),

       ('Le palais des Festivals', 'Boulevard de la Croisette'),
       ('Le palais des Congres', 'Boulevard de Bercy'),
       ('Hippodrome de Longchamp', '5 avenue de la Republic'),
       ('Hippodrome de Vincennes', '54 rue des chevaux'),
       ('Hippodrome du Bouscat', '4 rue de la Tour'),
       ('Parc de la Citadelle', '10 Avenue Mathias Delobel'),
       ('Parc Orangerie', '12 Avenue Citron'),
       ('Prairie des Filtres', '34 rue Toulouse centre');


-- Festival
select create_festival('Festival cinémarges', 'cinema', 'no');
select create_festival('Festival des outremers', 'culturel', 'no');
select create_festival('Festival Du Nouveau Cinéma Italien', 'cinema' , 'no');
select create_festival('Festival Paris Tout Court', 'culturel','yes');
select create_festival('Festival des Chemins de Traverse', 'culturel', 'no');
select create_festival('Festival de la Rue', 'culturel', 'yes');
select create_festival('Festival de Cannes', 'cinema' ,'no');
select create_festival('Festival Solidays', 'musique', 'yes');
select create_festival('Festival Rock en Scène', 'musique', 'yes');
select create_festival('Festival Rock in Opposition','musique', 'yes');
select create_festival('Festival International de bande dessinee', 'musique', 'yes');


 
-- Piece de Theatre
select create_piece_theatre('Le bal des Vampire', 'Comedie Musical', 'Fabien Pascal');
select create_piece_theatre('Aristo du Coeur', 'Bulresque', 'Facco Charlotte');
select create_piece_theatre('Entre pere et fils', 'Comique', 'Sabourin François');
select create_piece_theatre('La femme de mouss est partie', 'Comique', 'Segui Elodie');
select create_piece_theatre('Tailleur pour Dame', 'Bulresque', 'Calvo Ernesto');
select create_piece_theatre('La Bonne Moitié', 'Comique', 'Pepi Guillaume');
select create_piece_theatre('La Bonne Planque', 'Comique', 'Cacheux Fred');
select create_piece_theatre('La Bonne Soupe', 'Tragedie', 'Lecono Pierre');
select create_piece_theatre('Britannicus (Racine)', 'Tragedie', 'Rians Johan');
select create_piece_theatre('La Brouette du vinaigrier','Bulresque', 'Pellerin Gille');
select create_piece_theatre('La Brune que voilà', 'Comedie Romantique', 'Lannister Anne');
select create_piece_theatre('Le Dédale', 'Tragedie', 'Stark Daniel');
select create_piece_theatre('Délire à deux', 'Vaudeville', 'Salvador Gabriel');
select create_piece_theatre('Démocrite amoureux', 'Vaudeville', 'Hanouno Camille');
select create_piece_theatre('Démocrite prétendu fou', 'Bulresque', 'Camus Emmanuel');
select create_piece_theatre('Le Dénouement imprévu', 'Tragedie', 'Bourdieu Paul');
select create_piece_theatre('Le Dépit amoureux', 'Comedie Romantique', 'Callier Lydie');
select create_piece_theatre('La Dernière Nuit pour Marie Stuart', 'Comedie Musical', 'Dove attia');
select create_piece_theatre('Des boulons dans mon yaourt', 'Comique', 'Gilbert Damien');
select create_piece_theatre('Des journées entières dans les arbres', 'Comedie', 'Lecomte  Lucille');
select create_piece_theatre('Le Déserteur ', 'Opéra', 'Moya Carlos');



-- Info Exposition
select create_exposition('Paris Games Week', 'Jeux');
select create_exposition('Japan Expo', 'Culture Japonaise');
select create_exposition('Expo jean paul gaultier : de la rue aux étoiles', 'Mode');
select create_exposition('Exposition oracles du design', 'Design');
select create_exposition('Le bord des mondes', 'Peinture');
select create_exposition('Exposition Felice Varini', 'Peinture');
select create_exposition('Exposition Velazquez', 'Peinture');
select create_exposition('Exposition Jeff Koons', 'Musique');
select create_exposition('Exposition Cuisine du monde ', 'Cuisine');
select create_exposition('Exposition De Carmen à mélisande', 'Architecture');
select create_exposition('Exposition les cahiers dessinés', 'Peinture');



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
       (32, '2015-01-12 20:30:00', 35),


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
       (11, '2016-01-02 10:30:00', 20),

       
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
INSERT INTO Animation(id_date_evenement, heure_animation, nom_animation, duree_evenement) VALUES		
       (33, '10:30:00', 'Initiation aux art martiaux', '00:40:00'),
       (33, '10:30:00', 'Demonstration nouveaux jeux', '00:40:00'),		
       (34, '10:30:00', 'Conférence mangaka', '01:00:00'),
       (34, '12:30:00', 'Atelier Lecture ', '00:40:00'),
       (35, '10:30:00', 'Initiation à la Couture', '00:40:00'),		
       (35, '10:30:00', 'Nouvelles tendances', '00:40:00'),
       (36, '10:30:00', 'Nouvelles tendances du design', '00:55:00'),
       (37, '10:30:00', 'Atelier Lecture ', '00:40:00'),
       (37, '20:30:00', 'Buffet à Volonté', '03:00:00'),
       (38, '20:30:00', 'Buffet à Volonté', '03:00:00'),
       (38, '14:30:00', 'Conference Art Abstrait', '00:40:00'),
       (39, '10:30:00', 'Atelier Peinture PopArt', '00:40:00'),	
       (41, '10:30:00', 'Labo Culinaire', '00:40:00'),
       (41, '13:30:00', 'Initiation Cuisine Africaine', '00:40:00'),
       (41, '20:30:00', 'Atelier Les Coulisses du Chef', '00:40:00'),
       (43, '12:30:00', 'Buffet à Volonté', '02:00:00'),
       (43, '12:30:00', 'Atelier Lecture', '00:40:00');




INSERT INTO Concert(id_date_evenement, heure_animation, artiste_concert, duree_evenement) VALUES		
       (22, '10:30:00', 'Initiation à la Couture', '00:40:00'),		
       (24, '10:30:00', 'Maroon Five', '00:40:00'),
       (28, '18:30:00', 'Mika', '00:40:00'),
       (29, '18:30:00', 'The Avener', '00:40:00'),
       (29, '19:30:00', 'Madeon', '00:40:00'),		
       (29, '21:30:00', 'Clean Bandit', '00:40:00'),
       (30, '18:30:00', 'Xavier Rudd', '00:40:00'),
       (30, '20:30:00', 'Tairo', '00:40:00'),
       (31, '18:30:00', 'Mademoiselle K', '00:55:00'),
       (31, '19:30:00', 'Moriarty', '00:55:00'),
       (31, '20:30:00', 'Lilly Wood And The Prick', '00:55:00');

     
       




-- Membre
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

