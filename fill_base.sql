\i drop_base.sql
\i init_base.sql


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
<<<<<<< HEAD
INSERT INTO Lieu (nom_lieu, adresse_lieu, code_postal_ville) VALUES 
	('Théâtre de la main d\'or', '15 Passage de la Main d\'Or', '75000'),
	('Palais Omnisports de Paris Bercy', '8 Boulevard de Bercy', '75000'),
	('Hippodrome de Longchamp', '2 Route des Tribunes', '75000')
;
=======

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


--Evenement

INSERT INTO Evenement_Culturel (nom_evenement) VALUES

       ('Festival cinémarges'),     
       ('Festival des outremers'),
       ('Festival Du Nouveau Cinéma Italien'),
       ('Festival Paris Tout Court'),
       ('Festival des Chemins de Traverse'),
       ('Festival de la Rue'),
       ('Festival de Cannes'),
       ('Festival Solidays'),
       ('Festival Rock en Scène'),
       ('Festival Rock in Opposition'),
       ('Festival International de bande dessinee'),


       ('Le bal des Vampire'),
       ('Aristo du Coeur'),
       ('Entre pere et fils'),
       ('La femme de mouss est partie'),
       ('Tailleur pour Dame'),
       ('La Bonne Moitié'),
       ('La Bonne Planque'),
       ('La Bonne Soupe'),
       ('Britannicus (Racine)'),
       ('La Brouette du vinaigrier'),
       ('La Brune que voilà'),
       ('Le Dédale'),
       ('Délire à deux'),
       ('Démocrite amoureux'),
       ('Démocrite prétendu fou'),
       ('Le Dénouement imprévu'),
       ('Le Dépit amoureux'),
       ('La Dernière Nuit pour Marie Stuart'),
       ('Des boulons dans mon yaourt'),
       ('Des journées entières dans les arbres'),
       ('Le Déserteur (opéra)'),


       ('Labo Culinaire'),
       ('Atelier des Sens'),
       ('Ecolde Ritze Escoffier'),
       ('CookSurfing'),
       ('Cook & Go'),
       ('Atelier Couture'),		
       ('Atelier Peinture PopArt'),	
       ('La Cuisine à Paris'),
       ('Les Coulisses du Chef'),
       ('Atelier Top chef'),
       ('Atelier Master chef'),
     
       ('Paris Games Week'),
       ('Expo jean paul gaultier : de la rue aux étoiles'),
       ('Exposition oracles du design'),
       ('Le bord des mondes'),
       ('Exposition Felice Varini'),
       ('Exposition Velazquez'),
       ('Exposition Jeff Koons'),
       ('Exposition Les chasses nouvelles'),
       ('Exposition De Carmen à mélisande'),
       ('Exposition les cahiers dessinés');	


-- Info Piece de Theatre
-- INSERT INTO Piece_Theatre (genre_piece) VALUES
--        ('Comedie Musical'),
--        ('Vaudeville'),
--        ('Tragedie'),
--        ('Bulresque');



-- -- Info Exposition
-- INSERT INTO Exposition (type_exposition) VALUES
--        ('Historique'),
--        ('Commémoration'),
--        ('Litteraire'),
--        ('Japon'),
--        ('Jeu');


