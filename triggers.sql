-----------------
-- DATE EVENEMENT
-----------------

-- INSERT OR UPDATE
CREATE OR REPLACE FUNCTION trigger_date_evenement_insert_update()
RETURNS TRIGGER
AS $$
DECLARE
	compteur_chevauchement BIGINT;
BEGIN 
	-- Une nouvelle date n'en chevauche pas une autre
	SELECT count(*) INTO compteur_chevauchement
	FROM 		 Date_Evenement
	NATURAL JOIN Evenement_Culturel
	WHERE 
		id_evenement = NEW.id_evenement
		AND
		(
			-- La nouvelle programmation ne doit pas en chevaucher une autre
			(NEW.date_evenement BETWEEN date_evenement AND date_evenement + duree_evenement)
			OR 
			(NEW.date_evenement + duree_evenement BETWEEN date_evenement AND date_evenement + duree_evenement)
		)
	;
	IF compteur_chevauchement > 0 THEN
		RAISE 'Erreur : Les date de l evenement chevauche une autre programmation';
		RETURN NULL;
	END IF;

	-- Une nouvelle date doit être dans le futur
	IF NEW.date_evenement < TODAY() THEN
		RAISE 'Erreur : date_debut avant aujourd hui';
		RETURN NULL;
	END IF;

	-- Tout est OK
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_date_evenement
BEFORE INSERT OR UPDATE 
ON Date_Evenement FOR EACH ROW
   EXECUTE PROCEDURE trigger_date_evenement_insert_update();

-- DELETE
-- Si on supprimer une date, alors il faut notifier tous les acheteurs
-- et leur donner un avoir
-- On supprimer aussi la classe de prix associée
CREATE OR REPLACE FUNCTION trigger_date_evenement_delete()
RETURNS TRIGGER
AS $$
BEGIN
	--TODO
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_date_evenement
BEFORE DELETE
ON Date_Evenement FOR EACH ROW
   EXECUTE PROCEDURE trigger_date_evenement_delete();