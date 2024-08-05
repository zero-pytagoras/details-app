# Details App

Applications that can store your personal details and list all the written users on HTML

### Requirements:

- Python: 3.11
- SQLite3
- Bash Shell
- Docker
    - POSTGRESQL container needed
- Docker compose for multi container environment
- k3s for simple testing
- Virtual-box for k8s setup for more deep dive into world of container orchestrations

### Install

If on debian based OS:

```sh
curl -L get.docker.com  | sudo bash
sudo apt-get update 
sudo apt-get -y install git python3-poetry
git clone https://github.com/zero-pytagoras/details-app.git
cd /PATH/TO/DETAILS/APP/FOLDER
git config user.name YOUR-USERNAME
git config user.email EMAIL-YOU-USE-FOR-GIT
poetry install
```

If on RedHat based OS: (RpckyLinux suggested)
```sh
curl -L get.docker.com  | sudo bash 
sudo dnf install -y  epel-release git
git clone https://github.com/zero-pytagoras/details-app.git
cd /PATH/TO/DETAILS/APP/FOLDER
git config user.name YOUR-USERNAME
git config user.email EMAIL-YOU-USE-FOR-GIT
poetry install
```

### Setup

If everything is installed correctly:

```sh
poetry shell
python details.py
```



