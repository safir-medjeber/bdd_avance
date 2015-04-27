-- Programmer date UNIQUE d'evenement
CREATE OR REPLACE FUNCTION
programmer_date_evenement(
	id_evenement 	Date_Evenement.id_evenement%type, 
	date_debut 		Date_Evenement.date_debut_evenement%type, 
	date_fin 		Date_Evenement.date_fin_evenement%type
)
RETURNS VOID
AS $$

DECLARE
	compteur INTEGER;

BEGIN
	compteur = 
		(SELECT count(*) as c
		FROM 		 Date_Evenement
		NATURAL JOIN Evenement_Culturel
		NATURAL JOIN Lieu
		WHERE 
			($1 BETWEEN date_debut_evenement AND date_fin_evenement)
			AND 
			($2 BETWEEN date_debut_evenement AND date_fin_evenement)
		).c;

	IF
		-- Une nouvelle date n'en chevauche pas une autre
		compteur > 0

		OR
		-- Une date de fin doit être après la date de début
		date_fin <= date_debut

		OR
		-- Une nouvelle date doit être dans le futur
		date_debut <= (SELECT aujourdhui FROM AUJOURDHUI AS c).c
		
	THEN
		RAISE NOTICE 'Un evenement a deja lieu a cette date ou la date est déjà passée.';
	ELSE
		INSERT INTO Date_Evenement 
		(date_debut_evenement, date_fin_evenement, id_evenement)
		VALUES
		(date_debut, date_fin);
	END IF;
END;
$$ language plpgsql;

-- Programmer date RECURRENT d'evenement
-- TODO

-- Envoi d'un mail


-- Envoie d'un mail groupé lié à un evenement


-- 