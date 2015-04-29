-- TODO : Tester de fausses insertions sur ces triggers
-------------------------------------------------------------
-- CONCERT : On verifie que l'id_evenement est un festival
-------------------------------------------------------------
CREATE OR REPLACE FUNCTION concert_trigger_insert_update()
RETURNS TRIGGER AS $$
BEGIN
	PERFORM id_evenement 
	FROM Festival NATURAL JOIN Date_evenement
	WHERE id_date_evenement = NEW.id_date_evenement;
	IF NOT FOUND THEN
		RAISE 'Trigger sur Concert : L evenement indiqué n est pas un festival';
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
BEGIN
	PERFORM id_evenement 
	FROM Exposition NATURAL JOIN Date_evenement
	WHERE id_date_evenement = NEW.id_date_evenement;
	IF NOT FOUND THEN
		RAISE 'Trigger sur Animation : L evenement indiqué n est pas une exposition';
		RETURN NULL;
	END IF;

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER animation_trigger_insert_update
BEFORE INSERT OR UPDATE on Animation FOR EACH ROW
	EXECUTE PROCEDURE animation_trigger_insert_update();