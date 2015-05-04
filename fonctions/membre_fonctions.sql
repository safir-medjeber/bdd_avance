-------------------------------------------------------
-- Retourne l'id d'un membre a partir de son login
-------------------------------------------------------
DROP FUNCTION IF EXISTS membre_getID(VARCHAR);
CREATE OR REPLACE FUNCTION membre_getID(login VARCHAR)
RETURNS INTEGER AS $$
DECLARE 
	idMembre INTEGER;
BEGIN
	SELECT id_membre INTO idMembre FROM Membre WHERE login_membre = $1;
	IF NOT FOUND THEN
		Raise 'Le login % n existe pas ', $1;
		Return NULL;
	END IF;

	RETURN idMembre;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------
-- Retourne true si le login existe
-------------------------------------------------------
DROP FUNCTION IF EXISTS est_membre(VARCHAR);
CREATE OR REPLACE FUNCTION est_membre(pseudo_membre VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN ($1 IN (SELECT pseudo_membre FROM Membre));
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------
-- Supprime un membre
-- Le ON UPDATE CASCADE ON DELETE CASCADE de la modelisation assure
-- le declenchement de la plupart des supressions utiles
-- Il nous reste :
-- - Verifier les droits via idAppelant
-- - Supprimer un evenement si il n'a plus aucun organisateur (via le trigger)
-------------------------------------------------------
DROP FUNCTION IF EXISTS membre_supprimer(VARCHAR, INTEGER);
CREATE OR REPLACE FUNCTION membre_supprimer(login VARCHAR, idAppelant INTEGER)
RETURNS BOOLEAN AS $$
DECLARE
	idMembre INTEGER := membre_getID(login);
BEGIN
	IF NOT (idMembre = idAppelant OR est_administrateur(idAppelant)) THEN
		RAISE 'Le membre % appelant cette fonction n est ni un administrateur ni le membre à supprimer', login;
		RETURN FALSE;
	END IF;

	DELETE FROM Membre WHERE id_membre = idMembre;

	RETURN TRUE;
END
$$ LANGUAGE plpgsql;