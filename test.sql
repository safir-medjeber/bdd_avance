
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
		     requete := requete ||' NATURAL JOIN piece_theatre';
		WHEN event_theatre THEN
		     requete := requete ||' NATURAL JOIN exposition ';
		WHEN event_festival THEN	     
		     requete := requete ||' NATURAL JOIN festival ';
	END CASE;
	requete :=  requete || 'NATURAL JOIN date_evenement WHERE date_evenement BETWEEN '''|| date_debut ||''' AND '''|| date_fin ||''' ';
	requete :=  requete || 'AND prix_date_evenement BETWEEN '|| prix_min || ' AND ' || prix_max || ' ';
	requete :=  requete || 'AND type_festival like ''%'|| type_evenement ||'%''';

	RETURN QUERY EXECUTE requete ;
END

$$ language plpgsql;

SELECT searchEvent(false, false, true, '2015-01-12', '2015-04-17', 60, 80, 'cinema');





