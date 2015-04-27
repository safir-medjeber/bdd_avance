CREATE TRIGGER add_date_evenement
BEFORE INSERT OR UPDATE 
ON Date_Evenement
FOR EACH ROW

DECLARE
   compteur INTEGER;
   
BEGIN 
	compteur = 
		(SELECT count(*) as c
		FROM 		 Date_Evenement
		NATURAL JOIN Evenement_Culturel
		NATURAL JOIN Lieu
		WHERE 
			-- TODO : Verifier le lieu
			(NEW.date_debut_evenement BETWEEN date_debut_evenement AND date_fin_evenement)
			AND 
			(NEW.date_debut_evenement BETWEEN date_debut_evenement AND date_fin_evenement)
		).c;

EXCEPTION WHEN
	-- Une nouvelle date n'en chevauche pas une autre
	compteur > 0
	OR
	-- Une date de fin doit être après la date de début
	date_fin <= date_debut
	OR
	-- Une nouvelle date doit être dans le futur
	date_debut <= (SELECT aujourdhui FROM AUJOURDHUI AS c).c

END;