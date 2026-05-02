--creation de la table
CREATE TABLE Employee
(
    Id_employes INT PRIMARY KEY,
    Nom Varchar(50),
    Date_embauche Date,
    Date_depart Date,
    Anciennete Decimal,
    Departement Varchar(50),
    Poste Varchar(50),
    Salaire_annuel Numeric,
    Performance_annuelle Decimal,
    Jour_de_conges_restant INT,
    Statut_du_contrat Varchar (10),
    Localisation Varchar
);

--limite d'un chiffre apres la virgule pour l'anciennete(en année)

UPDATE employee
SET "anciennete"= Round(anciennete,1);


-----step 1: cacul des KPIs
--Taux de depart
SELECT count(Id_employes),count(Date_depart),
    Round((count(Date_depart)::Numeric/count(id_employes))*100,2)
        As Taux_de_depart
FROM employee;

--ancienneté moyenne pour les anciens employés
SELECT Round(avg(anciennete),1)
FROM employee
WHERE date_depart is NOT NULL;


--pourcentage du turnover total par departements 
SELECT Departement, 
       count(Date_depart) as Turnover_par_departement,
      (SELECT count(date_depart) FROM employee) as Turnover_total,
      Round((count(Date_depart)::Numeric/(SELECT count(date_depart)
      FROM employee)*100),2)
        AS pourcentage
FROM employee
GROUP BY departement
ORDER BY pourcentage DESC;


---step 2: Analyse
---A) analyse Salaire vs Depart

SELECT Round(avg(Salaire_annuel),0) as avg_salaire_anciens,
       (SELECT Round(avg(Salaire_annuel),0)
       FROM employee
       WHERE date_depart is NULL) as avg_salaire_actifs
FROM employee
WHERE Date_depart is NOT NULL


---B) analyse performance vs départ

SELECT Round(avg(Performance_annuelle),1) as performance_anciens,
       (SELECT Round(avg(Performance_annuelle),1)
        FROM employee 
        WHERE date_depart is null) as performance_actifs
FROM employee
WHERE date_depart is NOT NULL;


---C) Turnovers par départemnts

SELECT Departement,
       count(id_employes) as employes_par_dept,
       count(Date_depart) as depart_par_dept,
       Round((count(Date_depart)::Numeric/count(Id_employes))*100,1)
        as  pourcentage
FROM employee
GROUP BY departement
ORDER BY pourcentage DESC;


---step 3
---Analyse croisée par departement// IT

SELECT Departement,nom,
       CASE
           WHEN date_depart is NULL THEN 'actif' 
           else 'parti'
           END as Statut,
           Salaire_annuel,
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_actifs FROM employee
           WHERE departement = 'IT' AND date_depart is NULL),
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_anciens From employee
            WHERE departement = 'IT' AND date_depart is NOT NULL),
           Performance_annuelle,
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_actifs FROM employee
           WHERE departement = 'IT' AND date_depart is NULL),
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_anciens FROM employee
           WHERE departement = 'IT' AND date_depart is NOT NULL),
           anciennete,
           (SELECT Round(avg(anciennete),1) as avg_anciennete FROM employee
           WHERE departement = 'IT' AND date_depart is NOT NULL)
FROM employee
WHERE departement = 'IT'       
ORDER BY statut;

---//Finance

SELECT Departement,nom,
       CASE
           WHEN date_depart is NULL THEN 'actif' 
           else 'parti'
           END as Statut,
           Salaire_annuel,
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_actifs FROM employee
           WHERE departement = 'Finance' AND date_depart is NULL),
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_anciens From employee
            WHERE departement = 'Finance' AND date_depart is NOT NULL),
           Performance_annuelle,
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_actifs FROM employee
           WHERE departement = 'Finance' AND date_depart is NULL),
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_anciens FROM employee
           WHERE departement = 'Finance' AND date_depart is NOT NULL),
           anciennete,
           (SELECT Round(avg(anciennete),1) as avg_anciennete FROM employee
           WHERE departement = 'Finance' AND date_depart is NOT NULL)
FROM employee
WHERE departement = 'Finance'       
ORDER BY statut;

---//Marketing

  SELECT Departement,nom,
       CASE
           WHEN date_depart is NULL THEN 'actif' 
           else 'parti'
           END as Statut,
           Salaire_annuel,
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_actifs FROM employee
           WHERE departement = 'Marketing' AND date_depart is NULL),
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_anciens From employee
            WHERE departement = 'Marketing' AND date_depart is NOT NULL),
           Performance_annuelle,
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_actifs FROM employee
           WHERE departement = 'Marketing' AND date_depart is NULL),
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_anciens FROM employee
           WHERE departement = 'Marketing' AND date_depart is NOT NULL),
           anciennete,
           (SELECT Round(avg(anciennete),1) as avg_anciennete FROM employee
           WHERE departement = 'Marketing' AND date_depart is NOT NULL)
