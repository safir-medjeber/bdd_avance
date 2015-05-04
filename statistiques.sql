\echo Statistiques sur la base de données

\echo Ratio homme/femme de la base de donnée : 
select * from ratio_homme_femme_sur_plateforme(1);

\echo -------------------------------------------
\echo

\echo Ratio homme/femme des reservant d une date d evenement :
select * from ratio_homme_femme_par_evenement(1,1);