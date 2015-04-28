----------
-- MESSAGE
----------

-- Liste les messages d'un membre a partir de son login
\echo boite_message()
CREATE OR REPLACE FUNCTION boite_message(login_membre VARCHAR)
RETURNS TABLE (date_message TIMESTAMP, objet_message VARCHAR, contenu_message VARCHAR)
AS $$
BEGIN
	RETURN QUERY
	SELECT date_message, objet_message, contenu_message
	FROM 
	(SELECT id_membre FROM Membre WHERE login_membre = $1) as s
	NATURAL JOIN Reception_message 
	NATURAL JOIN Message
	;
END;
$$ LANGUAGE plpgsql;