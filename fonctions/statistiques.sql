--------------------------------------------------------------------------------
-- Determine le ratio homme, femme sur la plateforme
--------------------------------------------------------------------------------
CREATE OR REPLACE function ratio_homme_femme_sur_plateforme(idAppelant INTEGER) 
RETURNS TABLE(ratio_homme FLOAT, ratio_femme FLOAT, 
		nombre_hommes INTEGER, nombre_femmes INTEGER, nombre_total INTEGER)
AS $$
DECLARE
	nbTotal INTEGER;
	nbFemme INTEGER;
	nbHomme INTEGER;
BEGIN
	-- Verification des droits
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonction';
	   RETURN;
	END IF;

	-- Récolte des informations
	SELECT count(*) INTO nbTotal FROM Membre;
	SELECT count(*) INTO nbFemme FROM Membre WHERE sexe_membre='F';
	nbHomme := nbTotal - nbFemme;

	-- Renvoie des resultats
	RETURN QUERY 
		SELECT 
			nbHomme::FLOAT/nbTotal*100 AS ratio_homme,
			nbFemme::FLOAT/nbTotal*100 AS ratio_femme,
			nbHomme AS nombre_hommes,
			nbFemme AS nombre_femmes,
			nbTotal AS nombre_total
	;
END
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Determine le ratio homme, femme d'une représentation d'un evenement 
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ratio_homme_femme_par_evenement(idAppelant INTEGER, idDateEvent INTEGER)
RETURNS TABLE(nom_evenement VARCHAR, date_evenement TIMESTAMP,
		ratio_homme FLOAT, ratio_femme FLOAT, 
		nombre_hommes INTEGER, nombre_femmes INTEGER, nombre_total INTEGER)
AS $$
DECLARE
	nomEvent VARCHAR;
	dateEvent TIMESTAMP;
	nbTotal INTEGER;
	nbFemme INTEGER;
	nbHomme INTEGER;
BEGIN
	-- Verification des droits
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonction';
	   RETURN;
	END IF;

	-- Récolte des informations
	-- Nom/Date evenement
	SELECT evenement_culturel.nom_evenement, date_Evenement.date_Evenement
	INTO nomEvent, dateEvent
	FROM evenement_culturel NATURAL JOIN date_Evenement
	WHERE id_date_evenement = idDateEvent;

	-- Nombre total de reservant
	SELECT count(*) INTO nbTotal
	FROM Reservation
	WHERE id_date_evenement = idDateEvent;

	-- Nombre de femme
	SELECT count(*) INTO nbFemme
	FROM Reservation NATURAL JOIN Membre
	WHERE 
		id_date_evenement = idDateEvent
		AND sexe_membre = 'F';

	-- Nombre d'homme
	nbHomme := nbTotal - nbFemme;

	-- Renvoie des resultats
	RETURN QUERY 
		SELECT
			nomEvent,
			dateEvent,
			nbHomme::FLOAT/nbTotal*100 AS ratio_homme,
			nbFemme::FLOAT/nbTotal*100 AS ratio_femme,
			nbHomme AS nombre_hommes,
			nbFemme AS nombre_femmes,
			nbTotal AS nombre_total
	;
END
$$ LANGUAGE plpgsql;




--------------------------------------------------------------------------------
-- Determine le ratio homme femme de chaque representation de tous les evenements
--------------------------------------------------------------------------------
CREATE OR REPLACE function ratio_homme_femme_evenements(idAppelant INTEGER) 
RETURNS TABLE(nom_evenement VARCHAR, date_evenement TIMESTAMP,
		ratio_homme FLOAT, ratio_femme FLOAT, 
		nombre_hommes INTEGER, nombre_femmes INTEGER, nombre_total INTEGER)
AS $$
DECLARE
	it RECORD;
	r RECORD;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonction';
	   RETURN;
	END IF;
	
	-- Derouler tous les id_date_evenement
	FOR it IN
   	    SELECT id_date_evenement FROM date_evenement
    LOOP
	    r := ratio_homme_femme_par_evenement(idAppelant, it.id_date_evenement);

	    nom_evenement := r.nom_evenement;
	    date_evenement := r.date_evenement;
	    ratio_homme := r.ratio_homme;
	    ratio_femme := r.ratio_femme;
	    nombre_hommes := r.nombre_hommes;
	    nombre_femmes := r.nombre_femmes;
	    nombre_total := r.nombre_total;

	    -- Ajout de la ligne
	    RETURN NEXT;
    END LOOP;

	RETURN;
END
$$ LANGUAGE plpgsql;




--------------------------------------------------------------------------------
-- Determine le taux de remplissage d'un evenement pour une representation
--------------------------------------------------------------------------------
CREATE OR REPLACE function taux_de_remplissage_par_evenement(idAppelant INTEGER, idDateEvent INTEGER)
RETURNS TABLE(nom_evenement VARCHAR, date_evenement TIMESTAMP, taux_remplissage FLOAT,
			nb_inscrit INTEGER, nb_place_total INTEGER)
AS $$
DECLARE
	capacite INTEGER := 0;
	nbParticipant  INTEGER := 0;
	pourcentage  FLOAT;
	reponse VARCHAR;
	name_event VARCHAR;
	date_event TIMESTAMP;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonctionnalité';
	   RETURN;
	END IF;

	SELECT count(*)  
	INTO nbParticipant
	FROM reservation 
	WHERE id_date_evenement = idDateEvent;

	capacite := date_evenement_capaciteTotale(idDateEvent);

	SELECT evenement_culturel.nom_evenement, date_evenement.date_evenement
	INTO name_event, date_event
	FROM evenement_culturel NATURAL JOIN date_evenement
	WHERE id_date_evenement = idDateEvent;	

	pourcentage := (nbParticipant::FLOAT*100)/capacite;

	RETURN QUERY
		SELECT name_event, date_event, pourcentage::FLOAT, nbParticipant, capacite;
END
$$ LANGUAGE plpgsql;



--------------------------------------------------------------------------------
-- Determine le taux de remplissage de chaque representation de tous les evenements
--------------------------------------------------------------------------------
CREATE OR REPLACE function taux_de_remplissage(idAppelant INTEGER)
RETURNS TABLE(nom_evenement VARCHAR, date_evenement TIMESTAMP, taux_remplissage FLOAT,
			nb_inscrit INTEGER, nb_place_total INTEGER)
AS $$
DECLARE
	it RECORD;
	r RECORD;
BEGIN
	IF NOT est_administrateur(idAppelant) THEN
	   Raise 'Il faut être administrateur pour utiliser cette fonction';
	   RETURN;
	END IF;
	
	-- Derouler tous les id_date_evenement
	FOR it IN
   	    SELECT id_date_evenement FROM date_evenement
    LOOP
	    r := taux_de_remplissage_par_evenement(idAppelant, it.id_date_evenement);

	    nom_evenement := r.nom_evenement;
	    date_evenement := r.date_evenement;
	    taux_remplissage := r.taux_remplissage;
	    nb_inscrit := r.nb_inscrit;
	    nb_place_total := r.nb_place_total;

	    -- Ajout de la ligne
	    RETURN NEXT;
    END LOOP;

	RETURN;
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











