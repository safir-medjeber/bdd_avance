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
INSERT INTO Festival (nom_evenement, type_festival, en_plein_air) VALUES
       ('Festival cinémarges', 'cinema', 'no'),     
       ('Festival des outremers', 'culturel', 'no'),
       ('Festival Du Nouveau Cinéma Italien', 'cinema' , 'no'),
       ('Festival Paris Tout Court', 'culturel','yes'),
       ('Festival des Chemins de Traverse', 'culturel', 'no'),
       ('Festival de la Rue', 'culturel', 'yes'),
       ('Festival de Cannes', 'cinema' ,'no'),
       ('Festival Solidays', 'musique', 'yes'),
       ('Festival Rock en Scène', 'musique', 'yes'),
       ('Festival Rock in Opposition','musique', 'yes'),
       ('Festival International de bande dessinee', 'musique', 'yes');

 

-- Piece de Theatre
INSERT INTO Piece_Theatre (nom_evenement, genre_piece, metteur_scene_piece) VALUES
       ('Le bal des Vampire', 'Comedie Musical', 'Fabien Pascal'),
       ('Aristo du Coeur', 'Bulresque', 'Facco Charlotte'),
       ('Entre pere et fils', 'Comique', 'Sabourin François'),
       ('La femme de mouss est partie', 'Comique', 'Segui Elodie'),
       ('Tailleur pour Dame', 'Bulresque', 'Calvo Ernesto'),
       ('La Bonne Moitié', 'Comique', 'Pepi Guillaume'),
       ('La Bonne Planque', 'Comique', 'Cacheux Fred'),
       ('La Bonne Soupe', 'Tragedie', 'Lecono Pierre'),
       ('Britannicus (Racine)', 'Tragedie', 'Rians Johan'),
       ('La Brouette du vinaigrier','Bulresque', 'Pellerin Gille'),
       ('La Brune que voilà', 'Comedie Romantique', 'Lannister Anne'),
       ('Le Dédale', 'Tragedie', 'Stark Daniel'),
       ('Délire à deux', 'Vaudeville', 'Salvador Gabriel'),
       ('Démocrite amoureux', 'Vaudeville', 'Hanouno Camille'),
       ('Démocrite prétendu fou', 'Bulresque', 'Camus Emmanuel'),
       ('Le Dénouement imprévu', 'Tragedie', 'Bourdieu Paul'),
       ('Le Dépit amoureux', 'Comedie Romantique', 'Callier Lydie'),
       ('La Dernière Nuit pour Marie Stuart', 'Comedie Musical', 'Dove attia'),
       ('Des boulons dans mon yaourt', 'Comique', 'Gilbert Damien'),
       ('Des journées entières dans les arbres', 'Comedie', 'Lecomte  Lucille'),
       ('Le Déserteur ', 'Opéra', 'Moya Carlos');



-- Info Exposition
INSERT INTO Exposition (nom_evenement,type_exposition) VALUES
       ('Paris Games Week', 'Jeux'),
       ('Japan Expo', 'Culture Japonaise'),
       ('Expo jean paul gaultier : de la rue aux étoiles', 'Mode'),
       ('Exposition oracles du design', 'Design'),
       ('Le bord des mondes', 'Peinture'),
       ('Exposition Felice Varini', 'Peinture'),
       ('Exposition Velazquez', 'Peinture'),
       ('Exposition Jeff Koons', 'Musique'),
       ('Exposition Cuisine du monde ', 'Cuisine'),
       ('Exposition De Carmen à mélisande', 'Architecture'),
       ('Exposition les cahiers dessinés', 'Peinture');	


-- Animation
INSERT INTO Animation(id_evenement, nom_animation, date_debut_animation, duree_evenement) VALUES		
       (33, 'Initiation aux art martiaux', '2015-01-08', '00:40:00'),
       (41, 'Labo Culinaire', '2015-01-08', '00:40:00'),
       (46, 'Atelier des Sens', '2015-01-08', '00:40:00'),
       (46, 'Initiation à la Couture', '2015-01-08', '00:40:00'),		
       (39, 'Atelier Peinture PopArt', '2015-01-08', '00:40:00'),	
       (34, 'Conférence mangaka', '2015-01-08', '01:00:00'),
       (41, 'Initiation Cuisine Africaine', '2015-01-08', '00:40:00'),
       (41, 'Atelier Les Coulisses du Chef', '2015-01-08', '00:40:00'),
       (33,'Demonstration nouveaux jeux', '2015-01-08', '00:40:00'),		
       (43, 'Atelier Lecture ', '2015-01-08', '00:40:00'),
       (34, 'Atelier Lecture ', '2015-01-08', '00:40:00'),
       (40,'Buffet à Volonté', '2015-01-08', '00:40:00'),
       (38,'Buffet à Volonté', '2015-01-08', '00:40:00'),
       (43,'Buffet à Volonté', '2015-01-08', '00:40:00'),
       (43,'Buffet à Volonté', '2015-01-08', '00:40:00');


    
