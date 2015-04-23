-- Ajouter Piece theatre


-- Programmer date UNIQUE d'evenement
CREATE OR REPLACE FUNCTION
programmer_date_evenement(
	id_evenement 	Date_Evenement.id_evenement%type, 
	date_debut 		Date_Evenement.date_debut_evenement%type, 
	date_fin 		Date_Evenement.date_fin_evenement%type
)
AS $$
BEGIN
	-- On verifie qu'une nouvelle date n'en chevauche pas une autre
	IF 		
		count(
			SELECT id_date_evenemnt
			FROM 		 Date_Evenement
			NATURAL JOIN Evenement_Culturel
			NATURAL JOIN Lieu
			WHERE 
				($1 BETWEEN date_debut_evenement AND date_fin_evenement)
				AND 
				($2 BETWEEN date_debut_evenement AND date_fin_evenement)
		) > 0;
	THEN
		INSERT INTO Date_Evenement 
		(date_debut_evenement, date_fin_evenement, id_evenement)
		VALUES
		(date_debut, date_fin)
	ELSE
		RAISE NOTICE "Un evenement a deja lieu a cette date"
	END IF;
END;
$$ language plpgpsql;

-- Programmer date RECURRENT d'evenement
-- TODO

-- Envoi d'un mail


-- Envoie d'un mail groupé lié à un evenement


-- 