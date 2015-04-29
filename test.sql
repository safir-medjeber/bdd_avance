
-- Determine le ratio homme, femme sur la plateforme
CREATE OR REPLACE function ratio_homme_femme_sur_plateforme() RETURNS text as $$
DECLARE
	femme INTEGER := 0;
	total INTEGER := 0;
	pourcentageH  INTEGER :=0;
	pourcentageF  INTEGER :=0;
	reponse text := 0;
BEGIN
	SELECT count(*)  INTO femme FROM membre WHERE sexe_membre='F';
    	SELECT count(*)  INTO total FROM membre;	
    	pourcentageF:= (femme*100)/total;
    	pourcentageH := 100 - pourcentageF ;
    	reponse := 'pourcentage d''homme: ' || pourcentageH || chr(10) || 'pourcentage de femme: ' || pourcentageF;
	RETURN reponse;
END
$$ LANGUAGE plpgsql;

--select ratio_homme_femme_sur_plateforme();




--drop function searchEvent(boolean, boolean, boolean);


CREATE OR REPLACE  FUNCTION searchEvent(event_theatre boolean, event_exposition boolean,  event_festival boolean, date_debut date, date_fin date, prix_min INTEGER, prix_max INTEGER, type_evenement TEXT)
       RETURNS TABLE(nom_evenement varchar) as $$
DECLARE
       requete text := 'select evenement_culturel.nom_evenement from evenement_culturel';
BEGIN
	CASE
		WHEN event_theatre THEN
		     requete := requete ||' NATURAL JOIN piece_theatre ';
		WHEN event_theatre THEN
		     requete := requete ||' NATURAL JOIN exposition ';
		WHEN event_festival THEN	     
		     requete := requete ||' NATURAL JOIN festival ';
	END CASE;


	IF date_debut IS NOT NULL and date_fin IS NOT NULL THEN
	   requete :=  requete || 'NATURAL JOIN date_evenement WHERE date_evenement BETWEEN '''|| date_debut ||''' AND '''|| date_fin ||''' ';
	END IF;


	IF  type_evenement IS NOT NULL  and event_theatre THEN
	    requete :=  requete || 'AND genre_piece like ''%'|| type_evenement ||'%''';
	END IF;


	IF  type_evenement IS NOT NULL  and event_festival THEN
	    requete :=  requete || 'AND type_festival like ''%'|| type_evenement ||'%''';
	END IF;
	

	RETURN QUERY EXECUTE requete ;
END

$$ language plpgsql;

---SELECT searchEvent(false, false, true, null, null, 0, 80, 'cin');


SELECT searchEvent(true, false, false, '2015-01-02', '2016-12-02', 0, 80, 'Comique');


