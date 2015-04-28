-- Trigger lié à la table une date d'evenement
DROP FUNCTION IF EXISTS trigger_date_evenement();

CREATE OR REPLACE FUNCTION trigger_date_evenement()
RETURNS TRIGGER
AS $$
DECLARE
	compteur BIGINT;
BEGIN 
	-- On liste les evenements en conflit avec NEW
	SELECT count(*) INTO compteur
	FROM 		 Date_Evenement
	NATURAL JOIN Evenement_Culturel
	WHERE 
		id_evenement = NEW.id_evenement
		AND
		(
			-- TODO : Verifier les capacités de l'evenement

			-- La nouvelle programmation ne doit pas en chevaucher une autre
			(NEW.date_evenement BETWEEN date_evenement AND date_evenement + duree_evenement)
			OR 
			(NEW.date_evenement + duree_evenement BETWEEN date_evenement AND date_evenement + duree_evenement)
		)
	;

	-- Une nouvelle date n'en chevauche pas une autre
	IF compteur > 0 THEN
		RAISE 'Erreur : Les date de l evenement chevauche une autre programmation';
		RETURN NULL;
	-- Une nouvelle date doit être dans le futur
	ELSIF NEW.date_evenement < TODAY() THEN
		RAISE 'Erreur : date_debut avant aujourd hui';
		RETURN NULL;
	END IF;

	-- Tout est OK
	RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_date_evenement
BEFORE INSERT OR UPDATE 
ON Date_Evenement FOR EACH ROW
   EXECUTE PROCEDURE trigger_date_evenement();