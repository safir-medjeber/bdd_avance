-------------------------------------------------------
-- Reserve un evenement a partir d'un nom de membre
-- (Les conditions sont respectées par les triggers automatiquement appellés)
-------------------------------------------------------
CREATE OR REPLACE FUNCTION reservation_reserver(login VARCHAR, id_date_evenement INTEGER)
RETURNS VOID AS $$
DECLARE
	idMembre INTEGER := membre_getID(login);
BEGIN
	-- Insertion de la requete qui appellera les triggers appropriés
	INSERT INTO Reservation (id_membre, id_date_evenement)
	VALUES (login, id_date_evenement);
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------
-- Annuler une reservation, prend en compte l'appellant
-- (Les conditions sont respectées par les triggers automatiquement appellés,
-- notament l'envoie de l'e mail d avoir.
-------------------------------------------------------
CREATE OR REPLACE FUNCTION reservation_annuler
(id_appelant INTEGER, loginAAnnuler VARCHAR, id_dateEvent INTEGER)
RETURNS BOOLEAN AS $$
DECLARE
	idMembre INTEGER := membre_getID(loginAAnnuler);
	estLeMembre BOOLEAN;
BEGIN
	-- On check si l'appellant est le membre qui a la reservation
	SELECT id_membre = idMembre INTO estLeMembre 
	FROM Reservation
	WHERE Reservation.id_membre = id_membre
	AND id_date_evenement = id_dateEvent;


	-- On verifie que l'appelant est soit un administrateur soit le 
	-- membre concerné
	IF NOT (est_administrateur(id_appelant) OR estLeMembre) THEN
		Raise 'L appelant de l annulation de reservation n est ni un administrateur ni le membre concerné';
		RETURN FALSE;
	END IF;

	DELETE FROM Reservation 
	WHERE id_membre = idMembre AND id_date_evenement = id_dateEvent;

	RETURN TRUE;
END $$ LANGUAGE plpgsql;

