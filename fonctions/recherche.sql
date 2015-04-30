CREATE OR REPLACE  FUNCTION searchEvent(event_theatre boolean, event_exposition boolean,  event_festival boolean, date_debut date, date_fin date, prix_min INTEGER, prix_max INTEGER, type_evenement TEXT)

RETURNS TABLE(nom_evenement varchar, date_evenement TIMESTAMP, 	prix_date_evenement INTEGER) as $$
DECLARE
       requete text := 'select nom_evenement, date_evenement,	prix_date_evenement from evenement_culturel ';
BEGIN


-------------------gestion categorie evenement--------------------------------
	IF event_theatre OR event_exposition  OR event_festival THEN
	   requete := requete ||'natural join(';

	   IF event_theatre THEN
	   	requete := requete ||'SELECT id_evenement, genre_piece  as genre from piece_theatre';
	   END IF;


	   IF event_exposition  THEN
	      IF event_theatre  THEN
	   	requete := requete ||' UNION SELECT id_evenement, type_exposition as genre from exposition';
	      ELSE
		requete := requete ||'SELECT id_evenement, type_exposition  as genre from exposition';
	      END IF;
	   END IF;


	   IF event_festival THEN	 
	      IF event_theatre OR event_exposition  THEN
	 	requete := requete ||' UNION SELECT id_evenement, type_festival as genre from festival';
	      ELSE
		requete := requete ||'SELECT id_evenement, type_festival as genre from festival';
	      END IF;
	   END IF;

	   requete := requete || ') as foo ';
	END IF;

  	requete := requete || 'NATURAL JOIN date_evenement ';




-------------------------gestion date--------------------------------------------
	IF date_debut IS NOT NULL AND date_fin IS NOT NULL THEN
	   requete :=  requete || 'WHERE date_evenement BETWEEN '''|| date_debut ||''' AND '''|| date_fin ||''' ';
	ELSIF date_debut IS NOT NULL THEN
	     requete :=  requete || 'WHERE date_evenement > '''|| date_debut ||''' ';
	ELSIF date_fin IS NOT NULL THEN
	     requete :=  requete || 'WHERE date_evenement < '''|| date_fin ||''' ';
	END IF;



-------------------------gestion prix-------------------------------------------
        IF prix_min IS NOT NULL OR prix_max IS NOT NULL THEN
	   IF date_debut IS NOT NULL OR date_fin IS NOT NULL THEN
	        requete := requete || 'AND ';
	   ELSE
		requete := requete || 'WHERE ';
	   END IF;    

	   IF prix_min IS NOT NULL AND prix_max IS NOT NULL THEN
	        requete :=  requete || 'prix_date_evenement BETWEEN '''|| prix_min ||''' AND '''|| prix_max ||''' ';
 	   ELSIF prix_min IS NOT NULL THEN
	     requete :=  requete || 'prix_date_evenement > '''|| prix_min ||''' ';
	   ELSIF prix_max IS NOT NULL THEN
	     requete :=  requete || 'prix_date_evenement < '''|| prix_max ||''' ';
	   END IF;
	END IF;


------------------------gestion genre-------------------------------------------
	IF type_evenement IS NOT NULL THEN

 	IF date_debut IS NOT NULL OR date_fin IS NOT NULL OR prix_min IS NOT NULL OR prix_max IS NOT NULL THEN
	        requete := requete || 'AND ';
	   ELSE
		requete := requete || 'WHERE ';
	   END IF;
	   
	   IF event_theatre THEN
	       requete :=  requete || 'genre like ''%'|| type_evenement ||'%''';
	   END IF;

	   IF event_exposition  THEN
	      IF event_theatre  THEN 
	      	 requete :=  requete || ' AND genre like ''%'|| type_evenement ||'%''';
	      ELSE 
 	         requete :=  requete || ' genre like ''%'|| type_evenement ||'%''';
	      END IF;
	   END IF;

	  IF event_festival THEN	 
	      IF event_theatre OR event_exposition  THEN
	        requete :=  requete || ' AND genre like ''%'|| type_evenement ||'%''';
	      ELSE 
 	        requete :=  requete || ' genre like ''%'|| type_evenement ||'%''';
	      END IF;
	  END IF;
	END IF;

	RETURN QUERY EXECUTE requete ;
END;

$$ language plpgsql;

---SELECT searchEvent(false, false, true, null, null, 0, 80, 'cin');


--SELECT searchEvent(true, true, false, '2015-01-02', '2016-12-02', 0, 80, 'Comique');

