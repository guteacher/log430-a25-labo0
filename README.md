# Labo 00 – Infrastructure (Git, Docker, CI/CD)
<img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Ets_quebec_logo.png" width="250">    
ÉTS - LOG430 - Architecture logicielle - Chargé de laboratoire: Gabriel C. Ullmann, Automne 2025.    

## 🎯 Objectifs d’apprentissage
- Comprendre comment utiliser des conteneurs avec **Docker**.
- Apprendre à écrire et exécuter des tests automatisés avec **pytest**.
- Mettre en place un pipeline **CI/CD** avec **GitHub** et **Docker**.
- Accéder à un serveur via **SSH** et vérifier la disponibilité des ressources computationnelles (CPU, RAM, espace disque)
- Savoir combiner les outils de développement modernes (VS Code, **Git**, **Docker**) pour lancer un cycle de développement logiciel.

---

## ⚙️ Setup
Dans ce laboratoire, vous travaillerez sur une application calculatrice. Cette calculatrice est volontairement très simple afin que nous puissions nous concentrer sur la configuration du projet, ainsi que sur la création et la maintenance d'un pipeline CI/CD. 

Dans les prochains laboratoires, nous verrons des architectures plus complexes et nous travaillerons avec une variété d'outils logiciels et de concepts architecturaux.

> ⚠️ IMPORTANT : Avant de commencer le setup et les activités, veuillez lire la documentation architecturale dans le répertoire `/docs/arc42/docs.pdf`.

### 1. Faites un fork et clonez le dépôt GitHub

```bash
git clone https://github.com/guteacher/log430-a25-labo0
cd log430-a25-labo0
```

### 2. Créez le conteneur Docker
Construisez le conteneur Docker `labo0-calculator` et lancez-le de manière itérative.
```bash
docker build -t labo0-calculator .
docker run -it labo0-calculator 
```

Dans un autre instance du terminal, vous pouvez vérifier si le conteneur a été correctement démarré. 
```bash
docker ps
```

> 📝 **NOTE** : Si vous exécutez des conteneurs sur votre ordinateur de développement, vous pouvez utiliser [Docker Desktop](https://www.docker.com/products/docker-desktop/) pour faciliter la gestion des conteneurs. Lorsque vous déployez sur un serveur, vous devrez utiliser l'interface de ligne de commande. Il existe des outils avancés de gestion Docker pour les serveurs, tels que [Portainer](https://www.portainer.io/), mais nous ne les aborderons pas ici. 

### 3. Créez un environnement virtuel Python sur votre ordinateur

#### Sur Linux/Mac
```bash
python -m venv .venv/labo0
source .venv/labo0/bin/activate
```

#### Sur Windows
```bash
python -m venv .venv/labo0
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser # Si nécessaire
.venv\labo0\Scripts\activate.ps1
```

### 4. Installez les dépendances Python

```bash
pip install -r requirements.txt
```

### 5. Lancez l’application

```bash
cd src
python calculator.py
```

---

## 🧪 Activités

### 1. Écrivez les tests

Dans le fichier `test_calculator.py`, écrivez des tests pour les fonctions définies dans `calculator.py`.

```python
def test_addition():
    assert addition(2, 3) == 5
```
Pour lancer les tests localement:

```bash
pytest
```

Si cela ne marche pas dans votre environnement, vous pouvez essayer:
```bash
python3 -m pytest
```

> 💡 **Question 1** : Si l’un des tests échoue à cause d’un bug, comment pytest signale-t-il l’erreur et aide-t-il à la localiser ? Rédigez un test qui provoque volontairement une erreur, puis montrez la sortie du terminal obtenue.

### 2. Ajoutez une étape à la pipeline CI (intégration continue)

Ajoutez une étape (step) dans `.github/workflows/.github-ci.yml` pour que GitHub exécute les tests automatiquement à chaque push. 

### 3. Versionnez votre code

Si tous les tests passent :

```bash
git add .
git commit -m "Tests pour calculator.py"
git push
```

GitHub éxecutera les tests dans son serveur, et ils devront passer également si ils sont corrects.

> 💡 **Question 2** :  Que fait GitHub pendant les étapes de « setup » et « checkout » ? Veuillez inclure la sortie du terminal GitHub CI dans votre réponse.

### 4. Automatiser déploiement continu (CD)
Après l’exécution des tests, déployez l’application dans un serveur ou machine virtuelle via SSH manuellement:

```bash
ssh $my_username@$my_hostname
git clone https://github.com/guteacher/log430-a25-labo0
cd log430-a25-labo0
```

>  📝 **NOTE** : N'oubliez pas d'installer Python, Docker et toutes les dépendances nécessaires sur le serveur de déploiement.

Procédez ensuite à la mise en place de l’automatisation du déploiement continu (CD) dans la machine virtuelle à l’aide de GitHub et de scripts Bash. Je vous recommande d'utiliser un GitHub Runner auto-hébergé (self-hosted) pour effectuer le déploiement automatique dans votre VM. Voici les instructions pour créer un [Runner](https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/add-runners).

Il existe d'autres méthodes de déploiement continu, mais vous avez besoin d'un serveur avec un nom DNS ou une adresse IP ouvert à Internet pour pouvoir l'utiliser avec GitHub. Par exemple :
- **SSH**: https://www.cyberciti.biz/faq/noninteractive-shell-script-ssh-password-provider/ 
- **Webhook**: https://docs.github.com/en/webhooks

> ⚠️ IMPORTANT : Il n'est pas recommandé d'écrire les noms d'utilisateur et les mots de passe en « plain text » dans un script CI/CD. Veuillez utiliser les [secrets](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets#creating-secrets-for-an-environment) dans votre [environnement](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments#creating-an-environment) GitHub.

> 💡 **Question 3** : Quelle approche et quelles commandes avez-vous exécutées pour automatiser le déploiement continu de l'application dans la machine virtuelle ? Veuillez inclure les sorties du terminal et les scripts Bash dans votre réponse.

Quelques commandes utiles pour vérifier l’état des ressources :
```bash
free -h   # Vérifier l’utilisation de la RAM
top       # Vérifier l’utilisation du CPU et les processus en cours
df -h     # Vérifier l’espace disque disponible
```

> 💡 **Question 4** : Quel type d'informations pouvez-vous obtenir via la commande « top » ? Veuillez inclure la sortie du terminal dans votre réponse.
---

## 📦 Livrables

- Code compressé en `.zip` contenant **l'ensemble du code source** du projet Labo 00.
- Rapport `.pdf` répondant aux 4 questions presentées dans ce fichier. Il est **obligatoire** d'ajouter du code ou des sorties de terminal pour illustrer chacune de vos réponses.
