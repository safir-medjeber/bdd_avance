---------------------------------------------------------
-- Renvoie la capacite totale d'une date d'evenement
---------------------------------------------------------
CREATE OR REPLACE FUNCTION date_evenement_capaciteTotale(idDateEvent INTEGER)
RETURNS INTEGER AS $$
DECLARE
	nb INTEGER;
BEGIN
	SELECT capacite_lieu INTO nb
	FROM Date_Evenement NATURAL JOIN Evenement_culturel NATURAL JOIN Lieu
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
		RETURN capacite - nb_resa;
	END IF;
END $$ LANGUAGE plpgsql;

---------------------------------------------------------
-- Renvoie le prix d'une date d'evenement en tenant compte
-- des reductions 
---------------------------------------------------------
CREATE OR REPLACE FUNCTION date_evenement_prix(idDateEvent INTEGER)
RETURNS INTEGER AS $$
DECLARE
	pourcent INTEGER;
	dateEvent TIMESTAMP; -- La difference entre today et la date event
	prix_base INTEGER;
BEGIN
	-- On rempli les champs
	SELECT date_evenement, pourcentage_reduction_evenement, prix_date_evenement
	INTO dateEvent, pourcent, prix_base
	FROM Evenement_culturel NATURAL JOIN Date_Evenement
	WHERE id_date_evenement = idDateEvent;

	IF dateEvent - TODAY() <= '5 days' AND pourcent IS NOT NULL THEN
		return prix_base - (pourcent::FLOAT/100)*prix_base;
	ELSE
		return prix_base;
	END IF;

END $$ LANGUAGE plpgsql;