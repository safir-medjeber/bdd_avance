\i date_evenement_fonctions.sql
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
    	reponse := 'pourcentage d''homme: ' || pourcentageH || chr(10) || 'pourcentage de femme: ' || pourcentageF;
	RETURN reponse;
END
$$ LANGUAGE plpgsql;
--select ratio_homme_femme_sur_plateforme();



--------------------------------------------------------------------------------
-- Determine le taux de remplissage d'un evenement pour une representation
--------------------------------------------------------------------------------
CREATE OR REPLACE function taux_de_remplissage(idDateEvent INTEGER) RETURNS text as $$
DECLARE
	capacite INTEGER := 0;
	nbParticipant  INTEGER := 0;
	pourcentage  FLOAT := 0;
	reponse text := '';
BEGIN
	SELECT count(*) from reservation where id_date_evenement = idDateEvent INTO nbParticipant;
	capacite := date_evenement_capaciteTotale(idDateEvent);
	pourcentage := (nbParticipant*100)/capacite;
    	reponse := 'Taux de remplissage ' || pourcentage || '%'; --    ok  ' || capacite || '  ok ' || nbParticipant;

	RETURN reponse;
END
$$ LANGUAGE plpgsql;

select taux_de_remplissage(20);

--select  nom_evenement, date_evenement from date_evenement natural join evenement_culturel where id_date_evenement=21;

--Nombre de participant à un événement + Stat liés aux nombre moyen de participant par événement
