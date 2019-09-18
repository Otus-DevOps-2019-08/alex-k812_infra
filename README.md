# alex-k812_infra
alex-k812 Infra repository

## Homework 3
# GCP. VPN.
1. Для подключения к ВМ2 в локальной сети за ВМ1 с внешним ip по ssh нужно выполнить следующую команду: ssh -t -i ~/.ssh/ak -A ak@35.207.109.237 ssh 10.156.0.4
1. Для подключения через алиас (*в моем случае:ssh inst1*) к ВМ2 следует создать ssh конфиг следующего вида:
*host inst1*
*    HostName 10.156.0.4*
*    Port 22*
*    IdentityFile ~/.ssh/ak*
*    ProxyCommand ssh ak@bastion -W %h:%p*

*host bastion*
*    HostName 35.207.109.237*
*    Port 22*
*    IdentityFile ~/.ssh/akroot@ak-otus:~/.ssh#*

Развертывание ВПН сервера осуществляется через setupvpn.sh. На сервере создан пользователь test с указанным в задании ПИН-ом, конфигурация для пользователя содержится в файле cloud-bastion.ovpn.
Данные для подключения:
bastion_IP = 35.207.109.237
someinternalhost_IP = 10.156.0.4
