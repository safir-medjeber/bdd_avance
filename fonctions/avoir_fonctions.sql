-------------------------------------------------------------
-- Crée un avoir correspondant au prix d'une date d'evenement
-------------------------------------------------------------
-- TODO : Tester la fonction 
CREATE OR REPLACE FUNCTION avoir_creer(idMembre INTEGER, idDateEvent INTEGER)
RETURNS VOID AS $$
DECLARE
	prixEvent INTEGER;
BEGIN
	-- On recupere le prix de l'event
	SELECT prix_classe_prix INTO prixEvent 
	FROM Date_Evenement WHERE id_date_evenement = $2;

	-- On crée l'avoir
	INSERT INTO Avoir (id_membre, montant_avoir)
	VALUES (idMembre, prixEvent);
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION avoir_creer(login VARCHAR, idDateEvent INTEGER)
RETURNS VOID AS $$
DECLARE
	idMembre INTEGER := membre_getID(login);
BEGIN
	PERFORM avoir_creer(idMembre, $2);
END $$ LANGUAGE plpgsql;

-------------------------------------------------------------
-- Liste les avoirs d'un membre
-------------------------------------------------------------
-- TODO : A tester
CREATE OR REPLACE FUNCTION avoir_lister(idMembre INTEGER)
RETURNS TABLE (id_avoir INTEGER, montant_avoir INTEGER) AS $$
BEGIN
	RETURN QUERY SELECT Avoir.id_avoir, Avoir.montant_avoir FROM Avoir WHERE id_membre = idMembre;
END $$ LANGUAGE plpgsql;