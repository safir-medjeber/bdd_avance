-------------------------------------------------------------
-- CONCERT : On vérifie que
--	- L'id_evenement est un festival
--	- La date est cohérente par rapport à celle du festival
-------------------------------------------------------------
CREATE OR REPLACE FUNCTION concert_trigger_insert_update()
RETURNS TRIGGER AS $$
DECLARE
	idEvent 	INTEGER;
	dateEvent 	TIMESTAMP;
	dureeEvent 	TIME;
BEGIN
	SELECT id_evenement, date_evenement, duree_evenement INTO idEvent, dateEvent, dureeEvent
	FROM Date_evenement NATURAL JOIN Evenement_Culturel
	WHERE id_date_evenement = NEW.id_date_evenement;

	IF idEvent NOT IN (SELECT id_evenement FROM Festival) THEN
		RAISE 'Trigger sur Concert : L evenement n° % de la date % indiquée n est pas un festival', idEvent, NEW.id_date_evenement;
		RETURN NULL;
	END IF;

	-- L'heure doit être comprise entre le debut et la fin de l'evenement
	IF (NEW.heure_concert NOT BETWEEN dateEvent AND dateEvent + dureeEvent)
	OR (NEW.heure_concert + NEW.duree_concert NOT BETWEEN dateEvent AND dateEvent + dureeEvent)
	THEN 
		RAISE 'Trigger sur Concert : L evenement % de la date % indiqué ne rentre pas dans le creneaux horaire de l evenement', idEvent, NEW.id_date_evenement;
	END IF;

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER concert_trigger_insert_update
BEFORE INSERT OR UPDATE on Concert FOR EACH ROW
	EXECUTE PROCEDURE concert_trigger_insert_update();

-------------------------------------------------------------
-- ANIMATION : On verifie que l'id_evenement est une exposition
-------------------------------------------------------------
CREATE OR REPLACE FUNCTION animation_trigger_insert_update()
RETURNS TRIGGER AS $$
DECLARE
	idEvent INTEGER;
	dateEvent TIMESTAMP;
	dureeEvent TIME;
BEGIN
	SELECT id_evenement, date_evenement, duree_evenement INTO idEvent, dateEvent, dureeEvent
	FROM Date_evenement NATURAL JOIN Evenement_Culturel
	WHERE id_date_evenement = NEW.id_date_evenement;

	-- L'evenement doit être une exposition
	IF idEvent NOT IN (SELECT id_evenement FROM Exposition) THEN
		RAISE 'Trigger sur Animation : L evenement %  de la date % indiqué n est pas une exposition', idEvent, NEW.id_date_evenement;
		RETURN NULL;
	END IF;

	-- L'heure doit être comprise entre le debut et la fin de l'evenement
	IF (NEW.heure_animation NOT BETWEEN dateEvent AND dateEvent + dureeEvent)
	OR (NEW.heure_animation + NEW.duree_animation NOT BETWEEN dateEvent AND dateEvent + dureeEvent)
	THEN 
		RAISE 'Trigger sur Animation : L evenement % de la date % indiqué ne rentre pas dans le creneaux horaire de l evenement', idEvent, NEW.id_date_evenement;
	END IF;

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER animation_trigger_insert_update
BEFORE INSERT OR UPDATE on Animation FOR EACH ROW
	EXECUTE PROCEDURE animation_trigger_insert_update();