-------------------------------------------------------
-- Retourne true si le login existe
-------------------------------------------------------
DROP FUNCTION IF EXISTS est_administrateur(VARCHAR);
CREATE OR REPLACE FUNCTION est_administrateur(VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN ($1 IN (SELECT login_membre FROM Membre NATURAL JOIN Administrateur));
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS est_administrateur(INTEGER);
CREATE OR REPLACE FUNCTION est_administrateur(INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN ($1 IN (SELECT id_membre FROM Administrateur));
END;
$$ LANGUAGE plpgsql;