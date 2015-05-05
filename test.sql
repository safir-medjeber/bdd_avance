
\echo date courante => 2015-01-01 00:00:01


\echo --------------------------------------------------------------------------------
\echo
\echo Recherche d une pièce de theatre entre 2015-01-02 et 2016-12-02 dans un budget compris en 50 et 100€
SELECT * from searchEvent(true, false, false, '2015-01-02', '2016-12-02', 50, 100, '');


\echo --------------------------------------------------------------------------------
\echo
\echo Observation de la reduction du prix à partir de 5 jours avant sa programmation 
select * from evenement_culturel natural join date_evenement where id_date_evenement =1;


\echo --------------------------------------------------------------------------------
\echo
\echo  On verifie le nombre de place disponible pour l évènement Britannicus
select  date_evenement_nbPlacesRestantes(9);


\echo --------------------------------------------------------------------------------
\echo
\echo On decide maintenant que le membre Smith Paul reserve cette derniere place
SELECT reservation_reserver('Smith_Paul', 9);

\echo --------------------------------------------------------------------------------
\echo
\echo  On verifie le nombre de place disponible désormais disponible
SELECT  date_evenement_nbPlacesRestantes(9);



\echo --------------------------------------------------------------------------------
\echo
\echo  Smith Paul decide de reserver encore une seconde place
SELECT reservation_reserver('Smith_Paul', 9);



\echo --------------------------------------------------------------------------------
\echo
\echo  Smith Paul decide d annuler sa premiere reservation
SELECT reservation_annuler(27, 'Smith_Paul', 9);



\echo --------------------------------------------------------------------------------
\echo
\echo  Un administrateur peut annuler la reservation de nimporte qui mais pas un membre 
SELECT reservation_annuler(27, 'Dupuis_Marine', 9);



\echo --------------------------------------------------------------------------------
\echo
\echo  Apres avoir annuler sa reservation , Smith Paul va alors etre credité d un avoir
SELECT * from avoir_lister(27);



\echo --------------------------------------------------------------------------------
\echo
\echo  Il va egalement recevoir un email l informant
SELECT * FROM boite_reception('Smith_Paul');


\echo --------------------------------------------------------------------------------
\echo
\echo  une place se libere pour un evenement,  Paul Smith  veut alors le faire savoir à Xavier Dupont: il lui envoie un email
SELECT envoyer_message(1, 'Bonne nouvelle', 'une place se libere pour le piece britannicus');
SELECT * FROM boite_reception('Dupont_Xavier');



\echo --------------------------------------------------------------------------------
\echo 
\echo Sofiane Charles qui est membre et organisateur decide de deprogrammer festival de Cannes
SELECT evenement_supprimer(7, 3);


\echo --------------------------------------------------------------------------------
\echo
\echo  Xavier Dupont va alors etre imformer par mail et credité en avoir
SELECT * FROM boite_reception('Dupont_Xavier');


\echo --------------------------------------------------------------------------------
\echo
\echo  Xavier Dupont qui est aussi administrateur decide d ajouter Paul Smith en tant qu organisateur pour la piece britannicus avec pour id  20
SELECT evenement_ajouterOrganisateur(20, 1, 'Smith_Paul');
select * from organise where id_evenement=20;

