# 📂 File-Tidier – Tri automatique de fichiers  
**Projet technologique Bash – Groupe de 3 – 100% GNU/Linux**

---

## 🎓 Sujet choisi

**Sujet n°1 : File-Tidier – Tri automatique de dossiers**

🗓️ **Soutenance prévue : mercredi 28 mai 2025**  
📍 **Travail réalisé sous Debian 12, en Bash uniquement**

---

## 👥 Membres du groupe

- **[Prénom NOM]** – Développement principal, structure du script  
- **[Prénom NOM]** – Tests, gestion du dépôt Git, journalisation  
- **[Prénom NOM]** – Documentation, README, support de soutenance  

---

## 🎯 Objectifs pédagogiques

- Concevoir un **script Bash simple, fonctionnel et robuste**
- Apprendre à **travailler en équipe avec Git**
- Présenter un **prototype opérationnel** avec démonstration
- **Réfléchir à son avenir professionnel** via le projet

---

## 🧾 Présentation

**File-Tidier** est un script Bash permettant de trier automatiquement les fichiers présents dans un répertoire, en les déplaçant dans des sous-dossiers catégorisés selon leur **type MIME**.

Exemple : un fichier `.jpg` est déplacé dans le dossier `Images`, un `.zip` dans `Archives`, etc.

Ce projet respecte strictement les consignes techniques suivantes :
- ✅ Écrit en **Bash uniquement**, sans langage additionnel
- ✅ Fonctionne sur **Debian 12** (GNU/Linux)
- ✅ Utilise les **outils GNU de base**
- ❌ Aucune dépendance externe ou propriétaire

---

## 📁 Fonctionnalités

- Tri automatique des fichiers selon leur type :
  - `Images/`, `PDFs/`, `Archives/`, `Documents/`, `Autres/`
- Prise en charge d’un **répertoire cible en argument**
- Option `--test` pour **simuler les actions sans déplacer**
- Fichier **log** généré automatiquement
- Aide intégrée avec `--help`

---

## ⚙️ Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/utilisateur/File-Tidier.git
cd File-Tidier
chmod +x file-tidier.sh
