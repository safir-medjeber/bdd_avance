---------------------------------------------------------
-- Si on supprime tous les liens entre un Message et les Membre, 
-- Alors on supprime le message definitivement
---------------------------------------------------------
CREATE OR REPLACE FUNCTION reception_message_function_delete()
RETURNS TRIGGER AS $$
BEGIN
	PERFORM * FROM Reception_Message WHERE id_message = OLD.id_message;
	IF NOT FOUND THEN 
		DELETE FROM Message WHERE id_message = OLD.id_message;
	END IF;

	RETURN NULL;
END
$$ language plpgsql;

-- DROP TRIGGER IF EXISTS reception_message_trigger_delete on Reception_Message;
CREATE TRIGGER reception_message_trigger_delete
	AFTER DELETE ON Reception_Message  FOR EACH ROW
	EXECUTE PROCEDURE reception_message_function_delete();

/*
---------------------------------------------------------
-- Si on supprimer un Message, alors on supprime tous
-- ses liens avec les Membres
---------------------------------------------------------

CREATE OR REPLACE FUNCTION message_function_delete()
RETURNS TRIGGER AS $$
BEGIN
	DELETE FROM Reception_Message WHERE id_message = OLD.id_message;

	RETURN OLD;
END
$$ language plpgsql;

-- DROP TRIGGER IF EXISTS message_trigger_delete ON Message;
CREATE TRIGGER message_trigger_delete
	BEFORE DELETE ON Message  FOR EACH ROW
	EXECUTE PROCEDURE message_function_delete();
*/