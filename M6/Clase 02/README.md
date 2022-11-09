![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

# **MODELOS DE CLASIFICACIÓN**

En los problemas de clasificación utilizamos algoritmos de ML que nos permiten diferenciar si un conjunto de datos pertenece a una determinada clase o a otra/s. El resultado de nuestra función $f(X)=y$ es una etiqueta de categoría, por lo que el algoritmo debe discernir si ciertos valores/atributos pertenecen a cierta categoría o no. 

En la presente clase abordaremos dos modelos predictivos para los problemas de clasificación del aprendizaje supervisado: `árboles de decisión` y `vecinos más cercanos.`

Como veníamos viendo, en el aprendizaje supervisado tenemos tres pasos indispensables:

1. En la primera etapa, tomamos nuestros datos e identificamos como variables predictoras **X** a algunas características, y en una variable **y** al atributo que queremos predecir. Cada componente x (instancia) de **X** (todas las instancias) tiene asociada una etiqueta y en **y**.

2. Le “mostramos” pares (x,y) —pares asociados de variables predictoras y etiquetas— a un modelo preparado para aprender de nuestros datos, de forma tal que crea un conjunto de reglas o asociaciones para, dada una entrada **x**, predecir su salida **y**. Esta fase se conoce como entrenamiento.

3. Una vez que el modelo está entrenado, podemos utilizarlo. En esta etapa -denominada *predicción*-, lo que esperamos es que el modelo nos diga la etiqueta correspondiente a instancias cuya etiqueta no conocemos.

El fundamento de los dos modelos que veremos en esta clase está bien diferenciado. El árbol de decisión busca encontrar en los datos preguntas que le permitan clasificar nuevas instancias a partir de los valores de algunas de sus propiedades. Vecinos más cercanos, por su parte, define las etiquetas viendo las instancias de entrenamiento más parecidas a la instancia que queremos clasificar.

---

## **`Árboles de decisión`**

Un árbol de decisión es una estructura compuesta de nodos, ramas y hojas. Dada una nueva instancia, esta es clasificada recorriendo el árbol de decisión: en cada nodo, el árbol hace una pregunta a la instancia sobre alguno de sus atributos. Según la respuesta a esta pregunta, deriva a la instancia por alguna de sus ramas, donde puede ocurrir que aparezca otro nodo -otra pregunta- o que termine en una hoja. La hoja contiene la etiqueta que le corresponde a esa instancia, finalizando su recorrido en el árbol.

En esencia, el árbol hace preguntas y va clasificando de acuerdo a las respuestas. Podría pensarse como una combinación if-elif-else y return.

A continuación, mostramos un esquema de funcionamiento de un árbol de decisión para clasificar un set de datos que contiene 3 categorías de flores:

<img src="https://www.iartificial.net/wp-content/uploads/2019/05/arbol-iris.png"   
width="500px" height="500px">
</p>

A raíz de estas preguntas, las fronteras de decisión quedarían conformadas de la siguiente manera:

<img src="..\_src\assets\arbol_iris.png"   
width="500px" height="350px">
</p>

Ahora bien, ¿cómo decide el árbol qué preguntas realizar? Para esto, hay dos criterios: `Impureza Gini` o `Entropía`.

## ***Impureza Gini***

La impureza gini se calcula con la proporción de instancias que corresponden a cada clase en cada pregunta que realiza el árbol. Cuanto más alto es su valor, más impura es la muestra. En síntesis, la impureza gini cuantifica cuán puro (instancias con la misma etiqueta) es un conjunto. A más homogeneidad en las etiquetas, más puro es.

Como te imaginarás, la idea es ir construyendo preguntas para cada feature y viendo cuál es la que mejor separa las clases. Se elige el atributo con mayor reducción de impureza. Por supuesto, esto lo hará el modelo por nosotros.

Cuando las hojas contienen muestras de una sola clase, se dice que son hojas puras y ya no se pueden crear más ramas a partir de ellas -es decir, no se pueden desprender más preguntas-. En cambio, si las hojas contienen muestras de varias clases, son hojas impuras. Vale aclarar que cuantas más preguntas haga el árbol, más profundo será.

## ***Entropía***

También conocido como *ganancia de información*, este criterio se utiliza para medir el grado de impureza de una muestra y elegir el atributo que más la reduce. Como vemos, su esencia es bastante parecida al criterio anterior.

Existen otros criterios, que tienen ventajas en algunas situaciones específicas (por ejemplo, `Gain Ratio`, que corrige la preferencia de ganancia de información por atributos con demasiados valores).

Para comprender un poco más acerca del funcionamiento del árbol de decisión, recomendamos este [artículo](https://towardsdatascience.com/scikit-learn-decision-trees-explained-803f3812290d) de Towards Data Science.

## ***Prune tree***

Después de realizar iteraciones suficientes, puede que nuestro árbol haya quedado demasiado "grande". Uno de los criterios más utilizados para la selección de modelos es la parsimonia: el modelo debe ser lo más simple posible (recordemos que son representaciones de la realidad).

Por eso se realiza lo que se llama **pruning**: se poda el árbol hasta que sacar un nodo no mejore la performance del modelo en un test set.

Si bien pueden utilizarse funciones de costo para determinar hasta cuándo la poda es eficiente, el criterio del data scientist y la interpretabilidad del árbol deben siempre ser tenidas en cuenta.

---
## **Ejemplo de uso**

Vamos a repasar visualmente cómo funciona un árbol con un ejemplo tradicional en la materia: las especies de polillas. Tenemos un dataset con dos especies de polillas: *luna* y *emperador*. Asimismo, contamos con dos atributos: masa y envergadura. Miremos el dataset con el que contamos:

<img src="../_src/assets/arbol_decision_polillas_tabla.jpg"  height="500">

El árbol irá realizando preguntas para cada uno de los features, viendó cuál es la que mejor separa las clases.


|Pregunta del árbol en la rama|Registros que cumplen la condición|
|-|-|
|<img src="../_src/assets/arbol_decision_preg1.jpg"  height="200">|<img src="../_src/assets/arbol_decision_polillas_tabla2.jpg"  height="400">|

|Pregunta del árbol en la rama|Registros que cumplen la condición|
|-|-|
|<img src="../_src/assets/arbol_decision_preg2.jpg"  height="200">|<img src="../_src/assets/arbol_decision_polillas_tabla3.jpg"  height="400">|

A continuación, mostramos cómo el árbol va calculando internamente el índice gini a partir de la pureza de sus muestras en cada una de las hojas:

<img src="../_src/assets/arbol_decision_preg3.jpg"  height="300">

¿Qué atributo pensás que debería elegir el árbol para comenzar a preguntar?

La cantidad de preguntas que realice va a estar directamente relacionada con la profundidad que queramos darle al árbol. Ya volveremos sobre este concepto.


## **Ventajas y desventajas de los árboles de decisión**

Ventajas:

+ Fáciles de entender, interpretar y visualizar. Esto ayudará a la hora de comunicar nuestro trabajo

+ Entrenamiento rápido

+ Modelo base para otros más complejos (Random Forest, XGBoost, etc.)

Desventajas:

+ Poder de generalización relativamente bajo en ciertas circunstancias 

+ Desempeño inferior a modelos más modernos

---

## **`Vecinos más cercanos`**

Ahora veremos otro de los algoritmos predictivos de clasificación: *K-Nearest-Neighbor*.

Considerado un aprendiz perezoso, ya que no hay aprendizaje propiamente dicho en el modelo, K-vecinos cercanos predice la clasificación para un nuevo dato buscando, entre todos los pertenecientes al set de entrenamiento, a los K vecinos más parecidos.

Supongamos, entonces, que tenemos una instancia -llamémosle *p*- de la cual queremos saber su etiqueta; entonces, simplemente lo que necesitamos hacer es buscar la instancia más parecida -más cercana- que esté etiquetada y asignarle a *p* la etiqueta de esa instancia. Es decir, la etiqueta que asigna Vecinos más cercanos es la etiqueta de la instancia más parecida, lo que denominamos el vecino más cercano. El proceso se repite K veces para obtener los k-vecinos cercanos.

Veamos ahora un ejemplo. Si quisiéramos clasificar el punto blanco, ¿a qué categoría correspondería?


<img src="..\_src\assets\knn.jpg" >
</p>

Pues bien, si buscáramos su vecino más cercano, le debería corresponder el color gris.

<img src="..\_src\assets\knn_2.jpg" >
</p>

Ahora deberíamos definir ¿cómo medimos cercanía, es decir, distancias?

Una de las distancias más utilizadas es la `distancia Euclídea o L2`, que es básicamente la menor distancia entre dos puntos en 2D. De manera más general, se define la distancia Euclídea de la siguiente manera:

<img src= "https://latex.codecogs.com/svg.image?{\color{Golden}&space;d(a,b)=\sqrt{\sum_{i=1}^n&space;(a_i&space;-b_i)^2}}">

Es la raíz cuadrada de la suma del cuadrado de las diferencias entre el punto **a** y el punto **b**.

Pero esta distancia no es la única que podemos tener en cuenta. Pensemos cuando Google Maps nos señala cómo ir de un punto a otro. Este tipo de distancia se conoce como `distancia de Manhattan o L1` y su formulación es la siguiente:

<img src= "https://latex.codecogs.com/svg.image?{\color{Golden}d(a,b)=&space;|a_i&space;-b_i|}"/>

Ambas distancias se insertan en lo que se conoce como ***métricas de Minkowski***.

En el ejemplo de recién, consideramos un solo vecino para realizar la clasificación -de allí que en el segundo gráfico observemos "k = 1"-.

Por regla general se suele utilizar k-vecinos más cercanos. Es decir, se buscan las k-instancias más cercanas y se asigna la etiqueta más frecuente (moda) entre esas instancias.

En resumen, las principales variaciones de K-NN son:

+ La cantidad de vecinos a considerar, k

+ La métrica de distancia a utilizar

+ Ponderación del voto. Podemos asumir que las instancias que estén más cerca de *p*, probablemente sean más parecidas. Entonces, podríamos asignar un peso en la votación a cada instancia vecina de p, dándole mayor importancia a las cercanas y menos a las lejanas

- - -

## **Ventajas y desventajas de vecinos más cercanos**

Ventajas:

+ Simple de interpretar

+ Rápido para entrenar

+ Nuevos datos no impactan en la precisión del algoritmo

+ El modelo se comporta bien ante un problema de clasificación multiclase

Desventajas:

+ Lento para predecir

+ Ocupa mucho espacio en disco (tiene que guardar todo el set de entrenamiento)

+ La métrica de distancia a elegir no es manifiesta

+ No se comporta de manera adecuada en datasets con muchas dimensiones (high dimensional data)

- - - 

Con los contenidos teóricos que has visto en esta clase, ahora es momento de pasar a la práctica e instanciar tus primeros modelos predictivos de árbol de decisión y K-NN.

![Homero](https://c.tenor.com/noQKXza6-GYAAAAC/simpsons-homer.gif)
