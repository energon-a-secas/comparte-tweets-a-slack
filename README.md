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

Siguiendo el formato del ejemplo `./config/conf.yml.example`, tendrás que crear en la misma ruta un archivo llamado `conf.yml` el cual contendrá tanto las credenciales como configuraciones necesarias para funcionar. 

Para facilitar la explicación de que debe ir en cada campo, se seguirá el orden del ejemplo ya mencionado.

### Twitter

#### Accounts
El primer campo es el ID de la cuenta de Twitter, dentro de estos se encuentra un listado, siendo el primer elemento lo que espera incluir, por defecto, todo.

Se utiliza un máximo de dos cuentas debido a los errores generados por los limites de consultas impuestos por la API de Twitter.
#### Tokens
Los cuatro campos corresponden a credenciales necesarias para utilizar la API de Twitter. 

Para obtenerlas tendrás que crear una [cuenta de desarrollador](https://developer.twitter.com/en/docs/basics/developer-portal/overview) y asociarle una [aplicación](https://developer.twitter.com/en/docs/basics/apps/overview). La solicitud no es difícil, solamente requieres de paciencia, justificar el uso de tu "posible" aplicación, finalmente aceptando los términos y condiciones de Twitter. 

### Slack

#### Config

Estos campos influyen en la publicación de mensajes en Slack, de la siguiente forma:
- name: nombre del (bot|integración).
- icon: imagen a partir de una URL del (bot|integración).
- channel: canal donde se publicará todo a menos que se pase como argumento al método correspondiente.

#### Users
El primer campo es la ID de Slack del usuario seguido de una lista con sus filtros.

#### Tokens
Solamente requiere de una credencial para utilizar la API de Slack. Para obtenerla puedes solicitar un token de hubot y estarás al otro lado.