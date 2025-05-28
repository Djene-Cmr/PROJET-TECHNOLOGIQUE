# 📂 File-Tidier – Tri automatique de fichiers  
**Projet Bash – 100% GNU/Linux – Soutenance du 28 mai 2025**

---

## 🎓 Sujet choisi

**Sujet n°1 : File-Tidier – Tri automatique de dossiers**

---

## 👥 Membres du groupe

- **Jean Claude SIBAFEU** – Développement principal, structure du script, Tests  
- **DJénè CAMARA** – Tests, gestion du dépôt Git, journalisation, README, support de soutenance 
- **Mohamoud Touré** – Documentation,structure du script, support de soutenance 

---

## 🎯 Objectifs pédagogiques

- Concevoir un **script Bash fonctionnel et maintenable**
- Travailler efficacement en **équipe avec Git**
- Réaliser une **démonstration technique claire**
- Réfléchir à **l’orientation professionnelle** via le projet

---

## 🧾 Présentation du projet

**File-Tidier** est un script Bash permettant de trier automatiquement les fichiers d’un répertoire, en les déplaçant vers des sous-dossiers selon leur **type MIME** (images, PDF, archives, etc.).

Le script fonctionne **100% en Bash**, avec les outils GNU standards, sans dépendance externe, et a été **testé sous Debian 12**.

---

## ⚙️ Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/utilisateur/File-Tidier.git
cd File-Tidier
chmod +x file-tidier.sh
```

---

## ▶️ Utilisation

### 2. Lancer le script

```bash
ls                                   # liste des différents fichiers 
chmod +x file.sh                     # Demarrer et rendre le script exécutable 
./file.sh                            # exécuter véritablement le script ( déplacement des fichiers en fonction de leur extensions dans les sous dossiers 
                                     respectifs) 
./file.sh -t                         # tester le script pour s'assurer les consignes sont respectées
./file.sh -h                         # afficher au cas où d'un problème 
```

---

## 📂 Arborescence générée

Voici les dossiers créés automatiquement dans le répertoire trié :

```bash
Téléchargements/
├── Images/
├── PDFs/
├── Archives/
├── Documents/
├── Autres/
```

---

## 💡 Exemple de sortie (mode test)

Le mode `-t` (ou `--test`) affiche les actions sans effectuer de déplacement réel :

```bash
[TEST] /home/user/photo.jpg → /home/user/Téléchargements/Images/photo.jpg
[TEST] /home/user/doc.pdf → /home/user/Téléchargements/PDFs/doc.pdf
```

---

## 🗂️ Structure du projet

```bash
File-Tidier/
├── file.sh             # Script contenant le Bash principal
├── README.md           # Documentation utilisateur
```

