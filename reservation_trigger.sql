---------------------------------------------------------
-- BEFORE INSERT et UPDATE
-- On vérifie qu'il reste des places
---------------------------------------------------------
CREATE OR REPLACE FUNCTION reservartion_trigger_before_insert_update()
RETURNS TRIGGER AS $$
DECLARE
	nbReservation INTEGER;
	capacite INTEGER;
BEGIN
	-- On calcule le nombre de reservation sur cet date d'evenement
	SELECT count(*) INTO nbReservation
	FROM Reservation
	WHERE id_date_evenement = NEW.id_date_evenement;

	-- On recupere la capacité de l'evenement
	SELECT capacite_lieu INTO capacite
	FROM date_evenement NATURAL JOIN Evenement_Culturel NATURAL JOIN Lieu
	WHERE id_date_evenement = NEW.id_date_evenement;

	-- On refuse si l'evenement est complet
	IF nbReservation >= capacite THEN
		Raise 'L evenement est complet !';
		RETURN NULL;
	END IF;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER reservartion_trigger_before_insert_update
BEFORE INSERT OR UPDATE ON Reservation FOR EACH ROW
	EXECUTE PROCEDURE reservartion_trigger_before_insert_update();

---------------------------------------------------------
-- AFTER INSERT et UPDATE
-- On envoie un mail de confirmation au membre
---------------------------------------------------------
CREATE OR REPLACE FUNCTION reservartion_trigger_insert_update()
RETURNS TRIGGER AS $$
DECLARE
	nomEvent VARCHAR;
	dateEvent TIMESTAMP;
BEGIN
	SELECT nom_evenement, date_evenement INTO nomEvent, dateEvent
	FROM date_evenement NATURAL JOIN evenement_culturel
	WHERE id_date_evenement = NEW.id_date_evenement ;

	PERFORM envoyer_message(NEW.id_membre, 
		'Confirmation de reservation',
		'Bonjour, nous vous confirmons bien la reservation a l evenement '||nomEvent||' le '||dateEvent||'.'
	);
END $$ LANGUAGE plpgsql;

CREATE TRIGGER reservartion_trigger_insert_update
AFTER INSERT OR UPDATE ON Reservation FOR EACH ROW
	EXECUTE PROCEDURE reservartion_trigger_insert_update();

---------------------------------------------------------
-- AFTER DELETE
-- On envoie un mail et un avoir au membre
---------------------------------------------------------
CREATE OR REPLACE FUNCTION reservartion_trigger_after_delete()
RETURNS TRIGGER AS $$
DECLARE
	nomEvent VARCHAR;
	dateEvent TIMESTAMP;
	prixEvent INTEGER;
BEGIN
	-- On recupere le nom, la date et le prix de l'event
	SELECT nom_evenement, date_evenement, prix_date_evenement
	INTO nomEvent, dateEvent, prixEvent
	FROM date_evenement NATURAL JOIN evenement_culturel
	WHERE id_date_evenement = OLD.id_date_evenement;

	PERFORM envoyer_message(OLD.id_membre, 
		'Demande d annulation prise en compte',
		'Bonjour, nous vous confirmons bien l annulation reservation a l evenement '||nomEvent||' le '||dateEvent||'.'
	);
	PERFORM avoir_creer(OLD.id_membre, OLD.id_date_evenement);
END $$ LANGUAGE plpgsql;

CREATE TRIGGER reservartion_trigger_after_delete
AFTER INSERT OR UPDATE ON Reservation FOR EACH ROW
	EXECUTE PROCEDURE reservartion_trigger_after_delete();