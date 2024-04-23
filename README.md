## Дипломный проект.

### Краткое пояснение.
Для реализации проекта я использовал мощьности ЦОД компании. Среда виртуализации используется кластер VMWare. Мне была виделенна подсеть 10.122.207.0/28 расположено в ДМЗ с доступом в интернет. Дополнительно развернул haproxy(для балансировки), nfs сервер(для volumes) и jenkins сервер. Jenkins так же занимается отслеживанием изменений инфраструктуры с помощью github-webhook.

Код ифраструтуры: https://github.com/ArsalanSan/netology-dp \
Код приложения: https://github.com/ArsalanSan/dp-app.git \
Образ приложения: https://hub.docker.com/r/arsalansan/dp-app/tags

Ссылка на [тестовое приложение](http://dp-app.apctech.ru/) и [веб интерфейс Grafana](http://grafana.apctech.ru/)

## Этапы выполнения:

### Создание облачной инфраструктуры

![](img/11.png)
![](img/12.png)

### Создание Kubernetes кластера

Создал ansible скрипт: https://github.com/ArsalanSan/netology-dp/blob/main/playbook/install_k8s.yaml

![](img/21.png)

### Создание тестового приложения

Тестовое приложение: https://github.com/ArsalanSan/dp-app.git \
Регистри с собранным docker image: https://hub.docker.com/r/arsalansan/dp-app/tags

### Подготовка cистемы мониторинга и деплой приложения

Манифесты kube-prometheus: https://github.com/ArsalanSan/netology-dp/tree/main/manifests/kube-prometheus \
Ссылка на графану: http://grafana.apctech.ru/

![](img/41.png)

### Установка и настройка CI/CD

Пайплайн для создания докера: https://github.com/ArsalanSan/dp-app/blob/main/Jenkinsfile \
Пайплайн для отлеживания инфраструктуры: https://github.com/ArsalanSan/netology-dp/blob/main/Jenkinsfile

Создал ansible скрипт: https://github.com/ArsalanSan/netology-dp/blob/main/playbook/jenkins.yaml

### Скрины выполнения

![](img/61.png)
![](img/62.png)
![](img/63.png)
![](img/64.png)
![](img/65.png)
![](img/66.png)

Артифакт терраформа хранится в jenkins
![](img/67.png)

Backend S3 с блокировкой в YBD
![](img/68.png)