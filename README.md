# EasyBroker - Prueba técnica

### Rails version: '6.1.4.4'
### Ruby version: '2.7.2'

Este es el repositorio para la prueba técnica de EasyBroker. <br>
Para cumplir los requisitos principales, utilicé un controlador con el nombre `properties_controller`, el cúal posee tres métodos: <br>
* `index`, el cual lista propiedades y también contiene el código para la paginación
* `show` el cual busca una propiedad en base a `params[:id]` y devuelve la información requerida
* `post_contact`, el cual recibe parametros de un `form_tag`, los asigna a un objeto, los convierte a JSON y los envía al endpoint para crear un nuevo lead. <br>
> Cabe destacar que todos los métodos utilizan la gema Httparty para hacer los requests a la API de EasyBroker. <br>

Dado a que la página estará consumiendo una API externa, al crear el proyecto utilicé el flag `--skip-active-record` para evitar que se creara una base de datos, la cual no sería necesaria. <br>

* Para utilizar el proyecto localmente hay que clonarlo, ejecutar `bundle` o `bundle install` en la carpeta raíz y estaría listo para correr. También asegurarse de tener las versiones de rails y ruby correspondientes. 
* Los tests se encuentran el la carpeta `spec/` y se pueden ejecutar usando `rspec`. 
* La gema simplecov genera un informe sobre la cobertura de tests cada vez que se ejecuta el comando `rspec`. Estos se pueden encontrar en la carpeta `coverage/`

### Gemas utilizadas
* `gem 'httparty', '~> 0.13.7'`
* `gem 'rspec-rails', '~> 5.0.0'`
* `gem "webmock"`
* `gem 'vcr', '~> 5.0'`
* `gem 'simplecov'`

### Algunas decisiones de diseño
* Para listar las propiedades utilize un partial llamado `cards` y a este le pase un `obj`, el cual tiene asignado la `@response` que recibo en el controlador.
* El contact form que está en la página de propiedad individual también se encuentra en un partial, al igual que el punto anterior, es para optimizar el código.
* La páginación del `index` y el slideshow del `show` también se encuentran en partials.
* Utilicé flash messages (por supuesto también en un partial) con dos types (`notice` y `danger`) para el contact form, así el usuario tiene un mensaje más claro de lo que está sucediendo, ya sea mensaje de éxito o error.
* En un principio, escribí todo el CSS dentro de `application.scss`, pero al ver que se hacían demasiadas líneas de código, decidí dividir por secciones y hacer archivos separados para cada una, y luego importarlos al `application.scss`. No quise repetir el error de tener más de 900 líneas en un solo archivo como me sucedió en otro proyecto.

### ¿Qué fue lo más difícil durante el desarrollo del proyecto?
Diría que los tests, ya que nunca antes había testeado código el cuál usaba una API externa, y no lograba entender del todo la documentación que encontré mientras investigaba en el internet. Hacer los tests en sí no fue dificil y no me llevó mucho tiempo, ya que en base a lo que leí y mis conocimientos previos decidí testear los `requests` usando `Rspec`, `VCR` y `Webmock`, con el agregado de `simplecov` para chequear el porcentaje de cobertura de tests. 
### ¿Qué hubiera hecho de no tener límite de tiempo / contar con más tiempo?
Me hubiera gustado, una vez finalizada la lógica del backend, enfocarme en crear un diseño atractivo y responsive. Aparte de eso, dedicar tiempo para optimizar mi código tanto como pueda. 
### ¿Qué parte de mi código considero que no es 'limpio'?
Yo diría que el método `post_contact` en el `properties_controller`. De tener más conocimiento y/o experiencia, me gustaría haberlo dejado más pequeño. Aun así, creo que cumple su funcionalidad y no es difícil de leer y mantener. 
### Bugs y optimizaciones que no pude realizar
* En el slideshow que se encuentra en la página que muestra la propiedad individual, las imagenes no cargan al entrar por primera vez, pero si lo hacen al recargar el sitio. Sospecho que puede ser algun problema con javascript u OwlCarousel, pero no he podido encontrar una solución hasta ahora.
* Creé un archivo `variables.rb` en el cual están las variables BASE_URL, HEADERS y QUERY, para poder reutilizarlas tanto en el `properties_controller` como en los tests y así evitar la repetición de código, pero la acción `index` que posee una paginación hecha a mano, en el hash `query` que envío al request de Httparty he tenido que escribir el query a mano ya que si utilizo la variable QUERY la paginación se rompe y deja de funcionar. Hasta el momento, es la mejor solución que encontré. 

![This is an image](https://i.postimg.cc/QCJz5n9H/Screenshot-from-2021-12-21-14-07-22.png)
![This is an image](https://i.postimg.cc/Xqbhr0vR/Screenshot-from-2021-12-21-14-07-27.png)
![This is an image](https://i.postimg.cc/59BTZj7b/Screenshot-from-2021-12-21-14-07-49.png)
![This is an image](https://i.postimg.cc/xCHhjd9G/Screenshot-from-2021-12-21-14-07-53.png)
