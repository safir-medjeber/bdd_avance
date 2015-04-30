---------------------------------------------------------
-- Renvoie le nombre d'organisateur de l'evenement
---------------------------------------------------------
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