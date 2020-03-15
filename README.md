TWEET 🐁 <img align="right" src="https://github.com/siorellana/EnerApp/blob/master/src/favicon.png">
=======

![This software is Blessed](https://img.shields.io/badge/blessed-100%25-770493.svg)

Para quienes deben utilizar el metro y no tienen tiempo (ni ganas) de revisar constantemente las cuentas de twitter de [@metrodesantiago](https://twitter.com/metrodesantiago) y [@TCC_oficial_](https://twitter.com/TCC_oficial_) para detectar oportunamente algún problema en el transporte. Con estos scripts pegados con amor podrán monitorear los tweets de ambas cuentas, compartirlos a Slack y permitir el enviar notificaciones directas a usuarios según sus filtros definidos dentro del YAML.  

Instalación
----
Teniendo la versión 2.6.5 de Ruby instalada, deberás utilizar la gema 'bundler' que se encargará de resolver las dependencias definidas en el Gemfile.
```
gem install bundler
```

Con eso listo, ejecuta dentro del directorio:
```
bundler install
```

Con esto ya tienes lo suficiente para ejecutar los scripts pero antes de eso, necesitaras crear la configuración con los tokens e información adecuada.

Configuración
----

TODO


```
---
twitter:
  config:
    follow:
      73459349:
        - "/(.*)/"
      1187606581363531776:
        - "/(.*)/"
    tokens:
      consumer_key: ""
      consumer_secret: ""
      access_token: ""
      access_token_secret: ""
slack:
  config:
    name: "Pathfinder"
    icon: "https://i.imgur.com/ABKU5iv.png" # sad: https://i.imgur.com/FY34y2i.png not found: https://i.imgur.com/jV3M6Yx.png doubt: https://i.imgur.com/gadkLJn.png
    channel: "#hq-alerts"
  tokens:
    prod: ""
  users:
    user-id-1:
      - "(L1|L5)"

```