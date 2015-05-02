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
-- Determine le ratio homme, femme sur la plateforme
--------------------------------------------------------------------------------
CREATE OR REPLACE function ratio_homme_femme_sur_plateforme() RETURNS text as $$
DECLARE
	femme INTEGER := 0;
	total INTEGER := 0;
	pourcentageH  INTEGER :=0;
	pourcentageF  INTEGER :=0;
	reponse text := '';
BEGIN
	SELECT count(*)  INTO femme FROM membre WHERE sexe_membre='F';
    	SELECT count(*)  INTO total FROM membre;	
    	pourcentageF:= (femme*100)/total;
    	pourcentageH := 100 - pourcentageF ;
    	reponse := 'pourcentage d''homme: ' || pourcentageH || chr(10) || 'pourcentage de femme: ' || pourcentageF  ;
	RETURN reponse;
END
$$ LANGUAGE plpgsql;
--select ratio_homme_femme_sur_plateforme();





CREATE OR REPLACE function ratio_homme_femme_event(idDateEvent INTEGER) RETURNS text as $$
DECLARE
	femme INTEGER := 0;
	total INTEGER := 0;
	pourcentageH  INTEGER :=0;
	pourcentageF  INTEGER :=0;
	reponse text := '';
	name_event text :='';
	date_event TIMESTAMP;
BEGIN

	SELECT count(*) from reservation  natural join membre where id_date_evenement=idDateEvent and sexe_membre='F' into femme;
    	SELECT count(*) from reservation  natural join membre where id_date_evenement=idDateEvent into total;	
    	pourcentageF:= (femme*100)/total;
    	pourcentageH := 100 - pourcentageF ;
	select * from get_info_event(idDateEvent) into name_event, date_event;
	reponse := 'homme: ' || pourcentageH ||'% '|| chr(9) || 'femme: ' || pourcentageF || '%'||chr(9)||' pour ' || name_event ||' le '||date_event;
	
	RETURN reponse;
END
$$ LANGUAGE plpgsql;
--select ratio_homme_femme_par_evenement();



CREATE OR REPLACE function ratio_homme_femme_par_evenement() RETURNS text as $$
DECLARE
	idEvent record;
	reponse text:= '';
BEGIN
	FOR idEvent in
   	    select id_date_evenement from date_evenement
    	LOOP
	    reponse := reponse || ratio_homme_femme_event(idEvent.id_date_evenement) || chr(10);
     	END LOOP;

RETURN reponse ;
END
$$ LANGUAGE plpgsql;



--------------------------------------------------------------------------------
-- Determine le taux de remplissage d'un evenement pour une representation
--------------------------------------------------------------------------------
CREATE OR REPLACE function taux_de_remplissage_event(idDateEvent INTEGER) RETURNS text as $$
DECLARE
	capacite INTEGER := 0;
	nbParticipant  INTEGER := 0;
	pourcentage  FLOAT := 0;
	reponse text := '';

	name_event text :='';
	date_event TIMESTAMP;
BEGIN
	SELECT count(*) from reservation where id_date_evenement = idDateEvent INTO nbParticipant;
	capacite := date_evenement_capaciteTotale(idDateEvent);

	select * from get_info_event(idDateEvent) into name_event, date_event;
	pourcentage := (nbParticipant*100)/capacite;
    	reponse := 'Taux de remplissage de '|| pourcentage || '%'|| chr(9) ||' pour ' || name_event ||' le '||date_event ; 

	RETURN reponse;
END
$$ LANGUAGE plpgsql;











--------------------------------------------------------------------------------
-- Determine le taux de remplissage de chaque date de representation d'un evenement
--------------------------------------------------------------------------------
CREATE OR REPLACE function taux_de_remplissage() RETURNS text as $$
DECLARE
	idEvent record;
	reponse text:= '';
BEGIN
	FOR idEvent in
   	    select id_date_evenement from date_evenement
    	LOOP
	    reponse := reponse || taux_de_remplissage_event(idEvent.id_date_evenement) || chr(10);
     	END LOOP;

RETURN reponse ;
END
$$ LANGUAGE plpgsql;

--select taux_de_remplissage();

