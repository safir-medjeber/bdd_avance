-- TODO : Tester de fausses insertions sur ces triggers
-------------------------------------------------------------
-- CONCERT : On verifie que l'id_evenement est un festival
-------------------------------------------------------------
CREATE OR REPLACE FUNCTION concert_trigger_insert_update()
RETURNS TRIGGER AS $$
DECLARE
	idEvent INTEGER;
BEGIN
	SELECT id_evenement INTO idEvent
	FROM Date_evenement 
	WHERE id_date_evenement = NEW.id_date_evenement;

	IF idEvent NOT IN (SELECT id_evenement FROM Festival) THEN
		RAISE 'Trigger sur Concert : L evenement % de la date % indiqué n est pas un festival', idEvent, NEW.id_date_evenement;
		RETURN NULL;
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
BEGIN
	SELECT id_evenement INTO idEvent
	FROM Date_evenement 
	WHERE id_date_evenement = NEW.id_date_evenement;

	IF idEvent NOT IN (SELECT id_evenement FROM Exposition) THEN
		RAISE 'Trigger sur Animation : L evenement %  de la date % indiqué n est pas une exposition', idEvent, NEW.id_date_evenement;
		RETURN NULL;
	END IF;

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER animation_trigger_insert_update
BEFORE INSERT OR UPDATE on Animation FOR EACH ROW
	EXECUTE PROCEDURE animation_trigger_insert_update();