-- Fonction permettant la creation d'un evenement culturel de type festival
CREATE OR REPLACE  FUNCTION create_festival(nom_evenement text, type_festival text,  en_plein_air boolean) RETURNS void as $$
DECLARE
	identifiant INTEGER;
BEGIN
	INSERT INTO Evenement_culturel(nom_evenement) VALUES (nom_evenement) returning id_evenement into identifiant;
	INSERT INTO Festival(id_evenement, type_festival, en_plein_air) VALUES (identifiant, type_festival, en_plein_air);
RETURN;	
END;
$$ LANGUAGE plpgsql;




-- Fonction permettant la creation d'un evenement culturel de type exposition
CREATE OR REPLACE  FUNCTION create_exposition(nom_evenement text, type_exposition text) RETURNS void as $$
DECLARE
	identifiant INTEGER;
BEGIN
	INSERT INTO Evenement_Culturel(nom_evenement) VALUES (nom_evenement) returning id_evenement into identifiant;
	INSERT INTO Exposition(id_evenement, type_exposition) VALUES (identifiant, type_exposition);
RETURN;	
END;
$$ LANGUAGE plpgsql;



-- Fonction permettant la creation d'un evenement culturel de type piece de theatre
CREATE OR REPLACE  FUNCTION create_piece_theatre(nom_evenement text, genre_piece text, metteur_scene_piece text) RETURNS void as $$
DECLARE
	identifiant INTEGER;
BEGIN
	INSERT INTO Evenement_Culturel(nom_evenement) VALUES (nom_evenement) returning id_evenement into identifiant;
	INSERT INTO Piece_Theatre(id_evenement,  genre_piece, metteur_scene_piece) VALUES (identifiant, genre_piece, metteur_scene_piece);
RETURN;	
END;
$$ LANGUAGE plpgsql;

