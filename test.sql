--Triggers

-- test evenement_complet ok 






--Fonctions

--recherhe ok
SELECT searchEvent(true, false, false, '2015-01-02', '2016-12-02', 50, 80, 'Tragedie');
SELECT info_about_event('Britannicus');


--reservation , annulation et avoir ok
SELECT reservation_reserver('Smith_Paul', 9);

SELECT reservation_annuler(27, 'Smith_Paul', 9); -- doit marcher
SELECT reservation_annuler(1, 'Smith_Paul', 9); -- doit marcher
SELECT reservation_annuler(12, 'Smith_Paul', 9); -- doit pas marcher
SELECT avoir_lister(27);



-- reception de mail pour reservation et annulation d'un billet ok
SELECT * FROM boite_reception('Smith_Paul')
SELECT * FROM vider_boite_reception('Smith_Paul');

-- envoie d'un message a un autre membre ok
SELECT envoyer_message(1, 'Teste', 'Salut toi');


-- suppression evenement et consequence  ok
select evenement_supprimer(20, 1);

