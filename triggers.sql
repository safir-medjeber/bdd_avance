-- Trigger lié à la table une date d'evenement
DROP FUNCTION IF EXISTS trigger_date_evenement();

CREATE OR REPLACE FUNCTION trigger_date_evenement()
RETURNS TRIGGER
AS $$
DECLARE
	compteur INTEGER;
BEGIN 
	compteur = 
		(SELECT count(*) as c
		FROM 		 Date_Evenement
		NATURAL JOIN Evenement_Culturel
		NATURAL JOIN Lieu
		WHERE 
			-- TODO : Verifier le lieu
			(NEW.date_debut_evenement BETWEEN date_debut_evenement AND date_fin_evenement)
			OR 
			(NEW.date_fin_evenement BETWEEN date_debut_evenement AND date_fin_evenement)
			OR 
			(date_debut_evenement BETWEEN NEW.date_debut_evenement AND NEW.date_fin_evenement)		
			OR 
			(date_fin_evenement BETWEEN NEW.date_debut_evenement AND NEW.date_fin_evenement)
		).c;

	-- Une nouvelle date n'en chevauche pas une autre
	IF compteur > 0 THEN
		RAISE 'Erreur : Les date de l evenement chevauche une autre programmation';
		RETURN NULL;
	-- Une date de fin doit être après la date de début
	ELSIF date_fin < date_debut THEN
		RAISE 'Erreur : date_fin inférieure a date_debut';
		RETURN NULL;
	-- Une nouvelle date doit être dans le futur
	ELSIF date_debut <= TODAY() THEN
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