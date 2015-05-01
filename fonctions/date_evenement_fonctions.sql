---------------------------------------------------------
-- Renvoie la capacite totale d'une date d'evenement
---------------------------------------------------------
CREATE OR REPLACE FUNCTION date_evenement_capaciteTotale(idDateEvent INTEGER)
RETURNS INTEGER AS $$
DECLARE
	nb INTEGER;
BEGIN
	SELECT capacite_lieu INTO nb
	FROM Date_Evenement NATURAL JOIN Evenement NATURAL JOIN Lieu
	WHERE id_date_evenement = idDateEvent;

	return nb;
END $$ LANGUAGE plpgsql;


---------------------------------------------------------
-- Renvoie le nombre de places restantes de la date
---------------------------------------------------------
CREATE OR REPLACE FUNCTION date_evenement_nbPlacesRestantes(idDateEvent INTEGER)
RETURNS INTEGER AS $$
DECLARE
	capacite INTEGER = date_evenement_capaciteTotale(idDateEvent);
	nb_resa INTEGER;
BEGIN
	-- Nombre de reservation
	SELECT count(*) INTO nb_resa
	FROM Reservation
	WHERE id_date_evenement = idDateEvent;

	-- Capacite de la date d'evenement
	IF (capacite - nb_resa) <= 0 THEN
		RETURN 0;
	ELSE
		RETURN capacite - nb_resta;
	END IF;
END $$ LANGUAGE plpgsql;