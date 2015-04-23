-- Zone des Drop --
\i drop_base.sql

CREATE TABLE Ville (
<<<<<<< HEAD
	   code_postal_ville	INTEGER PRIMARY KEY NOT NULL UNIQUE,
=======
	   id_ville			SERIAL PRIMARY KEY,
	   code_postal_ville		INTEGER NOT NULL UNIQUE,
>>>>>>> ca15110e454fa7741dd595300f2393d71cf59edc
	   nom_ville 			VARCHAR NOT NULL UNIQUE
);

CREATE TABLE Lieu (
	   id_lieu			SERIAL PRIMARY KEY,
	   nom_lieu 			VARCHAR NOT NULL UNIQUE,
	   adresse_lieu  		VARCHAR NOT NULL,
<<<<<<< HEAD
	   code_postal_ville	INTEGER REFERENCES Ville
=======
	   id_ville			INTEGER REFERENCES Ville
>>>>>>> ca15110e454fa7741dd595300f2393d71cf59edc
);

CREATE TABLE Membre (
	   id_membre 			SERIAL PRIMARY KEY,
	   nom_membre 			VARCHAR NOT NULL,
	   prenom_membre 		VARCHAR NOT NULL,
	   sexe_membre			VARCHAR(1) CHECK(sexe_membre = 'F' or sexe_membre = 'H'),
	   password_membre 		VARCHAR NOT NULL,
	   pseudo_membre 		VARCHAR NOT NULL UNIQUE,
	   mail_membre 			VARCHAR NOT NULL UNIQUE,
	   adresse_membre  		VARCHAR NOT NULL,
	   code_postal_ville		INTEGER REFERENCES Ville(id_ville)
);

CREATE TABLE Administrateur (
) INHERITS (Membre);

CREATE TABLE Contenu_Message (
	id_contenu_message		SERIAL PRIMARY KEY,
	objet_message			VARCHAR NOT NULL,
	contenu_message 		VARCHAR NOT NULL
);

CREATE TABLE Message (
	id_message 			SERIAL PRIMARY KEY,
	id_membre			INTEGER REFERENCES Membre,
	date_message			TIMESTAMP NOT NULL,
	id_contenu_message 		INTEGER REFERENCES Contenu_Message
);

CREATE TABLE Evenement_Culturel (
	id_evenement			SERIAL PRIMARY KEY,
	nom_evenement			VARCHAR NOT NULL
);

CREATE TABLE Piece_Theatre (
	genre_piece			VARCHAR 
) INHERITS (Evenement_Culturel);

CREATE TABLE Exposition (
	type_exposition			VARCHAR
) INHERITS (Evenement_Culturel);

CREATE TABLE Festival (
) INHERITS (Evenement_Culturel);

CREATE TABLE Type_Place (
	id_type_place			SERIAL PRIMARY KEY,
	id_lieu				INTEGER REFERENCES Lieu,
	nom_type_place			VARCHAR NOT NULL,
	capacite_type_place		INTEGER CHECK (capacite_type_place > 0)
);

CREATE TABLE Classe_Prix (
	id_classe_prix 			SERIAL PRIMARY KEY,
	id_evenement 			INTEGER REFERENCES Evenement_Culturel,
	id_type_place 			INTEGER REFERENCES Type_Place,
	prix_classe_prix		INTEGER CHECK (prix_classe_prix >= 0)
);

CREATE TABLE Date_Evenement (
	id_date_evenemnt		SERIAL PRIMARY KEY,
	date_debut_evenement	TIMESTAMP NOT NULL,
	date_fin_evenement		TIMESTAMP NOT NULL,
	id_evenement			INTEGER REFERENCES Evenement_Culturel
);

CREATE TABLE Avoir (
	id_avoir 			SERIAL PRIMARY KEY,
	id_membre			INTEGER REFERENCES Membre (id_membre),
	montant_avoir 		INTEGER NOT NULL check (montant_avoir > 0)
);


-- CREATE TABLE Participe (
-- 	id_participe 			SERIAL PRIMARY KEY
-- );



-- CREATE TABLE Organise (
-- 	id_organise 			SERIAL PRIMARY KEY
-- );
CREATE TABLE AUJOURDHUI(
	aujourdhui TIMESTAMP
);

INSERT INTO AUJOURDHUI VALUES ('2015-01-01 00:00:01');
