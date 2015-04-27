-- Zone des Drop --
\i drop_base.sql

CREATE TABLE Ville (
	   code_postal_ville	INTEGER PRIMARY KEY NOT NULL UNIQUE  CHECK (code_postal_ville between 00000 AND 99999),
	   nom_ville 			VARCHAR NOT NULL UNIQUE
);

CREATE TABLE Lieu (
	   id_lieu			SERIAL PRIMARY KEY,
	   nom_lieu 			VARCHAR NOT NULL UNIQUE,
	   adresse_lieu  		VARCHAR NOT NULL,
	   code_postal_ville	INTEGER REFERENCES Ville,
	   capacite_lieu		INTEGER CHECK (capacite_lieu > 0)
);

CREATE TABLE Membre (
	   id_membre 			SERIAL PRIMARY KEY,
	   nom_membre 			VARCHAR NOT NULL,
	   prenom_membre 		VARCHAR NOT NULL,
	   sexe_membre			VARCHAR(1) CHECK(sexe_membre = 'F' or sexe_membre = 'H'),
	   login_membre 		VARCHAR NOT NULL,
	   pseudo_membre 		VARCHAR NOT NULL UNIQUE,
	   mail_membre 			VARCHAR NOT NULL UNIQUE,
	   adresse_membre  		VARCHAR NOT NULL,
	   code_postal_ville	INTEGER REFERENCES Ville
);

CREATE TABLE Administrateur (
) INHERITS (Membre);

CREATE TABLE Message (
	id_contenu_message		SERIAL PRIMARY KEY,
	objet_message			VARCHAR NOT NULL,
	date_message			TIMESTAMP NOT NULL,
	contenu_message 		VARCHAR NOT NULL
);

CREATE TABLE Reception_Message (
	id_membre				INTEGER REFERENCES Membre,
	id_message 				INTEGER REFERENCES Message
);

CREATE TABLE Evenement_Culturel (
	id_evenement			SERIAL PRIMARY KEY,
	nom_evenement			VARCHAR NOT NULL,
	id_lieu					INTEGER REFERENCES Lieu,
	duree_evenement			TIME
);

CREATE TABLE Piece_Theatre (
	genre_piece				VARCHAR NOT NULL,
	metteur_scene_piece		VARCHAR NOT NULL
) INHERITS (Evenement_Culturel);


CREATE TABLE Exposition (
	type_exposition			VARCHAR NOT NULL
) INHERITS (Evenement_Culturel);


CREATE TABLE Festival (
) INHERITS (Evenement_Culturel);

CREATE TABLE Date_Evenement (
	id_date_evenement		SERIAL PRIMARY KEY,
	id_evenement			INTEGER REFERENCES Evenement_Culturel,
	date_evenement 			TIMESTAMP NOT NULL
);

CREATE TABLE Classe_Prix (
	id_classe_prix 			SERIAL PRIMARY KEY,
	id_evenement 			INTEGER REFERENCES Evenement_Culturel,
	id_date_evenement		INTEGER REFERENCES Date_Evenement,
	prix_classe_prix		INTEGER CHECK (prix_classe_prix >= 0)
);

CREATE TABLE Avoir (
	id_avoir 				SERIAL PRIMARY KEY,
	id_membre				INTEGER REFERENCES Membre (id_membre),
	montant_avoir 			INTEGER NOT NULL check (montant_avoir > 0)
);

CREATE TABLE Animation(
       id_animation				SERIAL PRIMARY KEY,
       nom_animation			VARCHAR NOT NULL,
       date_debut_animation		TIMESTAMP NOT NULL,
       date_fin_animation		TIMESTAMP NOT NULL
);

CREATE TABLE Reservation (
	id_reservation 			SERIAL PRIMARY KEY,
	id_membre				INTEGER REFERENCES Membre,
	id_date_evenement		INTEGER REFERENCES Date_Evenement
);

CREATE TABLE Organise (
	id_organise 			SERIAL PRIMARY KEY,
	id_membre				INTEGER REFERENCES Membre,
	id_evenement 			INTEGER REFERENCES Evenement_Culturel
);
CREATE TABLE AUJOURDHUI(
	aujourdhui TIMESTAMP
);

INSERT INTO AUJOURDHUI VALUES ('2015-01-01 00:00:01');


\i requete_acces.sql
\i triggers.sql
\i requetes_ajouts.sql
\i fill_base.sql