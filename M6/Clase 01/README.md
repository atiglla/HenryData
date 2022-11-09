![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

# **Machine Learning**

## **Introducción**

  
<img src="https://www.hiberus.com/sites/default/files/inline-images/Machine%20Learning_0.jpg"   
width="800px" height="400px">



En el transcurso de este módulo haremos un recorrido por cada una de las temáticas esenciales de Machine Learning (en adelante, "ML"). Veremos cuál es su alcance, características, metodología, aplicabilidad y casos de uso. 
Abordaremos, a su vez, los elementos centrales de campos como `series de tiempo`, `procesamiento de lenguaje natural` y `sistemas de recomendación`.

Finalmente, en la última clase repasaremos algunas nociones de `Deep Learning`.

Como podemos observar en la imagen supra, ML se inserta en una disciplina más general, macro, conocida como **Inteligencia Artificial**. Para profundizar un poco en estos conceptos, recomendamos acceder al video que se deja a continuación.


[AI, ML & DL](https://www.youtube.com/watch?v=6iVUKYgOihQ&ab_channel=AprendeIAconLigdiGonzalez)

La pregunta clave que buscaremos responder en esta sección es: ¿cómo hacemos para que las computadores aprendan de los datos?

Para ello, debemos comenzar hablando de modelos matemáticos y cómo estos se relacionan con ML.

Los modelos matemáticos son descripciones de un sistema que usa conceptos y lenguaje matemático, que pueden ayudar a estudiar los efectos de diferentes componentes y hacer predicciones relacionadas a este comportamiento. Este proceso de agrupar información en una herramienta para explicar y predecir se llama ***modelado*** y se estructura alrededor de una idea: por qué ciertos eventos acontecieron, acontecen y acontecerán. 
En esta línea, una primera aproximación a un modelado podría armarse con las observaciones y los patrones que se desprenden de eventos pasados, ya que podríamos aseverar que en el futuro podrían repetirse esos componentes y eventos.

## *Ejemplo clásico*

Para avanzar con los contenidos de ML, nos detendremos ahora en un ejemplo que demuestre su funcionalidad.
Para este claso, empleamos un ejemplo de Correo Spam.

<img src= "https://miro.medium.com/max/1400/1*WA9aceQugVlBS81r2a7Snw.png" height="300">


Habitualmente, recibimos correos en nuestra casilla. Algunos tendrán un contenido que es de nuestro interés, pero otros serán correos no deseados. Ahora bien, ¿cómo hace el sistema para distinguir un correo spam de otro que no lo es? En definitiva, ¿cómo lo detecta?
En efecto, con un modelo de Machine Learning. El algoritmo clasificador, en este caso, separa los correos deseados de aquellos que detecta como spam.

<img src="..\_src\assets\spam.jpg" height="300">

Para nosotros sería bastante fácil poder detectar un correo spam. Pero para la máquina esto requiere de un nivel de abstracción bastante amplio. Debe entender el texto, relacionar las palabras, buscar patrones, etc. Además, debe buscar palabras clave. A priori, ya sabemos que si en un correo tenemos las palabras "príncipe", "cuenta bancaria" o "herencia" probablemente estemos frente a un correo spam.

- - - 

## **Esquema de ML**


En el siguiente esquema podremos observar las tres grandes ramas en las que se subdivide Machine Learning:

<p align="center">
<img src="https://pbs.twimg.com/media/ETNlvGZUYAI2iF5.jpg:large"   
height="500px">
</p>

Respecto al alcance de este módulo, abordaremos **APRENDIZAJE SUPERVISADO** y **APRENDIZAJE NO SUPERVISADO**.

## **Aprendizaje supervisado**

>$f(X) = y$

Buscamos un modelo ***f*** que permita determinar la salida ***y*** a partir de la entrada ***X***.

En esta función, ***X*** son los atributos -generalmente se denota con mayúscula porque incluye más de una variable- e ***y*** es la etiqueta. 

El aprendizaje supervisado permite modelar la relación entre las características medidas de los datos y alguna etiqueta asociada con ellos.
Es decir, podremos predecir ***y*** para nuevos datos ***X*** de los cuales no conozcamos la salida.

De acuerdo al tipo de etiquetas que asociamos a los datos, el modelo puede realizar dos tipos de tareas:

+ **`Clasificación:`** las etiquetas son categorías. Ejemplo: enfermo/sano, gato/perro/pájaro, spam/no spam.

+ **`Regresión:`** la variable de salida es un valor numérico. Ejemplo: precio, cantidad, temperatura.

## **Aprendizaje no supervisado**

En este caso, se deja que el conjunto de datos hable por sí mismo. Este modelo tiene datos de entrada, pero no se busca una salida en particular. Implicar modelar las características de un conjunto de datos sin referencia a ninguna etiqueta.

La función de este tipo de algoritmos es encontrar patrones de similaridad. Por eso, incluyen tareas como **`clustering`** (agrupación) y **`reducción de dimensionalidad`**. En este último, el algoritmo busca representaciones más concisas de los datos. En clustering, busca identificar distintos grupos de datos.

Ejemplo de clustering:

<img src="..\_src\assets\clustering.jpg">
  

- - -

## **Correlación**

Por último, para finalizar la parte teórica de esta clase, abordaremos la temática referente a correlación.

En primer lugar, debemos definir la correlación como `concepto teórico` para, en segundo lugar, definirla como `estadístico` (recordemos que un estadístico es cualquier función de la muestra).

La correlación como concepto teórico puede definirse como la relación estadística que tienen dos variables aleatorias entre sí. Esta puede ser o no causal, ya que podemos estar en presencia de una **correlación espuria**. La correlación espuria nos dirá que las variables están relacionadas, cuando en realidad no existe relación causal directa entre ellas.

En cuanto a la correlación como estadístico, es importante diferenciar dos conceptos:

+ *Covarianza*: valor que indica el grado de variación conjunta de dos variables aleatorias respecto a sus medias. Depende de la escala de los datos. Es por este motivo que se suele emplear la correlación, definida a continuación.

+ *Correlación de Pearson*: es la covarianza dividida por el producto de la desviación estándar de cada variable aleatoria.

La correlación nos sirve para determinar qué variables están relacionadas entre sí, con qué intensidad y si siguen una misma dirección o no. Saber qué variables están correlacionadas nos ayudará a construir mejores modelos predictivos.

La correlación no tiene que ser necesariamente lineal. También podemos estar ante dos variables correlacionadas aunque esta relación no se presente de forma lineal.

Para profundizar sobre los tipos de correlación `Pearson`, `Spearman` y `Kendall`, sugerimos este [artículo](https://www.cienciadedatos.net/documentos/pystats05-correlacion-lineal-python.html#:~:text=La%20correlaci%C3%B3n%20de%20Kendall%20es%20un%20m%C3%A9todo%20no%20param%C3%A9trico%20que,cumple%20la%20condici%C3%B3n%20de%20normalidad).

Cerramos esta clase con la siguiente proposición que representa un escenario al que se enfrentarán en múltiples ocasiones y resulta menester identificar: ***correlación no implica causalidad***.


<p align="center">
<img src="https://miro.medium.com/max/1400/1*ERarZ75RoWF8Vn-_AlEmaA.jpeg"
width="1000px" height="400px">
</p>

- - -

## `Práctica`

La estructura de este módulo, para cada una de sus clases, se compone de la siguiente manera:

1. Clase teórica

2. Clase práctica

La primera parte se aborda en los respectivos README. La segunda parte, a través de notebooks donde realizamos prácticas guiadas para bajar a tierra algunos de los conceptos vistos en la teoría.

La práctica de hoy se divide en dos:

+ Práctica_01: regresión lineal

+ Práctica_02: regresión logística
