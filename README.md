# Projet_Analyse_RH

## Aperçu du Projet
---
ce projet mené entièrement avec SQL analyse les données RH d'une entreprise fictive dans le but de determiner 
les facteurs qui influencent le turnover des employés et identifier les profils les plus à risques.


## Analyse Menées
---
### A) Analyse du turnover global
- taux de turnover **--->>** 29,33%
- Ancienneté Moyenne des anciens employés **--->>** 2,4 ans

### B) Turnover vs salaire
- Quel est le salaire moyen des employés qui partent?
- Comparer par rapport à celui des actifs.
  
  Objectif: **comprendre si un salaire jugé trop peu influence les turnovers**

 ### C) Turnover vs Performances
 - Quel est la performance moyenne des anciens employés ?
 - Comparer par rapport à celui des actifs.
   
    objectif: **déterminer si l'entreprise perd de bon profil**

 ### D) Turnover par ancienneté
  - évaluer la durée moyen avant départ.
    
  objectif: **verifier s'il pourrait s'agir d'un problème d'onboarding dans le cas d'un nombre élevé de depart précoce, ou
               d'evolution carrière dans le cas de départ tardifs**.

 ## Insights par departemnts
 ---
 #### IT/Finance :
 - Les anciens employés dans les départements IT et Finance ont des salaires moyens superieurs à celui des actifs et des performances
   équivalentes
 -  Taux de turnover relativement faible ( 23% et 17% respectivement )
 -  ancienneté moyenne satisfaisante ( > 2ans).
    
   **Conclusion** : Départements relativement stables

 #### Marketing :
  - Taux de turnover à 26%
  - Salaire moyen inférieur aux actifs
  - Profil très performants ( performance > 4) et Expérimentés
  - évolution proffessionel en déphasage avec les performances 

    **Conclusion** : Fuites des meilleures profils, une réconsidération de la politique salariale pour une meilleure
                    emphase avec les performances devrait être envisagé.
 #### Opérations :
  - Turnover à 28,5%
  - Salaire moyen supérieur aux actifs
  - Performance similaire
  - Départ précoce (1,4an en moyenne).

      **conclusion** : Gros problème d'onboarding, une amélioration des procédures d'intégration et de suivi des nouveau profils est nécessaire.

  #### Ventes :
   - 40% de Turnover
   - 80% des departs avant les 2 premières années
   - Salaire globale inférieur à ceux des actifs.

        **Conclusion** : Gros problème d'onboarding


   ## Predictions de Profils à risque
---
   | Département | Indicateurs | Nombre de profils |
   |-------------|-------------|-------------------|
   | Marketing | salaire < moyenne, ancienneté > 2, performance > 4 | 3 |
   | ventes | ancienneté < 2, salaire <= moyenne, performance >= 3,5 | 1 |
   | support client | salaire <= moyenne, performance > 4 | 2 |


  
  
   
   
  
   
    
      
   
    
 
      
