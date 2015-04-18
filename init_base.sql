-- Mehdi


-- Safir

CREATE TABLE Lieu (
       id_lieu INTEGER PRIMARY KEY,
       nom_lieu VARCHAR NOT NULL,
       adress_lieu  VARCHAR NOT NULL,
);

CREATE TABLE Ville (
       id_ville INTEGER PRIMARY KEY,
       code_postal_ville INTEGER NOT NULL,
       nom_ville VARCHAR NOT NULL,
);


CREATE TABLE Membre (
       id_membre INTEGER PRIMARY KEY,
       nom_membre VARCHAR NOT NULL,
       prenom_membre VARCHAR NOT NULL,
       password_membre VARCHAR NOT NULL,
       pseudo_membre VARCHAR NOT NULL,
       mail_membre VARCHAR NOT NULL,
       adresse_membre  VARCHAR NOT NULL,
       code_postal_membre  INTEGER NOT NULL,
       estGarcon_membre BOOLEAN NOT NULL
);



CREATE TABLE Avoir (
       id_avoir INTEGER PRIMARY KEY,
       FOREIGN KEY (id_membre) REFERENCES Membre (id_membre),
       montant INTEGER job_admin NOT NULL
);


