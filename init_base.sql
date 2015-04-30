-- Zone des Drop --
\i drop_base.sql

CREATE TABLE Ville (
	code_postal_ville	INTEGER PRIMARY KEY NOT NULL UNIQUE  CHECK (code_postal_ville between 00000 AND 99999),
	nom_ville 		VARCHAR NOT NULL UNIQUE
);

CREATE TABLE Lieu (
	id_lieu			SERIAL PRIMARY KEY,
	nom_lieu 		VARCHAR NOT NULL UNIQUE,
	adresse_lieu  		VARCHAR NOT NULL,
	code_postal_ville	INTEGER REFERENCES Ville,
	capacite_lieu		INTEGER CHECK (capacite_lieu > 0)
);

CREATE TABLE Membre (
	id_membre 		SERIAL PRIMARY KEY,
	nom_membre 		VARCHAR NOT NULL,
	prenom_membre 		VARCHAR NOT NULL,
	sexe_membre		VARCHAR(1) CHECK(sexe_membre = 'F' or sexe_membre = 'H') NOT NULL,
	login_membre 		VARCHAR NOT NULL,
	mail_membre 		VARCHAR NOT NULL UNIQUE,
	adresse_membre  	VARCHAR NOT NULL,
	code_postal_ville	INTEGER REFERENCES Ville
);

CREATE TABLE Administrateur (
	id_membre 		INTEGER PRIMARY KEY REFERENCES Membre
);

CREATE TABLE Message (
	id_message		SERIAL PRIMARY KEY,
	objet_message		VARCHAR NOT NULL,
	date_message		TIMESTAMP, -- Si NULL on utilise TODAY
	contenu_message 	VARCHAR NOT NULL
);

CREATE TABLE Reception_Message (
	id_membre		INTEGER REFERENCES Membre,
	id_message 		INTEGER REFERENCES Message
);

CREATE TABLE Evenement_Culturel (
	id_evenement		SERIAL PRIMARY KEY,
	nom_evenement		VARCHAR NOT NULL,
	id_lieu			INTEGER REFERENCES Lieu NOT NULL,
	duree_evenement		TIME
);

CREATE TABLE Piece_Theatre (
	id_evenement 		INTEGER PRIMARY KEY REFERENCES Evenement_Culturel,
	genre_piece		VARCHAR NOT NULL,
	metteur_scene_piece	VARCHAR NOT NULL
);


CREATE TABLE Exposition (
	id_evenement 		INTEGER PRIMARY KEY REFERENCES Evenement_Culturel,
	type_exposition		VARCHAR NOT NULL
);


CREATE TABLE Festival (
	id_evenement 		INTEGER PRIMARY KEY REFERENCES Evenement_Culturel,
	type_festival		VARCHAR NOT NULL,
	en_plein_air		BOOLEAN NOT NULL
);

CREATE TABLE Date_Evenement (
	id_date_evenement	SERIAL PRIMARY KEY,
	id_evenement		INTEGER  REFERENCES Evenement_Culturel,
	date_evenement 		TIMESTAMP NOT NULL,
	prix_date_evenement	INTEGER CHECK (prix_date_evenement >= 0)
);

CREATE TABLE Avoir (
	id_avoir 		SERIAL PRIMARY KEY,
	id_membre		INTEGER REFERENCES Membre (id_membre),
	montant_avoir 		INTEGER NOT NULL check (montant_avoir > 0)
);

CREATE TABLE Animation(
	id_animation		SERIAL PRIMARY KEY,
	id_date_evenement	INTEGER REFERENCES Date_Evenement,
	heure_animation		TIME,
	nom_animation		VARCHAR NOT NULL,
	duree_animation		TIME
);

CREATE TABLE Concert(
	id_concert		SERIAL PRIMARY KEY,
	id_date_evenement	INTEGER REFERENCES Date_Evenement,
	heure_concert		TIME,
	artiste_concert		VARCHAR NOT NULL,
	duree_concert		TIME
);

CREATE TABLE Reservation (
	id_membre		INTEGER REFERENCES Membre,
	id_date_evenement	INTEGER REFERENCES Date_Evenement
);

CREATE TABLE Organise (
	id_membre		INTEGER REFERENCES Membre,
	id_evenement 		INTEGER REFERENCES Evenement_Culturel
);

CREATE TABLE AUJOURDHUI(
	aujourdhui		TIMESTAMP
);

INSERT INTO AUJOURDHUI VALUES ('2015-01-01 00:00:01');

-------------------------------------------------------
-- Retourne le jour courant
-------------------------------------------------------
DROP FUNCTION IF EXISTS TODAY();
CREATE OR REPLACE FUNCTION today()
RETURNS TIMESTAMP AS $$
BEGIN
	RETURN (SELECT aujourdhui FROM aujourdhui);
END;
$$ LANGUAGE plpgsql;
-------------------------------------------------------

\i membre_fonctions.sql
\i administrateur_fonctions.sql
\i date_evenement_trigger.sql
--\i concert-animation_trigger.sql
-- \i reservation_trigger.sql
\i reservation_fonctions.sql
\i avoir_fonctions.sql
\i message.sql
\i message_trigger.sql
\i fill_base.sql

