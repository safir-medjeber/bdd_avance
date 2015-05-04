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
	VALUES (idMembre, id_date_evenement);
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------
-- Annuler une reservation, prend en compte l'appellant
-- (Les conditions sont respectées par les triggers automatiquement appellés,
-- notament l'envoi de l'e mail d avoir.
-------------------------------------------------------
CREATE OR REPLACE FUNCTION reservation_annuler
(id_appelant INTEGER, loginAAnnuler VARCHAR, id_dateEvent INTEGER)
RETURNS BOOLEAN AS $$
DECLARE
	idMembre INTEGER := membre_getID(loginAAnnuler);
	estLeMembre BOOLEAN;
BEGIN
	-- On verifie que l'appelant est soit un administrateur soit le membre concerné
	IF NOT (est_administrateur(id_appelant) OR id_appelant = idMembre) THEN
		Raise 'L appelant de l annulation de reservation n est ni un administrateur ni le membre concerné';
		RETURN FALSE;
	END IF;

	-- On verifie que la reservation existe
	PERFORM *
	FROM Reservation
	WHERE id_membre = idMembre AND id_date_evenement = id_dateEvent;
	IF NOT FOUND THEN
		RAISE 'Le membre spécifié n a aucune reservation a la date d evenement donnée';
		RETURN FALSE;
	END IF;

	
	-- Annulation de la reservation
	DELETE FROM Reservation 
	WHERE id_membre = idMembre AND id_date_evenement = id_dateEvent;

	RETURN TRUE;
END $$ LANGUAGE plpgsql;

