-- Zone des Drop --



-- Mehdi
CREATE TABLE Message (
	id_message 				SERIAL PRIMARY KEY,
	id_membre				PRIMARY KEY REFERENCES Membre,
	date_message			DATETIME NOT NULL,
	id_contenu_message 		PRIMARY KEY REFERENCES Contenu_Message
);
CREATE TABLE Contenu_Message (
	id_contenu_message		SERIAL PRIMARY KEY,
	objet_conutenu_message	VARCHAR NOT NULL,
	contenu_message 		VARCHAR NOT NULL
);
CREATE TABLE Type_Place (
	id_type_place			SERIAL PRIMARY KEY,
	id_lieu					PRIMARY KEY REFERENCES Lieu,
	nom_type_place			VARCHAR NOT NULL,
	capacite_type_place		INTEGER CHECK (capacite_type_place > 0)
)
CREATE TABLE Classe_Prix (
	id_classe_prix 			SERIAL PRIMARY KEY,
	id_evenement 			PRIMARY KEY REFERENCES Evenement_Culturel,
	id_type_place 			PRIMARY KEY REFERENCES Type_Place,
	prix_classe_prix		INTEGER CHECK (prix_classe_prix >= 0)
);

CREATE TABLE Evenement_Culturel (
	id_evenement			SERIAL PRIMARY KEY,
	nom_evenement			VARCHAR NOT NULL UNIQUE,
);
CREATE TABLE Piece_Theatre (
    genre_piece				VARCHAR NOT NULL
) INHERITS (Evenement_Culturel);

CREATE TABLE Exposition (
) INHERITS (Evenement_Culturel);

CREATE TABLE Festival (
) INHERITS (Evenement_Culturel);

CREATE DATE (
	id_date					SERIAL PRIMARY KEY,
	date_debut				DAYTIME NOT NULL,
	date_fin				DAYTIME NOT NULL,
	id_evenement			PRIMARY KEY REFERENCES Evenement_Culturel
);

-- Safir

