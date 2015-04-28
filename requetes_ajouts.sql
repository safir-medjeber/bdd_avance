-- Reserve un evenement a partir d'un nom de membre
-- (Appelle un INSERT qui appelle un trigger puis envoie un e-mail de confirmation)
DROP FUNCTION IF EXISTS reserver(Membre.pseudo_membre%type, Date_Evenement.id_date_evenement%type) ;

CREATE OR REPLACE FUNCTION reserver(
	pseudo_membre		Membre.pseudo_membre%type,
	id_date_evenement	Date_Evenement.id_date_evenement%type
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

-- Envoi d'un mail
CREATE OR REPLACE FUNCTION envoyer_message(login_membre VARCHAR, objet_message VARCHAR, texte_message VARCHAR)
RETURNS BOOLEAN AS $$
	membre INTEGER;

DECLARE
	-- Recherche de l'id_membre
	SELECT id_membre INTO membre FROM Membre WHERE login_membre = $1;

	INSERT INTO Message VALUES ()

$$ LANGUAGE plpgsql;

-- Envoie d'un mail groupé lié à un evenement


-- 