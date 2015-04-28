---------
-- MEMBRE
---------

-- Retourne l'id d'un membre a partir de son login
DROP FUNCTION IF EXISTS membre_getID(VARCHAR);
CREATE OR REPLACE FUNCTION membre_getID(login VARCHAR)
RETURNS INTEGER AS $$
BEGIN
	SELECT id_membre FROM Membre WHERE login_membre = $1;
END;
$$ LANGUAGE plpgsql;


-- Retourne true si le login existe
DROP FUNCTION IF EXISTS est_membre(Membre.pseudo_membre%type);
CREATE OR REPLACE FUNCTION est_membre(pseudo_membre Membre.pseudo_membre%type)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN ($1 IN (SELECT pseudo_membre FROM Membre));
END;
$$ LANGUAGE plpgsql;

-- Retourne true si le login existe
DROP FUNCTION IF EXISTS est_administrateur(Membre.pseudo_membre%type);
CREATE OR REPLACE FUNCTION est_administrateur(pseudo_membre Membre.pseudo_membre%type)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN ($1 IN (SELECT pseudo_membre FROM Membre NATURAL JOIN Administrateur));
END;
$$ LANGUAGE plpgsql;

-- Retourne le jour courant
DROP FUNCTION IF EXISTS TODAY();
CREATE OR REPLACE FUNCTION today()
RETURNS TIMESTAMP AS $$
BEGIN
	RETURN (SELECT aujourdhui FROM aujourdhui);
END;
$$ LANGUAGE plpgsql;