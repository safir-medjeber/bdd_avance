\echo -------------------------------------------
\echo
\echo Ratio homme/femme des reservants de toutes les dates d evenement :
select * from ratio_homme_femme_evenements(1);

\echo -------------------------------------------
\echo
\echo Taux de remplissage de tous les evenements :
select * from taux_de_remplissage(1);

\echo -------------------------------------------
\echo
\echo Taux de remplissage moyen des dates d un même evenement, pour tous les evenements :
select * from taux_de_remplissage_moyen(1);

\echo -------------------------------------------
\echo
\echo Chiffre d affaire de tous les organisateurs :
select * from revenu_organisateurs(1);