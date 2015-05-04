--------------------------------------------------------------------------------
-- Retourne le nom et la date d'un evenement a partir de son id_date
--------------------------------------------------------------------------------
CREATE OR REPLACE function get_info_event(idDateEvent INTEGER) RETURNS TABLE(nom_evenement varchar, date_evenement TIMESTAMP)as $$
DECLARE
	name_event TEXT:='';
	date_event TIMESTAMP;
	reponse text := '';
BEGIN
	RETURN QUERY EXECUTE 'select nom_evenement, date_evenement from date_evenement natural join evenement_culturel where id_date_evenement='||idDateEvent;
END
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Retourne le nom  d'un evenement a partir de son identifiant
--------------------------------------------------------------------------------
CREATE OR REPLACE function get_name_event(idEvent INTEGER) RETURNS TEXT as $$
DECLARE

	reponse text := '';
BEGIN
	select nom_evenement, date_evenement from date_evenement natural join evenement_culturel where id_evenement= idEvent into reponse;
	return reponse;
END;
$$ LANGUAGE plpgsql;




--------------------------------------------------------------------------------
-- Determine le ratio homme, femme sur la plateforme
--------------------------------------------------------------------------------
CREATE OR REPLACE function ratio_homme_femme_sur_plateforme(idAppelant INTEGER) RETURNS text as $$
DECLARE
	femme INTEGER := 0;
	total INTEGER := 0;
	pourcentageH  INTEGER :=0;
	pourcentageF  INTEGER :=0;
	reponse text := '';
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;

	SELECT count(*)  INTO femme FROM membre WHERE sexe_membre='F';
    	SELECT count(*)  INTO total FROM membre;	
    	pourcentageF:= (femme*100)/total;
    	pourcentageH := 100 - pourcentageF ;
    	reponse := 'pourcentage d''homme: ' || pourcentageH || chr(10) || 'pourcentage de femme: ' || pourcentageF  ;
	RETURN reponse;
END
$$ LANGUAGE plpgsql;




--------------------------------------------------------------------------------
-- Determine le ratio homme, femme d'une représentation d'un evenement 
--------------------------------------------------------------------------------
CREATE OR REPLACE function ratio_homme_femme_par_evenement(idAppelant INTEGER, idDateEvent INTEGER) RETURNS text as $$
DECLARE
	femme INTEGER := 0;
	total INTEGER := 0;
	pourcentageH  INTEGER :=0;
	pourcentageF  INTEGER :=0;
	reponse text := '';
	name_event text :='';
	date_event TIMESTAMP;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;

	SELECT count(*) from reservation  natural join membre where id_date_evenement=idDateEvent and sexe_membre='F' into femme;
    	SELECT count(*) from reservation  natural join membre where id_date_evenement=idDateEvent into total;	
    	pourcentageF:= (femme*100)/total;
    	pourcentageH := 100 - pourcentageF ;
	select * from get_info_event(idDateEvent) into name_event, date_event;
	reponse := 'homme: ' || pourcentageH ||'% '|| chr(9) || 'femme: ' || pourcentageF || '%'||chr(9)||' pour ' || name_event ||' le '||date_event;
	
	RETURN reponse;
END
$$ LANGUAGE plpgsql;




--------------------------------------------------------------------------------
-- Determine le ratio homme femme de chaque representation de tous les evenements
--------------------------------------------------------------------------------
CREATE OR REPLACE function ratio_homme_femme_evenements(idAppelant INTEGER) RETURNS text as $$
DECLARE
	idEvent record;
	reponse text:= '';
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;
	
	FOR idEvent in
   	    select id_date_evenement from date_evenement
    	LOOP
	    reponse := reponse || ratio_homme_femme_par_evenement(idAppelant, idEvent.id_date_evenement) || chr(10);
     	END LOOP;

RETURN reponse ;
END
$$ LANGUAGE plpgsql;




--------------------------------------------------------------------------------
-- Determine le taux de remplissage d'un evenement pour une representation
--------------------------------------------------------------------------------
CREATE OR REPLACE function taux_de_remplissage_par_evenement(idAppelant INTEGER, idDateEvent INTEGER) RETURNS text as $$
DECLARE
	capacite INTEGER := 0;
	nbParticipant  INTEGER := 0;
	pourcentage  FLOAT := 0;
	reponse text := '';
	name_event text :='';
	date_event TIMESTAMP;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;

	SELECT count(*) from reservation where id_date_evenement = idDateEvent INTO nbParticipant;
	capacite := date_evenement_capaciteTotale(idDateEvent);

	select * from get_info_event(idDateEvent) into name_event, date_event;
	pourcentage := (nbParticipant*100)/capacite;
    	reponse := 'Taux de remplissage de '|| pourcentage || '%'|| chr(9) ||' pour ' || name_event ||' le '||date_event ; 

	RETURN reponse;
END
$$ LANGUAGE plpgsql;



