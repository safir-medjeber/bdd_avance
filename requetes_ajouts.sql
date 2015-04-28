-- Reserve un evenement a partir d'un nom de membre
-- (Appelle un INSERT qui appelle un trigger puis envoie un e-mail de confirmation)
CREATE OR REPLACE FUNCTION reserver(
	pseudo_membre		VARCHAR,
	id_date_evenement	INTEGER
)
RETURNS VOID AS $$
BEGIN
	-- Insertion de la requete
	INSERT INTO Reservation (id_membre, id_date_evenement) 
	VALUES (nom_membre, id_date_evenement);
	-- Envoie de l'e mail de confirmation
	-- IF @@ROWCOUNT 
	-- TODO
END;
$$ LANGUAGE plpgsql;


-- Envoie d'un mail groupé via une liste de id_membre
