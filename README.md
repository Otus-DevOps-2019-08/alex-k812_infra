# alex-k812_infra
alex-k812 Infra repository

# Homework 4
### Create Instance, FW Rule and deploy app
1. Развернута ВМ, на ней развернуты Ruby, MongoDB, поднят Puma сервер.
1. Созданы скрипты: install_ruby.sh для установки Ruby, install_mongodb.sh для MongoDB, deploy.sh для развертывания приложения на web-сервере Puma.
1. Создан общий скрипт startup_script.sh для автоматизации процесса присоздании ВМ на GCP.
1. Создан скрипт gcloud.sh для автоматического развертывания инстанса ВМ и приложения на ней.
1. Для использвания стартап скрипта создан бакет 
```
sudo gsutil mb -l europe-west3 gs://akotus-stuff
```
и скопирован в него
```
sudo gsutil cp /home/ak/GitHub/alex-k812_infra/startup_script.sh gs://akotus-stuff.
```

Команды, использованные для создания инстанса:
```
gcloud compute instances create reddit-app --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --metadata startup-script=gs://akotus-stuff/startup_script.sh
```
Для создания правила FW:
```
gcloud compute firewall-rules create default-puma-server \
--allow tcp:9292 \
--direction INGRESS \
--source-ranges="0.0.0.0/0" \
--target-tags puma-server
```


# Homework 3
## GCP. VPN.
1. Для подключения к ВМ2 в локальной сети за ВМ1 с внешним ip по ssh нужно выполнить следующую команду: ssh -t -i ~/.ssh/ak -A ak@35.207.109.237 ssh 10.156.0.4
1. Для подключения через алиас, в моем случае:ssh inst1, к ВМ2 следует создать ssh конфиг следующего вида:

```
host inst1
    HostName 10.156.0.4
    Port 22
    IdentityFile ~/.ssh/ak
    ProxyCommand ssh ak@bastion -W %h:%p
```
```
host bastion
    HostName 35.207.109.237
    Port 22
    IdentityFile ~/.ssh/akroot@ak-otus:~/.ssh#
```
Развертывание ВПН сервера осуществляется через setupvpn.sh. На сервере создан пользователь test с указанным в задании ПИН-ом, конфигурация для пользователя содержится в файле cloud-bastion.ovpn.
Данные для подключения:
```
bastion_IP = 35.207.109.237

someinternalhost_IP = 10.156.0.6
```
