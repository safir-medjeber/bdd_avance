-- Reserve un evenement a partir d'un nom de membre
-- (Appelle un INSERT qui appelle un trigger puis envoie un e-mail de confirmation)
DROP FUNCTION IF EXISTS reserver(Membre.nom_membre%type,Date_Evenement.id_date_evenement%type) ;

CREATE OR REPLACE FUNCTION reserver(
	nom_membre			Membre.nom_membre%type,
	id_date_evenement	Date_Evenement.id_date_evenement%type
)
RETURNS VOID AS $$
BEGIN
	-- Insertion de la requete
	INSERT INTO Reservation (id_membre, id_date_evenement) 
	VALUES 
	(nom_membre, id_date_evenement);
	-- Envoie de l'e mail de confirmation
	-- IF @@ROWCOUNT 
	-- TODO
END;
$$ LANGUAGE plpgsql;

-- Programmer date UNIQUE d'evenement

-- Envoi d'un mail


-- Envoie d'un mail groupé lié à un evenement


-- 