-- Membre
INSERT INTO Membre (nom_membre, prenom_membre, sexe_membre, password_membre, pseudo_membre, mail_membre, adresse_membre, code_postal_ville) VALUES
       ('Dupont', 'Xavier', 'H', '134', 'Xaxa', 'dupont.xavier@gmail.com', '3 rue de la sabliere', 1),
       ('Dupuis', 'Marine', 'F', '1343', 'Mama', 'dupuis.marine@gmail.com', '3 rue raymond point carree', 2),
       ('Charles','Sofiane', 'H', 'HKjklj', 'ChCh', 'Charles.Sofiane@gmail.com', '5 rue Charlemagne', 3),
       ('Goliate', 'David' , 'H', 'kgjg', 'GoDa', 'Hurst.David@gmail.com', '10 place de la faisandrie', 4),
       ('Townsend','Wallace', 'H', 'gjhgjhgj', 'ToTo', 'Townsend.Wallace@gmail.com', '23 bis paul vaillant couturier', 7),
       ('Saunders','Sabrina', 'F', 'ojolj', 'SaSa', 'Saunders.Sabrina@gmail.com', '65 avenue de France' , 6),
       ('Lancaster','Fatima', 'F', 'hjhg', 'LaLa', 'Lancaster.Fatima@gmail.com', '456 boulevard hausseman', 7),
       ('Kline','Jeanne', 'F', 'JLJJ', 'KlKl', 'Kline.Jeanne@gmail.com', '455 rue du louvres', 6),
       ('Valentine','Kevin', 'H', 'iyiuyiu', 'VaVa', 'Valentine.Kevin@gmail.com', '432 rue James Watt', 8),
       ('Morrow','Alan', 'H', 'ljlkjlkjm', 'MoMo', 'Morrow.Alan@gmail.com', '34 avenue General leclerc', 1),
       ('Garrison','Mathilda', 'F', 'klhllhl', 'GaGa', 'Garrison.Mathilda@gmail.com', '99 rue du merle', 4),
       ('Underwood','John', 'H', 'ljlkjlkjlm', 'UnUn', 'Underwood.John@gmail.com', '5 avenue raymond Hemell', 1),
       ('Stephens','Nadia', 'F', 'ghfh', 'SteSte', 'Stephens.Nadia@gmail.com', '56 rue duval', 3),
       ('Shaffer', 'Jack', 'H', 'fhgfhj', 'ShaSha', 'Shaffer.Jack@gmail.com', '44 avenue du role', 2),
       ('Stanley','Brandon', 'H', 'popoo', 'Stan', 'Stanley.Brandon@gmail.com', '56 boulevard Duval', 1),
       ('Valenzuela','Jimmy', 'F' , 'pololo', 'ValVal', 'Valenzuela.Jimmy@gmail.com', '17 rue Victor Hugo', 1),
       ('Mathis','Jason', 'H', 'ljkgj', 'MaMa', 'Mathis.Jason@gmail.com', '1 avenue de la republique', 7),
       ('Powell','Samia', 'F', 'lujkh', 'PoPo', 'Powell.Samia@gmail.com', '12 avenue Paul Doumere', 5),
       ('Norton','Afida', 'F', 'gjg', 'NoNo', 'Norton.Afida@gmail.com', '21 rue Saint Germain', 2),
       ('Hurley','Farida', 'F', 'ljlj', 'FaFa', 'Hurley.Farida@gmail.com', '87 boulevard Jean Monnet', 4),
       ('Hunt','Daniel', 'H', 'ojljl', 'HuHu', 'Hunt.Daniel@gmail.com', '442 avenue le Foll', 6),
       ('Charles','Camelia', 'F', 'mmme', 'ChaCha', 'Charles.Camelia@gmail.com', '676 rue du Lievre', 6),
       ('Gould','Rachida', 'F', 'popoikh', 'GoGo', 'Gould.Rachida@gmail.com', '23 rue Aristid Brillant', 5),
       ('Mcdonald','Dominic', 'H', 'mkedo', 'McMc', 'Mcdonald.Dominic@gmail.com', '90 boulevard Rouget de Lisle', 1),
       ('Walter','Baxter', 'H', 'mkdir', 'WaWa', 'Walter.Baxter@gmail.com', '10 rue du Président Wilson', 8),
       ('Osborne','Paula', 'F', 'kjkghj', 'OsOs', 'Osborne.Paula@gmail.com', '56 avenue Saint Martin', 1);
>>>>>>> ca15110e454fa7741dd595300f2393d71cf59edc