--------------------------------------------------------------------------------
-- Determine le taux de remplissage de chaque representation de tous les evenements
--------------------------------------------------------------------------------
CREATE OR REPLACE function taux_de_remplissage(idAppelant INTEGER) RETURNS text as $$
DECLARE
	idEvent record;
	reponse text:= '';
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;
	
	FOR idEvent in
   	    select id_date_evenement from date_evenement
    	LOOP
	    reponse := reponse || taux_de_remplissage_par_evenement(idAppelant, idEvent.id_date_evenement) || chr(10);
     	END LOOP;

RETURN reponse ;
END
$$ LANGUAGE plpgsql;




--------------------------------------------------------------------------------
-- Determine le taux de remplissage moyen d'un evenement à partir de son idenfiant
-----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION taux_de_remplissage_moyen_par_evenement(idAppelant INTEGER, idEvent INTEGER) RETURNS TEXT as $$
DECLARE
	capacite INTEGER := 0;
	nbParticipantTotal  INTEGER := 0;
	nbParticipant  INTEGER := 0;
	pourcentage  FLOAT := 0;
	reponse TEXT := '';
	name_event TEXT :='';
	date_event TIMESTAMP;
	it RECORD;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;
	
	FOR it IN
	    SELECT id_date_evenement FROM Date_evenement WHERE id_evenement = idEvent
	LOOP
		SELECT count(*) FROM reservation WHERE id_date_evenement = it.id_date_evenement INTO nbParticipant;
		capacite := capacite + date_evenement_capaciteTotale(it.id_date_evenement );
		nbParticipantTotal := nbParticipantTotal + nbParticipant;
     	END LOOP;
		name_event := get_name_event(idEvent);
		pourcentage := (nbParticipantTotal*100)/capacite;
    		reponse := 'Taux de remplissage moyen de '|| pourcentage || '%'|| chr(9) ||' pour ' || name_event  ; 
	
	RETURN reponse;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Determine le taux de remplissage moyen de tous les évènements
-----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION taux_de_remplissage_moyen(idAppelant INTEGER) RETURNS TEXT as $$
DECLARE
	idEvent record;
	reponse text:= '';
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;
	FOR idEvent IN
   	    SELECT DISTINCT id_evenement FROM date_evenement
    	LOOP
	    reponse := reponse || taux_de_remplissage_moyen_par_evenement(idAppelant, idEvent.id_evenement) || chr(10);
     	END LOOP;

RETURN reponse ;
END;
$$ LANGUAGE plpgsql;



--------------------------------------------------------------------------------
-- Determine le revenu total d'un organisateur a partir de son identifiant
--------------------------------------------------------------------------------
CREATE OR REPLACE function revenu_par_organisateur(idAppelant INTEGER, idMembre INTEGER) RETURNS text as $$
DECLARE
	idEvent record;
	prixPlace record;
	reponse text := '';
	nom text := '';
	events text := 'Ses évènements : '|| chr(10);
	prenom text := '';
	revenu INTEGER :=0;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;
	
	SELECT nom_membre, prenom_membre from membre where id_membre=idMembre INTO  nom, prenom;

	FOR idEvent IN
   	    SELECT id_evenement,  nom_evenement , date_evenement FROM evenement_culturel NATURAL JOIN organise NATURAL JOIN date_evenement WHERE id_membre=idMembre
    	LOOP
	events:= events ||chr(9)||'-> '''|| idEvent.nom_evenement||''' le '|| idEvent.date_evenement||chr(10);		
	    FOR prixPlace IN
	    	SELECT prix_date_evenement FROM reservation NATURAL JOIN date_Evenement WHERE id_evenement=idEvent.id_evenement
	    LOOP
		revenu:=revenu+prixPlace.prix_date_evenement;
	    END LOOP;
     	END LOOP;
	reponse:= 'Organisateur : ' ||nom||' '||prenom||chr(10);
	reponse:= reponse ||'Revenu : ' || revenu || '€'||chr(10);
	reponse:= reponse ||events;
	reponse:= reponse || '-------------------------------------------------------------------------------------'||chr(10);
RETURN reponse ;
END;
$$ LANGUAGE plpgsql;



--------------------------------------------------------------------------------
-- Determine le revenu total de chacun des organisateurs
------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION revenu_organisateurs(idAppelant INTEGER) RETURNS TEXT AS $$
DECLARE
	idMembre record;
	reponse text := '';
	nom text := '';
	events text := 'Ses évènements : '|| chr(10);
	revenu INTEGER :=0;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN NULL;
	END IF;
	
	FOR idMembre in
   	   SELECT DISTINCT id_membre FROM membre NATURAL JOIN organise
    	LOOP
	   reponse:= reponse || revenu_par_organisateur(idAppelant, idMembre.id_membre);
     	END LOOP;
RETURN reponse ;
END;
$$ LANGUAGE plpgsql;











