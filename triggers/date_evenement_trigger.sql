-------------------------------------------------------
-- INSERT et UPDATE
-------------------------------------------------------
CREATE OR REPLACE FUNCTION trigger_date_evenement_insert_update()
RETURNS TRIGGER AS $$
DECLARE
	compteur_chevauchement INTEGER;

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

CREATE TRIGGER trigger_date_evenement_insert_update
BEFORE INSERT OR UPDATE 
ON Date_Evenement FOR EACH ROW
   EXECUTE PROCEDURE trigger_date_evenement_insert_update();

-------------------------------------------------------
-- DELETE
-- Si on supprimer une date, alors il faut notifier tous les acheteurs
-- et leur donner un avoir
-- On supprimer aussi la classe de prix associée
-------------------------------------------------------
-- TODO : Tester ce trigger
CREATE OR REPLACE FUNCTION trigger_date_evenement_delete()
RETURNS TRIGGER AS $$
DECLARE
	it RECORD;
	contenuMessage VARCHAR;
	nomEvent VARCHAR;
BEGIN
	RAISE NOTICE 'Suppression de la date d evenement numero %, creation d un e mail groupé d annulation.', OLD.id_date_evenement;

	-- Envoi du mail groupé d annulation
	SELECT nom_evenement INTO nomEvent
	FROM Date_Evenement NATURAL JOIN Evenement_Culturel 
	WHERE id_date_evenement = OLD.id_date_evenement
	;
	contenuMessage := 'Nous avons le regret de vous informer que l evenement '||nomEvent
			||' prevu le '||OLD.date_evenement::VARCHAR||' a ete annulé, un avoir vous 
			a été attribué.';
	PERFORM envoyer_message_groupe(OLD.id_date_evenement, 'Annulation d un evenement', contenuMessage);

	-- Suppression des reservation
	DELETE FROM Reservation WHERE id_date_evenement = OLD.id_date_evenement;

	RETURN OLD;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_date_evenement_delete
BEFORE DELETE
ON Date_Evenement FOR EACH ROW
   EXECUTE PROCEDURE trigger_date_evenement_delete();