-- Membre
INSERT INTO Membre (nom_membre, prenom_membre, sexe_membre, login_membre, pseudo_membre, mail_membre, adresse_membre, code_postal_ville) VALUES
       ('Dupont', 'Xavier', 'H', '134', 'Xaxa', 'dupont.xavier@gmail.com', '3 rue de la sabliere', 75000),
       ('Dupuis', 'Marine', 'F', '1343', 'Mama', 'dupuis.marine@gmail.com', '3 rue raymond point carree', 31000),
       ('Charles','Sofiane', 'H', 'HKjklj', 'ChCh', 'Charles.Sofiane@gmail.com', '5 rue Charlemagne', 69000),
       ('Goliate', 'David' , 'H', 'kgjg', 'GoDa', 'Hurst.David@gmail.com', '10 place de la faisandrie', 13000),
       ('Townsend','Wallace', 'H', 'gjhgjhgj', 'ToTo', 'Townsend.Wallace@gmail.com', '23 bis paul vaillant couturier', 33000),
       ('Saunders','Sabrina', 'F', 'ojolj', 'SaSa', 'Saunders.Sabrina@gmail.com', '65 avenue de France' , 59000),
       ('Lancaster','Fatima', 'F', 'hjhg', 'LaLa', 'Lancaster.Fatima@gmail.com', '456 boulevard hausseman', 33000),
       ('Kline','Jeanne', 'F', 'JLJJ', 'KlKl', 'Kline.Jeanne@gmail.com', '455 rue du louvres', 59000),
       ('Valentine','Kevin', 'H', 'iyiuyiu', 'VaVa', 'Valentine.Kevin@gmail.com', '432 rue James Watt', 06000),
       ('Morrow','Alan', 'H', 'ljlkjlkjm', 'MoMo', 'Morrow.Alan@gmail.com', '34 avenue General leclerc', 75000),
       ('Garrison','Mathilda', 'F', 'klhllhl', 'GaGa', 'Garrison.Mathilda@gmail.com', '99 rue du merle', 13000),
       ('Underwood','John', 'H', 'ljlkjlkjlm', 'UnUn', 'Underwood.John@gmail.com', '5 avenue raymond Hemell', 75000),
       ('Stephens','Nadia', 'F', 'ghfh', 'SteSte', 'Stephens.Nadia@gmail.com', '56 rue duval', 31000),
       ('Shaffer', 'Jack', 'H', 'fhgfhj', 'ShaSha', 'Shaffer.Jack@gmail.com', '44 avenue du role', 31000),
       ('Stanley','Brandon', 'H', 'popoo', 'Stan', 'Stanley.Brandon@gmail.com', '56 boulevard Duval', 75000),
       ('Valenzuela','Jimmy', 'F' , 'pololo', 'ValVal', 'Valenzuela.Jimmy@gmail.com', '17 rue Victor Hugo', 75000),
       ('Mathis','Jason', 'H', 'ljkgj', 'MaMa', 'Mathis.Jason@gmail.com', '1 avenue de la republique', 33000),
       ('Powell','Samia', 'F', 'lujkh', 'PoPo', 'Powell.Samia@gmail.com', '12 avenue Paul Doumere', 67000),
       ('Norton','Afida', 'F', 'gjg', 'NoNo', 'Norton.Afida@gmail.com', '21 rue Saint Germain', 31000),
       ('Hurley','Farida', 'F', 'ljlj', 'FaFa', 'Hurley.Farida@gmail.com', '87 boulevard Jean Monnet', 13000),
       ('Hunt','Daniel', 'H', 'ojljl', 'HuHu', 'Hunt.Daniel@gmail.com', '442 avenue le Foll', 59000),
       ('Charles','Camelia', 'F', 'mmme', 'ChaCha', 'Charles.Camelia@gmail.com', '676 rue du Lievre', 59000),
       ('Gould','Rachida', 'F', 'popoikh', 'GoGo', 'Gould.Rachida@gmail.com', '23 rue Aristid Brillant', 67000),
       ('Mcdonald','Dominic', 'H', 'mkedo', 'McMc', 'Mcdonald.Dominic@gmail.com', '90 boulevard Rouget de Lisle', 75000),
       ('Walter','Baxter', 'H', 'mkdir', 'WaWa', 'Walter.Baxter@gmail.com', '10 rue du Président Wilson', 06000),
       ('Osborne','Paula', 'F', 'kjkghj', 'OsOs', 'Osborne.Paula@gmail.com', '56 avenue Saint Martin', 75000);
