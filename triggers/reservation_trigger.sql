---------------------------------------------------------
-- BEFORE INSERT et UPDATE
-- On vérifie qu'il reste des places
---------------------------------------------------------
CREATE OR REPLACE FUNCTION reservartion_trigger_before_insert_update()
RETURNS TRIGGER AS $$
DECLARE
	nbReservation INTEGER;
	capacite INTEGER;
	dateEvent TIMESTAMP;
BEGIN
	-- On calcule le nombre de reservation sur cet date d'evenement
	SELECT count(*) INTO nbReservation
	FROM Reservation
	WHERE id_date_evenement = NEW.id_date_evenement;

	-- On recupere la capacité de l'evenement
	SELECT capacite_lieu, date_evenement INTO capacite, dateEvent
	FROM date_evenement NATURAL JOIN Evenement_Culturel NATURAL JOIN Lieu
	WHERE id_date_evenement = NEW.id_date_evenement;

	-- On refuse si l'evenement est complet
	IF nbReservation >= capacite THEN
		Raise 'L''évènement à est complet !';
		RETURN NULL;
	END IF;

	-- On refuse si l'evenement est déjà passé
	IF dateEvent < TODAY() THEN
		Raise 'L evenement est déjà passé';
		RETURN NULL;
	END IF;

	RETURN NEW;
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

	RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER reservartion_trigger_insert_update
AFTER INSERT OR UPDATE ON Reservation FOR EACH ROW
	EXECUTE PROCEDURE reservartion_trigger_insert_update();

---------------------------------------------------------
-- AFTER DELETE
-- On envoie un mail et un avoir au membre
---------------------------------------------------------
CREATE OR REPLACE FUNCTION reservartion_trigger_before_delete()
RETURNS TRIGGER AS $$
DECLARE
	nomEvent VARCHAR;
	dateEvent TIMESTAMP;
	prixEvent INTEGER;
	contenu_msg VARCHAR;
BEGIN
	-- On recupere le nom, la date et le prix de l'event
	SELECT nom_evenement, date_evenement, prix_date_evenement
	INTO nomEvent, dateEvent, prixEvent
	FROM date_evenement NATURAL JOIN evenement_culturel
	WHERE id_date_evenement=OLD.id_date_evenement;
	
	-- Envoi du mail
	contenu_msg := 'Bonjour, nous vous confirmons le remboursement de la reservation a l evenement '||nomEvent||' le '||dateEvent::VARCHAR||'. Un avoir a été crédité dans votre compte.';
	PERFORM envoyer_message(OLD.id_membre, 'Annulation d un evenement', contenu_msg);
	PERFORM avoir_creer(OLD.id_membre, OLD.id_date_evenement);

	RETURN OLD;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER reservartion_trigger_before_delete
BEFORE DELETE ON Reservation FOR EACH ROW
	EXECUTE PROCEDURE reservartion_trigger_before_delete();
