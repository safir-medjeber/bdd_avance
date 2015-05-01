-------------------------------------------------------
-- Supprimer un membre
-- Le ON UPDATE CASCADE ON DELETE CASCADE de la modelisation assure le plupart des suppressions
-- Il reste :
-- - Supprimer un evenement si il n'a plus aucun organisateur
-------------------------------------------------------
DROP FUNCTION IF EXISTS membre_trigger_before_delete();
CREATE OR REPLACE FUNCTION membre_trigger_before_delete()
RETURNS TRIGGER AS $$
DECLARE
	it RECORD;
BEGIN
	-- On liste les evenements dont le membre est organisateur
	-- puis on supprime ceux dont il était le seul organisateur
	FOR it IN
		SELECT id_evenement
		FROM Evenement_Culturel NATURAL JOIN Organise
		WHERE id_membre = OLD.id_membre
	LOOP
		IF ( evenement_nbOrganisateur(it.id_evenement) <= 1 ) THEN
			RAISE NOTICE 'Le membre a supprimer est le seul organisateur de l evenement %, suppression de l evenement', it.id_evenement;
			DELETE FROM Evenement_Culturel WHERE id_evenement = it.id_evenement;
		END IF;
	END LOOP;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER membre_trigger_before_delete
BEFORE DELETE ON Membre FOR EACH ROW
	EXECUTE PROCEDURE membre_trigger_before_delete();