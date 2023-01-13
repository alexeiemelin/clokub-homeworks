# Домашнее задание к занятию "15.1. Организация сети"

Домашнее задание будет состоять из обязательной части, которую необходимо выполнить на провайдере Яндекс.Облако и дополнительной части в AWS по желанию. Все домашние задания в 15 блоке связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
Все задания требуется выполнить с помощью Terraform, результатом выполненного домашнего задания будет код в репозитории. 

Перед началом работ следует настроить доступ до облачных ресурсов из Terraform используя материалы прошлых лекций и [ДЗ](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax ). А также заранее выбрать регион (в случае AWS) и зону.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

1. Создать VPC.
- Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

Resource terraform для ЯО
- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)

Ответ:

Config лежит в папке /terraform

Подключился к вм1

```bash
user@user:~/PycharmProjects/clokub-homeworks_true/15.1/terraform$ yc compute instance list
+----------------------+------+---------------+---------+----------------+----------------+
|          ID          | NAME |    ZONE ID    | STATUS  |  EXTERNAL IP   |  INTERNAL IP   |
+----------------------+------+---------------+---------+----------------+----------------+
| fhm1u6jhnsg66vkic2gk | vm2  | ru-central1-a | RUNNING | 51.250.73.81   | 192.168.20.10  |
| fhm58p7e6vs1ksrhglot | nat  | ru-central1-a | RUNNING | 158.160.44.83  | 192.168.10.254 |
| fhmbomur49fnqp5usroj | vm1  | ru-central1-a | RUNNING | 84.252.128.249 | 192.168.10.25  |
+----------------------+------+---------------+---------+----------------+----------------+

user@user:~/pycharm-community-2021.3/bin$ ssh ubuntu@84.252.128.249
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-39-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
New release '22.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Fri Jan 13 12:35:44 2023 from 185.27.50.154
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

Проверил inet

```bash
ubuntu@fhmbomur49fnqp5usroj:~$ ping ya.ru
PING ya.ru (87.250.250.242) 56(84) bytes of data.
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=58 time=3.41 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=2 ttl=58 time=0.466 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=3 ttl=58 time=0.417 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=4 ttl=58 time=0.443 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=5 ttl=58 time=0.390 ms
^C
--- ya.ru ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4067ms
rtt min/avg/max/mdev = 0.390/1.025/3.411/1.193 ms
```

Подключился с vm1 на vm2

```bash
ubuntu@fhmbomur49fnqp5usroj:~$ ssh ubuntu@51.250.73.81
load pubkey "/home/ubuntu/.ssh/id_rsa": invalid format
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-39-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
New release '22.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Fri Jan 13 12:48:54 2023 from 185.27.50.154
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

Проверил inet

```bash
ubuntu@fhm1u6jhnsg66vkic2gk:~$ ping ya.ru
PING ya.ru (87.250.250.242) 56(84) bytes of data.
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=59 time=0.805 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=2 ttl=59 time=0.416 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=3 ttl=59 time=0.387 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=4 ttl=59 time=0.414 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=5 ttl=59 time=0.483 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=6 ttl=59 time=0.480 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=7 ttl=59 time=0.441 ms
^C
--- ya.ru ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6123ms
rtt min/avg/max/mdev = 0.387/0.489/0.805/0.132 ms
```

```

---
## Задание 2*. AWS (необязательное к выполнению)

1. Создать VPC.
- Cоздать пустую VPC с подсетью 10.10.0.0/16.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 10.10.1.0/24
- Разрешить в данной subnet присвоение public IP по-умолчанию. 
- Создать Internet gateway 
- Добавить в таблицу маршрутизации маршрут, направляющий весь исходящий трафик в Internet gateway.
- Создать security group с разрешающими правилами на SSH и ICMP. Привязать данную security-group на все создаваемые в данном ДЗ виртуалки
- Создать в этой подсети виртуалку и убедиться, что инстанс имеет публичный IP. Подключиться к ней, убедиться что есть доступ к интернету.
- Добавить NAT gateway в public subnet.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 10.10.2.0/24
- Создать отдельную таблицу маршрутизации и привязать ее к private-подсети
- Добавить Route, направляющий весь исходящий трафик private сети в NAT.
- Создать виртуалку в приватной сети.
- Подключиться к ней по SSH по приватному IP через виртуалку, созданную ранее в публичной подсети и убедиться, что с виртуалки есть выход в интернет.

Resource terraform
- [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
