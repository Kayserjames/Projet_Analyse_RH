
# Projet d’Analyse RH — Étude du Turnover des Employés

## 🎯 Objectif du projet
Ce projet a pour objectif d’analyser les données RH d’une entreprise anonyme afin de :

- Identifier les facteurs influençant le turnover des employés
- Déterminer les profils les plus exposés au risque de départ
- Détecter d’éventuelles tendances organisationnelles
- Formuler des recommandations visant à améliorer la rétention et la gestion des talents

---

# 📂 Dataset
L’analyse repose sur un ensemble de données structuré autour de 4 tables principales contenant :

- Les informations générales des employés
- L’historique des promotions
- L’évolution des salaires
- Les départements de l’entreprise

---

# 🧹 Validation et préparation des données

Plusieurs étapes de nettoyage et de validation ont été réalisées afin de garantir la fiabilité de l’analyse :

- Suppression des doublons
- Vérification et harmonisation des formats de données
- Contrôle des valeurs manquantes
- Ajustement des historiques salariaux et promotionnels afin d’assurer leur cohérence temporelle avec les dates de départ
- Vérification de l’intégrité des relations entre les différentes tables

Cette phase a permis d’éliminer plusieurs incohérences susceptibles de biaiser les résultats de l’analyse.

---

# 📊 Analyse exploratoire

## 🔑 Indicateurs clés

| Indicateur | Valeur |
|---|---|
| Taux de turnover global | 20.2% |
| Ancienneté moyenne avant départ | 2 ans et 9 mois |
| Performance moyenne des anciens employés | 3.6 / 5 |
| Salaire moyen des anciens employés | 146 829 |
| Salaire moyen des employés actifs | 140 306 |

---

# 🏢 Analyse approfondie des départements les plus touchés

## 1. QA & Testing

- Taux de turnover : **28.47%**
- Les profils seniors représentent **38% des départs**
- **74% des employés** ayant quitté ce département sont restés en moyenne **2.5 ans sans promotion**
- Les départs surviennent majoritairement au **4e trimestre**
- Les performances et niveaux de rémunération des anciens employés restent comparables à ceux des employés actifs

### 🔍 Interprétation
Le turnover dans ce département semble davantage lié à une stagnation professionnelle qu’à un problème de rémunération ou de performance.

---

## 2. Design

- Taux de turnover : **25%**
- Les départs surviennent principalement au **1er trimestre**
- **81.48% des départs** concernent des employés restés environ **2.5 ans sans évolution**
- Les profils seniors représentent **44.44% des départs**
- Aucun écart significatif observé entre anciens employés et employés actifs en termes de salaire ou de performance

### 🔍 Interprétation
Les départs semblent principalement motivés par un manque de perspectives d’évolution et de renouvellement des responsabilités.

---

## 3. Engineering

- Taux de turnover : **24.5%**
- **65% des départs** concernent des employés restés en moyenne **3.1 ans au même poste**
- Les seniors représentent **32% des départs**
- Les performances et rémunérations restent relativement stables entre employés actifs et anciens employés

### 🔍 Interprétation
Le turnover observé dans ce département semble davantage lié à la progression de carrière et aux opportunités professionnelles qu’à des facteurs financiers.

---

# 🧠 Insights principaux

## 📌 1. Le turnover global reste modéré
Avec un taux global de 20.2%, l’entreprise ne présente pas de crise majeure de rétention.

Cependant, certains départements affichent des niveaux significativement supérieurs à la moyenne, révélant des problématiques plus localisées.

---

## 📌 2. Les salaires ne semblent pas être le principal facteur de départ
Les écarts de rémunération entre anciens employés et employés actifs restent relativement faibles.

De même, les performances observées chez les employés ayant quitté l’entreprise restent comparables à celles des employés encore présents.

👉 Les départs ne semblent donc pas principalement motivés par une sous-performance ou une forte insatisfaction salariale.

---

## 📌 3. La stagnation professionnelle apparaît comme le principal facteur de turnover
Une forte proportion des employés ayant quitté l’entreprise est restée plusieurs années au même poste sans promotion.

Cette tendance est particulièrement marquée chez les profils seniors.

👉 Le manque d’évolution professionnelle semble être l’un des principaux déclencheurs de départ.

---

## 📌 4. Les profils expérimentés présentent un risque de départ plus élevé
Les seniors représentent une part importante des départs dans les départements les plus touchés.

Cela peut traduire :
- un manque de perspectives d’évolution avancée,
- ou un besoin de reconnaissance insuffisant.

---

# ✅ Recommandations

## 1. Renforcer les opportunités d’évolution interne
Mettre en place :
- des plans de carrière plus visibles,
- des objectifs d’évolution clairs,
- des entretiens de progression réguliers.

L’objectif est de réduire les périodes prolongées sans évolution professionnelle.

---

## 2. Identifier les employés à risque plus tôt
Créer des indicateurs RH permettant d’identifier :
- les employés restés longtemps sans promotion,
- les profils seniors stagnants,
- les départements présentant un turnover supérieur à la moyenne.

Ces indicateurs pourraient alimenter des tableaux de bord RH automatisés

---

## 3. Réaliser des enquêtes de satisfaction plus régulières
Les données quantitatives montrent peu d’écarts salariaux ou de performance.

Il serait donc pertinent de compléter l’analyse par des données qualitatives afin de mieux comprendre :
- les attentes des employés,
- les problématiques managériales,
- ou les facteurs liés à la culture d’entreprise.

---

# 🛠 Outils utilisés

- SQL (PostgreSQL)
- Excel


---

# 📌 Conclusion

Cette étude met en évidence que le turnover observé dans l’entreprise semble davantage lié aux perspectives d’évolution professionnelle qu’à des problématiques salariales ou de performance.

L’analyse révèle également l’importance d’un suivi ciblé par département afin d’identifier les zones les plus exposées et d’adapter les stratégies de rétention en conséquence.

Ce projet illustre l’utilisation de SQL et de l’analyse de données RH pour transformer des données opérationnelles en recommandations stratégiques exploitables.
```


 

  
  
   
   
  
   
    
      
   
    
 
      
