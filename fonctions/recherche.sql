--------------------------------------------------------------------------------
-- Fonction qui fourni une table contenant les evenements correspondant aux criteres passes en argument
--------------------------------------------------------------------------------

CREATE OR REPLACE  FUNCTION searchEvent_aux(event_theatre boolean, event_exposition boolean,  event_festival boolean, date_debut date, date_fin date, prix_min INTEGER, prix_max INTEGER, type_evenement TEXT)
RETURNS TABLE(id_date_evenement INTEGER, nom_evenement varchar, date_evenement TIMESTAMP, 	prix_date_evenement INTEGER) as $$
DECLARE
       requete text := 'select id_date_evenement, nom_evenement, date_evenement, prix_date_evenement from evenement_culturel ';
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


--------------------------------------------------------------------------------
-- Fonction qui fourni des informations utiles d'un evenement a partir de son nom ou une partie
--------------------------------------------------------------------------------
CREATE OR REPLACE function info_about_event(name_event TEXT) returns text as $$
DECLARE
	info_event TEXT:='';
	argv TEXT :='%'||name_event||'%';
	tmp RECORD;
BEGIN
	FOR tmp IN
	    select Date_Evenement.prix_date_evenement, Date_Evenement.id_date_evenement, Evenement_Culturel.nom_evenement, Lieu.nom_lieu, Date_evenement.date_evenement
	    from Date_Evenement
	    natural join Evenement_Culturel natural join Lieu
	    where Evenement_Culturel.nom_evenement like  argv
	LOOP
	info_event:= info_event ||'Nom   : '|| tmp.nom_evenement  || chr(10)||'Lieu  : '||  tmp.nom_lieu ||chr(10);
	info_event:= info_event	||'Date  : '|| tmp.date_evenement || chr(10)||'Prix  : '|| tmp.prix_date_evenement||'€'||chr(10);
	info_event:= info_event	||'Place : '|| date_evenement_nbPlacesRestantes(tmp.id_date_evenement)|| ' Disponible(s)' ||chr(10);
	info_event:= info_event||'-------------------------------------------------------------------------------------'||chr(10);
	END LOOP;
	
return info_event;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Fonction qui fourni des informations utiles d'un evenement a partir d'un id_date_event
--------------------------------------------------------------------------------
CREATE OR REPLACE function info_about_event_integer(idEvent INTEGER) returns text as $$
DECLARE
	info_event TEXT:='';
	tmp RECORD;
BEGIN
	FOR tmp IN
	    select Date_Evenement.prix_date_evenement, Date_Evenement.id_date_evenement, Evenement_Culturel.nom_evenement, Lieu.nom_lieu, Date_evenement.date_evenement
	    from Date_Evenement
	    natural join Evenement_Culturel natural join Lieu
	    where Date_Evenement.id_date_Evenement=idEvent
	LOOP
	info_event:= info_event ||'Nom   : '|| tmp.nom_evenement  || chr(10)||'Lieu  : '||  tmp.nom_lieu ||chr(10);
	info_event:= info_event	||'Date  : '|| tmp.date_evenement || chr(10)||'Prix  : '|| tmp.prix_date_evenement||'€'||chr(10);
	info_event:= info_event	||'Place : '|| date_evenement_nbPlacesRestantes(tmp.id_date_evenement)|| ' Disponible(s)' ||chr(10);
	info_event:= info_event||'-------------------------------------------------------------------------------------'||chr(10);
	END LOOP;
	
return info_event;
END;
$$ LANGUAGE plpgsql;





--------------------------------------------------------------------------------
-- Fonction qui affiche les evenements correspondants aux criteres fournis ainsi que leurs nombre de place disponible
--------------------------------------------------------------------------------
CREATE OR REPLACE  FUNCTION searchEvent(event_theatre boolean, event_exposition boolean,  event_festival boolean, date_debut date, date_fin date, prix_min INTEGER, prix_max INTEGER, type_evenement TEXT)
returns text as $$
DECLARE
	info_event TEXT:='';
	tmp RECORD;
BEGIN

	FOR tmp IN
	    select id_date_evenement from searchEvent_aux($1, $2, $3, $4, $5, $6, $7, $8)
	LOOP
		info_event:=info_event || info_about_event_integer(tmp.id_date_evenement); 
	END LOOP;
	
return info_event;
END;
$$ LANGUAGE plpgsql;


---SELECT searchEvent(false, false, true, null, null, 0, 80, 'cin');


--SELECT searchEvent(true, true, false, '2015-01-02', '2016-12-02', 0, 80, 'Comique');