FROM employee
WHERE departement = 'Marketing'       
ORDER BY statut;


----Opérations

SELECT Departement,nom,
       CASE
           WHEN date_depart is NULL THEN 'actif' 
           else 'parti'
           END as Statut,
           Salaire_annuel,
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_actifs FROM employee
           WHERE departement = 'Opérations' AND date_depart is NULL),
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_anciens From employee
            WHERE departement = 'Opérations' AND date_depart is NOT NULL),
           Performance_annuelle,
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_actifs FROM employee
           WHERE departement = 'Opérations' AND date_depart is NULL),
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_anciens FROM employee
           WHERE departement = 'Opérations' AND date_depart is NOT NULL),
           anciennete,
           (SELECT Round(avg(anciennete),1) as avg_anciennete FROM employee
           WHERE departement = 'Opérations' AND date_depart is NOT NULL)
FROM employee
WHERE departement = 'Opérations'       
ORDER BY statut;



----//RH

SELECT Departement,nom,
       CASE
           WHEN date_depart is NULL THEN 'actif' 
           else 'parti'
           END as Statut,
           Salaire_annuel,
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_actifs FROM employee
           WHERE departement = 'RH' AND date_depart is NULL),
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_anciens From employee
            WHERE departement = 'RH' AND date_depart is NOT NULL),
           Performance_annuelle,
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_actifs FROM employee
           WHERE departement = 'RH' AND date_depart is NULL),
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_anciens FROM employee
           WHERE departement = 'RH' AND date_depart is NOT NULL),
           anciennete,
           (SELECT Round(avg(anciennete),1) as avg_anciennete FROM employee
           WHERE departement = 'RH' AND date_depart is NOT NULL)
FROM employee
WHERE departement = 'RH'       
ORDER BY statut;

----//Support client

SELECT Departement,nom,
       CASE
           WHEN date_depart is NULL THEN 'actif' 
           else 'parti'
           END as Statut,
           Salaire_annuel,
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_actifs FROM employee
           WHERE departement = 'Support client' AND date_depart is NULL),
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_anciens From employee
            WHERE departement = 'Support client' AND date_depart is NOT NULL),
           Performance_annuelle,
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_actifs FROM employee
           WHERE departement = 'Support client' AND date_depart is NULL),
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_anciens FROM employee
           WHERE departement = 'Support client' AND date_depart is NOT NULL),
           anciennete,
           (SELECT Round(avg(anciennete),1) as avg_anciennete FROM employee
           WHERE departement = 'Support client' AND date_depart is NOT NULL)
FROM employee
WHERE departement = 'Support client'       
ORDER BY statut;

---//Ventes

SELECT Departement,nom,
       CASE
           WHEN date_depart is NULL THEN 'actif' 
           else 'parti'
           END as Statut,
           Salaire_annuel,
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_actifs FROM employee
           WHERE departement = 'Ventes' AND date_depart is NULL),
           (SELECT Round(avg(Salaire_annuel),0) as avg_sal_anciens From employee
            WHERE departement = 'Ventes' AND date_depart is NOT NULL),
           Performance_annuelle,
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_actifs FROM employee
           WHERE departement = 'Ventes' AND date_depart is NULL),
           (SELECT Round(avg(Performance_annuelle),1) as avg_perf_anciens FROM employee
           WHERE departement = 'Ventes' AND date_depart is NOT NULL),
           anciennete,
           (SELECT Round(avg(anciennete),1) as avg_anciennete FROM employee
           WHERE departement = 'Ventes' AND date_depart is NOT NULL)
FROM employee
WHERE departement = 'Ventes'       
ORDER BY statut;


---step 4: Analyse prédictive / Profils a risque par département
--Marketing

SELECT nom
FROM employee
WHERE salaire_annuel < 
                 ( SELECT Round(avg(salaire_annuel),0) 
                       as avg_sal_marktg
                       FROM employee
                       WHERE departement = 'Marketing' AND date_depart is NULL)
       AND anciennete > 2 
       AND Performance_annuelle > 4 
       AND departement = 'Marketing'
       AND date_depart is NULL;


---Support client

SELECT nom
FROM employee
WHERE Lower(TRIM(departement)) = 'Support client'
      AND date_depart is NULL
      AND Performance_annuelle > 4
      AND Salaire_annuel <= ( SELECT Round(avg(salaire_annuel),0) 
                       as avg_sal_supportC
                       FROM employee
                       WHERE Lower(TRIM(departement)) = 'Support client' AND date_depart is NULL);


----Ventes

SELECT nom
FROM employee
WHERE salaire_annuel <= (SELECT Round(avg(salaire_annuel),0) 
                       as avg_sal_ventes
                       FROM employee
                       WHERE departement = 'Ventes' AND date_depart is NULL)
        AND anciennete < 2
        AND Performance_annuelle >= 3.5
        AND date_depart is NULL
        AND departement = 'Ventes';           

                                                    
 