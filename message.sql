-------------------------------------------------------
-- Liste les messages d'un membre a partir de son login
-------------------------------------------------------
CREATE OR REPLACE FUNCTION boite_reception(login_membre VARCHAR)
RETURNS TABLE (date_message TIMESTAMP, objet_message VARCHAR, contenu_message VARCHAR)
AS $$
DECLARE
	idMembre INTEGER;
BEGIN
	idMembre := membre_getID($1);
	RETURN QUERY
		SELECT Message.date_message, Message.objet_message, Message.contenu_message
		FROM 
		(SELECT * FROM Reception_message WHERE id_membre = idMembre) as s
		NATURAL JOIN Message
	;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------
-- VIDER BOITE RECEPTION
-------------------------------------------------------
CREATE OR REPLACE FUNCTION vider_boite_reception(login VARCHAR)
RETURNS VOID AS $$ 
DECLARE
	idMembre integer;
BEGIN
	idMembre := membre_getID(login);
	DELETE FROM Reception_Message WHERE id_membre = idMembre;
END $$ LANGUAGE plpgsql;

-------------------------------------------------------
-- Creation du mail
-------------------------------------------------------
CREATE OR REPLACE FUNCTION creation_message(objet_message VARCHAR, texte_message VARCHAR)
RETURNS INTEGER AS $$ 
DECLARE
	idMessage INTEGER;
BEGIN
	INSERT INTO Message (objet_message, date_message, contenu_message) VALUES ($1, (SELECT TODAY()), $2) RETURNING id_message INTO idMessage;
	return idMessage;
END $$ LANGUAGE plpgsql;

-------------------------------------------------------
-- Envoi d'un mail à un membre
-------------------------------------------------------
CREATE OR REPLACE FUNCTION envoyer_message(login_membre VARCHAR, objet_message VARCHAR, contenu_message VARCHAR)
RETURNS VOID AS $$

DECLARE
	idMembre INTEGER;
	idMessage INTEGER;
BEGIN
	-- Recherche de l'id_membre
	SELECT id_membre INTO idMembre FROM Membre WHERE Membre.login_membre = $1;
	IF NOT FOUND THEN
		Raise 'Envoyer Message : Membre % non trouvé.' , login_membre;
	END IF;

	-- Creation du message
	idMessage := creation_message(objet_message, contenu_message);

	-- Liaison du message
	INSERT INTO Reception_message (id_membre, id_message) VALUES (idMembre, idMessage);
END
$$ LANGUAGE plpgsql;

-------------------------------------------------------
-- Envoi d'un mail au membre inscrit à un evenement
-------------------------------------------------------
CREATE OR REPLACE FUNCTION envoyer_message(idEvenement INTEGER, objet_message VARCHAR, contenu_message VARCHAR)
RETURNS VOID AS $$

DECLARE
	idMessage 	INTEGER;
	r 			RECORD;
BEGIN
	-- Creation du message
	idMessage := creation_message(objet_message, contenu_message);

	-- Liaison du message
	FOR r IN (SELECT id_membre FROM Reservation WHERE id_evenement = $1) LOOP
		INSERT INTO Reception_message (if_membre, id_message) VALUES (r.id_membre, idMessage);
	END LOOP;
END
$$ LANGUAGE plpgsql;