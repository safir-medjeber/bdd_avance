---------------------------------------------------------------------------------
-- Renvoie le nombre d'organisateur de l'evenement
---------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION evenement_nbOrganisateur(idEvent INTEGER)
RETURNS INTEGER AS $$
DECLARE
	nb INTEGER;
BEGIN
	SELECT count(*) INTO nb
	FROM Organise 
	WHERE id_evenement = idEvent;

	return nb;
END $$ LANGUAGE plpgsql;


---------------------------------------------------------------------------------
-- Fonction permettant la creation d'un evenement culturel en le liant a son organisateur
---------------------------------------------------------------------------------
CREATE OR REPLACE  FUNCTION create_event(nom_evenement text, id_lieu integer, duree_evenement TIME, id_membre integer ) RETURNS INTEGER as $$
DECLARE
	identifiant INTEGER;
BEGIN
	INSERT INTO Evenement_culturel(nom_evenement, id_lieu, duree_evenement) VALUES (nom_evenement, id_lieu,  duree_evenement) returning id_evenement into identifiant;
	INSERT INTO Organise(id_membre, id_evenement) VALUES (id_membre, identifiant);
RETURN identifiant;	
END;
$$ LANGUAGE plpgsql;


---------------------------------------------------------------------------------
-- Fonction permettant la creation d'un evenement culturel de type festival
---------------------------------------------------------------------------------
CREATE OR REPLACE  FUNCTION create_festival(nom_evenement TEXT, id_lieu INTEGER, duree_evenement TIME, type_festival TEXT, en_plein_air BOOLEAN, id_membre INTEGER)
RETURNS void as $$
DECLARE
	identifiant INTEGER;
BEGIN
	identifiant := create_event(nom_evenement, id_lieu, duree_evenement, id_membre);
	INSERT INTO Festival(id_evenement, type_festival, en_plein_air) VALUES (identifiant, type_festival, en_plein_air);
RETURN;	
END;
$$ LANGUAGE plpgsql;



---------------------------------------------------------------------------------
-- Fonction permettant la creation d'un evenement culturel de type exposition
---------------------------------------------------------------------------------
CREATE OR REPLACE  FUNCTION create_exposition(nom_evenement text, id_lieu integer, duree_evenement TIME, type_exposition text, id_membre INTEGER) RETURNS void as $$
DECLARE
	identifiant INTEGER;
BEGIN
	identifiant := create_event(nom_evenement, id_lieu, duree_evenement, id_membre);
	INSERT INTO Exposition(id_evenement, type_exposition) VALUES (identifiant, type_exposition);
RETURN;	
END;
$$ LANGUAGE plpgsql;


---------------------------------------------------------------------------------
-- Fonction permettant la creation d'un evenement culturel de type piece de theatre
---------------------------------------------------------------------------------
CREATE OR REPLACE  FUNCTION create_piece_theatre(nom_evenement text, id_lieu integer, duree_evenement TIME, genre_piece text, metteur_scene_piece text, id_membre INTEGER)
RETURNS void as $$
DECLARE
	identifiant INTEGER;
BEGIN
	identifiant := create_event(nom_evenement, id_lieu, duree_evenement, id_membre);
	INSERT INTO Piece_Theatre(id_evenement,  genre_piece, metteur_scene_piece) VALUES (identifiant, genre_piece, metteur_scene_piece);
RETURN;	
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------
-- Fonction permettant la creation d'un evenement culturel de type piece de theatre
--------------------------------------------------------------------------------
CREATE OR REPLACE  FUNCTION create_piece_theatre(nom_evenement text, id_lieu integer, duree_evenement TIME, genre_piece text, metteur_scene_piece text, id_membre INTEGER)
RETURNS void as $$
DECLARE
	identifiant INTEGER;
BEGIN
	identifiant := create_event(nom_evenement, id_lieu, duree_evenement, id_membre);
	INSERT INTO Piece_Theatre(id_evenement,  genre_piece, metteur_scene_piece) VALUES (identifiant, genre_piece, metteur_scene_piece);
RETURN;	
END;
$$ LANGUAGE plpgsql;



---------------------------------------------------------
-- Suppression d'un evenement
-- Appelle automatique des triggers
-- Verifie les droits de l'appelant via "id_appelant"
---------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION evenement_supprimer(idEvent INTEGER, id_appelant INTEGER)
RETURNS void AS $$
DECLARE
	it RECORD;
BEGIN
	IF NOT 
		(
			est_administrateur(id_appelant)
			OR 
			(id_appelant IN (SELECT id_membre FROM Organise WHERE id_evenement = idEvent))
		)
		THEN
			RAISE 'L appelant a la fonction de suppression n est ni un administrateur ni un organisateur de l evenement';
			RETURN;
		END IF;

		-- Suppression de toutes les dates d'evenement
		DELETE FROM date_evenement WHERE id_evenement = idEvent;

		DELETE FROM Evenement_culturel WHERE id_evenement = idEvent;
END $$ LANGUAGE plpgsql;

---------------------------------------------------------
-- Ajoute un membre en tant qu'organisateur de l'evenement
-- L'appelant doit être un administrateur ou un organisateur de l'evenement
---------------------------------------------------------
CREATE OR REPLACE FUNCTION evenement_ajouterOrganisateur(idEvent INTEGER, id_appelant INTEGER, idMembre INTEGER)
RETURNS void AS $$
BEGIN
	IF NOT 
		(
			est_administrateur(id_appelant)
			OR 
			(id_appelant IN (SELECT id_membre FROM Organise WHERE id_evenement = idEvent))
		)
		THEN
			RAISE 'L appelant a la fonction de suppression n est ni un administrateur ni un organisateur de l evenement';
			RETURN;
		END IF;

	INSERT INTO Organise (id_membre, id_evenement) VALUES (idEvent, idMembre);
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION evenement_ajouterOrganisateur(idEvent INTEGER, id_appelant INTEGER, login VARCHAR)
RETURNS void AS $$
DECLARE
	idMembre INTEGER = membre_getID(login);
BEGIN
	PERFORM evenement_ajouterOrganisateur(idEvent, id_appelant, idMembre);
END $$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------
-- Retourne le nom et la date d'un evenement a partir de son id_date
--------------------------------------------------------------------------------
CREATE OR REPLACE function get_info_event(idDateEvent INTEGER)
RETURNS TABLE(nom_evenement varchar, date_evenement TIMESTAMP) AS $$
BEGIN
	RETURN QUERY 
	SELECT nom_evenement, date_evenement 
	FROM date_evenement NATURAL JOIN evenement_culturel 
	WHERE id_date_evenement=idDateEvent;
END
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Retourne le nom  d'un evenement a partir de son identifiant
--------------------------------------------------------------------------------
CREATE OR REPLACE function get_name_event(idEvent INTEGER)
RETURNS VARCHAR as $$
DECLARE
	reponse TEXT;
BEGIN
	SELECT nom_evenement INTO reponse
	FROM date_evenement 
	NATURAL JOIN evenement_culturel 
	WHERE id_evenement=idEvent
	;
	return reponse;
END;
$$ LANGUAGE plpgsql;
