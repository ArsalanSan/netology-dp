## Дипломный проект.

### Краткое пояснение.
Для реализации проекта я использовал мощьности ЦОД компании. Среда виртуализации используется кластер VMWare. Мне была виделенна подсеть 10.122.207.0/28 расположено в ДМЗ с доступом в интернет. Дополнительно развернул haproxy(для балансировки), nfs сервер(для volumes) и jenkins сервер.

Jenkins так же занимается отслеживанием изменений инфраструктуры с помощью github-webhook.

Код ифраструтуры: https://github.com/ArsalanSan/netology-dp \
Код приложения: https://github.com/ArsalanSan/dp-app.git \
Образ приложения: https://hub.docker.com/r/arsalansan/dp-app/tags


Ссылка на [тестовое приложение](http://dp-app.apctech.ru/) и [веб интерфейс Grafana](http://grafana.apctech.ru/)
