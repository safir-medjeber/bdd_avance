
-- drop function nbMembreF();

-- Create or replace  function nbMembreF() RETURNS TABLE(prenom_membre varchar) as $$
-- begin
-- return query select membre.prenom_membre from membre where sexe_membre='F';
-- end
-- $$ language plpgsql;

-- --select * from nbMembreF();


-- drop function partMembreF();

-- Create or replace  function partMembreF() RETURNS text as $$
-- declare
-- femme INTEGER := 0;
-- total INTEGER := 0;
-- pourcentage  INTEGER :=0;
-- x text;
-- begin
--     select count(*)  into femme from membre where sexe_membre='F';
--     select count(*)  into total from membre;	
--     pourcentage := (femme*100)/total;
--     x := pourcentage || ' %';
-- return x;
-- end
-- $$ language plpgsql;

-- select partMembreF();





-- Create or replace  function partMembreH() RETURNS text as $$
-- declare
-- homme INTEGER := 0;
-- total INTEGER := 0;
-- pourcentage  INTEGER :=0;
-- x text;
-- begin
--     select count(*)  into homme from membre where sexe_membre='H';
--     select count(*)  into total from membre;	
--     pourcentage := (homme*100)/total;
--     x := pourcentage || ' %';
-- return x;
-- end
-- $$ language plpgsql;

-- select partMembreH();



drop function searchEvent(boolean, boolean, boolean);


Create or replace  function searchEvent(event_theatre boolean, event_exposition boolean,  event_festival boolean, date_debut date, date_fin date)
       RETURNS TABLE(nom_evenement varchar) as $$
DECLARE
       requete text := 'select evenement_culturel.nom_evenement from evenement_culturel';
BEGIN
	CASE
		WHEN event_theatre THEN
		     requete := requete ||' left join piece_theatre on evenement_culturel.nom_evenement=piece_theatre.nom_evenement';
		WHEN event_theatre THEN
		     requete := requete ||' left join exposition on evenement_culturel.nom_evenement=exposition.nom_evenement';
		WHEN event_festival THEN	     
		     requete := requete ||' left join festival on evenement_culturel.nom_evenement=festival.nom_evenement';
	END CASE;
	RETURN query execute requete ;
END

$$ language plpgsql;

--select searchEvent(true, false, false, '10-10-2000', '10-10-2001');



\echo requetes
-- select evenement_culturel.nom_evenement from evenement_culturel
--  	left join piece_theatre on evenement_culturel.nom_evenement=piece_theatre.nom_evenement  
--  	left join festival on evenement_culturel.nom_evenement=festival.nom_evenement;    


 select evenement_culturel.nom_evenement from evenement_culturel
 	inner join date_evenement
	on date_evenement.id_evenement= evenement_culturel.id_evenement;
