![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

# Algoritmos II

## QuickSort

Ahora vamos a ver un algoritmo mucho más rápido, también es un poco más complejo. QuickSort está diseñado utilizando la Técnica __[Divide and Conquer](https://es.wikipedia.org/wiki/Algoritmo_divide_y_vencer%C3%A1s)__ que consiste en dividir un problema en subproblemas más pequeños, luego encontrar la solución de los problemas pequeños y combinarlas para encontrar la solución mayor.
Además _QuickSort_ es recursivo, o sea que se llama a sí mismo. Básicamente el algoritmo es así:

* Elegir un elemento de la lista de elementos a ordenar, al que llamaremos pivote.
* Mover los demás elementos de la lista a cada lado del pivote, de manera que a un lado queden todos los menores que él, y al otro los mayores. Los elementos iguales al pivote pueden ser colocados tanto a su derecha como a su izquierda, dependiendo de la implementación deseada. En este momento, el pivote ocupa exactamente el lugar que le corresponderá en la lista ordenada.
* La lista queda separada en dos sublistas, una formada por los elementos a la izquierda del pivote, y otra por los elementos a su derecha.
* Repetir este proceso de forma recursiva para cada sublista mientras éstas contengan más de un elemento. Una vez terminado este proceso todos los elementos estarán ordenados.

![QuickSort](../_src/assets/09-Algoritmos_2/Sorting_quicksort_anim.gif)

Como se puede suponer, la eficiencia del algoritmo depende de la posición en la que termine el pivote elegido.

En el mejor caso, el pivote termina en el centro de la lista, dividiéndola en dos sublistas de igual tamaño. En este caso, el orden de complejidad del algoritmo es `O(n·log n)`.

![QuickSortBest](../_src/assets/09-Algoritmos_2/quicksortBest.png)

En el peor caso, el pivote termina en un extremo de la lista. El orden de complejidad del algoritmo es entonces de `O(n²)`.

![QuickSortWorst](../_src/assets/09-Algoritmos_2/quicksortWorst.png)

El peor caso dependerá de la implementación del algoritmo, aunque habitualmente ocurre en listas que se encuentran ordenadas, o casi ordenadas. Pero principalmente depende del pivote, si por ejemplo el algoritmo implementado toma como pivote siempre el primer elemento del array, y el array que le pasamos está ordenado, siempre va a generar a su izquierda un array vacío, lo que es ineficiente.
En el caso promedio, el orden es `O(n·log n)`.

## MergeSort

Este algoritmo está inspirado en QuickSort, así que tambien es recursivo. Lo que hace es lo siguiente:

* Divide el conjunto en dos grupos iguales
* Ordena recursivamente los dos grupos
* Junta (o mergea) los grupos ordenados.

![MergeSort](../_src/assets/09-Algoritmos_2/mergesort.gif)

Ahora veamos su complejidad, que es similar al mejor caso de Quicksort. En cada nivel ( sabemos que hay `log(n)` niveles porque se divide en dos) se realizan `n` operaciones, una por cada elemento.

![MergeSortTime](../_src/assets/09-Algoritmos_2/mergesortTime.png)

Por lo tanto el algoritmo tiene una complejidad de `O (N * log( N ))` en todos los casos, sin importar como esté ordenando al principio!
Lo malo de este algoritmo es que necesita más memoria que los demás algoritmos.

## Otros Algoritmos de ordenamiento

### Heapsort

Este algoritmo tambien tiene orden de `O(n·log n)` pero, contrario a Quicksort, este no depende fuertemente del estado inicial del ordenamiento. Este algoritmo está basado en la estrucura de datos conocida como `heap`, de ahi el nombre.

Primero analizemos qué complejidad tiene el armado del Heap. Cómo habiamos visto, cuando ingresamos un nuevo nodo, tenemos que ver si se siguen cumpliendo las dos reglas de un _heap_: que sea un arbol binario completo, y que cada nodo sea mayor que sus hijos. Básicamente lo que tenemos que controlar es que cuando ingresamos un nuevo nodo, si su valor sea menor que el padre, no hacemos nada. Si no, tenemos que cambiar ese nodo por el padre y controlar de nuevo, si es menor terminamos, o seguimos cambiando hasta llegar al nodo raíz. Habrá veces que cuando ingresas un valor nuevo, ese ya sea menor que el nodo padre, asi que no tenes que hacer nada, si siempre pasara lo mismo el costo de armar el heap sería `O(n)`. Ahora, el peor caso, es tener que llegar hasta la raíz haciendo swaps, sabemos que la altura de un árbol binario es del orden de `log(n)`, por lo tanto en el peor de los casos deberiamos recorrerlo `n` veces, por lo tanto la máxima complejidad es de `n*log( n )`.

Ahora veamos con __Heapsort__ utiliza esta estructura para ordenar. Como vemos el heap está _semi_ ordenado. Por lo pronto sabemos que el nodo ráiz, tiene el máximo valor. Sabiendo eso, lo que hace el algoritmo es sacar el nodo raíz (seria el primer elemento ordenado),  y pone el última nodo del heap en la raíz -esto seguramente rompe la regla de que los padres sean mayores que sus hijos-, y luego reacomoda el árbol para que vuelva a ser un heap. El algoritmo repite esto hasta que no queden nodos en el heap. El resultado es el arreglo ordenado!

![HeapSort](../_src/assets/09-Algoritmos_2/heapSort.gif)

Como tenemos que reordenar el árbol N veces, y habiamos dicho que ordenarlo costaba `O( log (n) )` entonces la complejidad este algoritmo es de `O(N * log(n) )`. Bastante bien, no?

### CountSort

Este algoritmo nos va a servir solamente para contar números enteros. Básicamente, lo que hace es iniciar un arreglo vacio y usarlo para contar los elementos. Para contar, va recorriendo el conjunto desordenado y suma en el arreglo en uno en la posición cuyo índice es igual al numero del conjunto.

![count](../_src/assets/09-Algoritmos_2/countsort.gif)

Finalmente, mira el arreglo de contadores, y vas 'sacando' los elementos que contó. Como lo pusimos en un índice que ya viene ordenado, al sacarlos vamos a tener todos los elementos ordenados.
Nos damos cuenta que este algoritmo puede ocupar muchísima memoria, ya que si tenemos un conjunto con mucha variabilidad vamos a tener un arreglo muy grande y casi vació.

Con respecto a su complejidad, el algoritmo tiene que recorrer una vez el conjunto, o sea que en principio es `O( n )`. Luego tiene que armar de nuevo el conjunto ordenado, ahora no depende de la cantidad de elementos, si no del rango de los elementos que contenia el conjunto, que será el tamaño del arreglo donde ibamos contando, le llamemos M al rango. Ahora la complejidad es de orden `O( M )`. Por lo tanto la complejidad final es del orden de `O ( M + N )`, y podriamos simplificarla si supieramos cúal es de mayor orden. Esta complejidad es mejor que `O(N * log( N ))`. Así que si tenemos que ordenar enteros, este algoritmo nos puede servir.

### Radix Sort

Por último, vamos a mencionar al algoritmo Radix Sort. Este es muy parecido al Count Sort, en el sentido que sólo sirve para ordenar números enteros (en realidad, si logramos representar algo en números enteros, entonces podemos ordenar ese algo con Radix). Básicamente utiliza el mismo principio que Count, ya que mete en un arreglo fijo los números, pero ahora lo hace según las unidades de ese número, una vez ordenado repite el mismo proceso, pero con las decenas, y así sucesivamente hasta terminar con el arreglo ordenado. Veamos el ejemplo de abajo para comprender cómo funciona:

![Radix](../_src/assets/09-Algoritmos_2/radixsort.gif)

## Búsquedas

Otra tarea super importante que vamos a hacer siempre, es buscar un elemento entre una serie de elementos. Para eso vamos a utilizar algoritmos de búsqueda.

### Búsqueda Lineal

Esta solución es la más básica, o de fuerza bruta. Básicamente lo que hacemos es recorrer todo el conjunto, examinando cada uno hasta que encontramos el que queremos o hasta que recorramos todo el conjunto.
Como podrán darse cuenta, este algoritmo es de complejidad `O( N )`, porque en general vamos a tener que recorrer todo el arreglo hasta dar con nuestro objetivo. Este parecer ser una complejidad aceptable, ya que por los algoritmos que vimos antes, la mejor complejidad que lograbamos era cerca de `O(N * log( N ))`. De todos modos, este algoritmo sólo nos va a servir para buscar en conjuntos pequeños, ya que existen otros que son muchos más rápidos.

### Búsqueda Binaria

Cuando buscamos linealmente, en general, no tenemos ninguna pista sobre donde puede estar nuestro elemento objetivo dentro del conjunto. Por lo tanto no nos queda otra que recorrer todo el conjunto, esperando encontrarlo por algún lado. Pero que pasa si de antemano dejamos algunas pistas para que nuestro algoritmo encuentre lo que busca más rápido?
Por ejemplo, si tuvieramos que buscar un número en un arreglo, si ese arreglo estuviera ordenado, podriamos encontrarlo más rápido, no? (se acuerdan del juego de adivinar el número?) De hecho podriamos ir dividiendo el arreglo en mitades y preguntando si nuestro número está de un lado o del otro. Básicamente, estamos reduciendo el espacio de búsqueda a la mitad en cada paso. De esta forma, vamos a llegar a un espacio tan chico (un sólo elemento) donde encontrar el elemento que queríamos es trivial.
Como ya sabemos, al dividir en dos varias veces, vamos a tener `log(n)` niveles, como tenemos que buscar una vez en cada _hoja_ que queda, la complejidad de nuestro algoritmo va a ser de `O( log( n ) )`. Bastante mejor que el anterior, no? Y la complejidad agregada al algoritmo es muy poca. Lo único importante es mantener los datos ordenados!

![BinarySearch](../_src/assets/09-Algoritmos_2/binarySearch.gif)

### Depth/Breadth First Search

Si nos proponemos a recorrer todos los nodos de un árbol, vamos a notar que disintintas personas eligen un método distinto para hacerlo. De hecho, vamos a definir dos formas típicamente usadas para recorrer un árbol entero. Estos métodos pueden ser usados para hacer una búsqueda dentro de un árbol dado.

Consideremos el siguiente árbol:

```js
    A
   / \
  B   C
 /   / \
D   E   F
```

#### Depth First Search

Una búsqueda tipo DFS visitaría los nodos en el siguiente orden:
`A, B, D, C, E, F`. Gráficamente, vamos _bajando_ a través del árbol hasta llegar a una __hoja__. Luego seguidos por la siguiente rama y la recorremos del mismo modo.

#### Breadth First Search

La otra forma: BFS, visitaría los nodos de esta manera:
`A, B, C, D, E, F`. O sea, que recorriamos primero todos los nodos del nivel 1 del árbol, luego los del nivel 2, y así sucesivamente.

## Recursion

La recursión, es cuando un un método se llama a sí mismo. Por ejemplo, el algoritmo quick sort es recursivo (se puede implementar de forma recursiva o no), ya que divide un conjunto y luego ordenada cada subconjunto usando quick Sort tambien.
La recursión puede ser muy poderosa, y puede ayudarnos a resolver algunos problemas que sin ella serían complicados de resolver. A veces puede no ser intuitiva, ya que estamos acostumbrados a pensar de manera iterativa más que recursiva.
Veamos un ejemplo: Habiamos visto la función factorial, básicamente el factorial de n o n! es `n! = 1 * 2 * 3 * 4 * ... * n`. ej: `4! = 1 * 2 * 3 * 4`.
Si lo definimos recursivamente, podemos decir que `n! = n * ( n-1 )!`. O sea, el factorial de n es igual a n por el factorial de n-1. Si lo piensan van a ver que se forma la misma fórmula que antes, pero hay un caso particular que es cuando `n = 0`, en ese caso tenemos que definir que hacemos. Por definición `0! = 1`, así que ese va a ser nuestro __caso base__: es el caso que devuelve algo concreto y donde se termina la recursión, su resultado va a ser usado para calcular los resultados de cada llamada.
O sea que para definir recursivamente la función factorial vamos a decir:

```js
0! = 1
n! = n * (n-1)!
```

Ahora está perfectamente definida.

Si ejecutamos eso tendriamos algo así:

```js
4! = 4 * 3!
   = 4 * 3 * 2!
   = 4 * 3 * 2 * 1!
   = 4 * 3 * 2 * 1 * 0!
   = 4 * 3 * 2 * 1 * 1  <-- acá terminó la ejecución
```

Esto que vemos arriba, es lo que se llama la __pila de recursión__, básicamente se va armando una pila en memoria, ya que la primera llamada necesita el resultado de la segunda, y la segunda de la tercera, y así sucesivamente hasta que llegamos al caso base. Desde ahí se puede empezar a resolver cada llamada dentro de la pila hasta que la completamos entera y tenemos nuestro resultado.

Por lo tanto tenemos que estar seguros que cuando llamamos a un función recursiva no llenemos el _runtime stack_, ya que al llenarse va a crashear el runtime con un error de __[Stack Overflow](http://stackoverflow.com)__, o _desbordamiento de pila_.

## Grafos

Un **Grafo** es una estructura que permite almacenar objetos que tienen relación entre sí. Esos objetos se especifican como **Nodos**. La relación puede ser por distintas razones y también de distinta naturaleza y se especifica como **Enlaces** y puede tener asociado una etiqueta ó un valor numérico y además, esa relación entre los nodos puede ser unidireccional o bidireccional.

Se definen matemáticamente con dos valores:
V: Set de nodos (También llamados vértices).
E: Enlaces, aristas o “edges”.
Grafo = (Vértices, Enlaces) ==> G = (V, E)

Las conexiones de un grafo pueden o no tener relación, puede tener no dirección o puede tenerla y quiere decir que la dirección viaja de un lado y no del otro.

El **grado** de un vértice es el numero de enlaces o aristas que tienen a ese vértice como extremo. Una gráfica puede contener una arista de un vértice a si mismo; tal arista es un bucle cerrado (o lazo). Un bucle cerrado contribuye en 2 unidades al grado de un vértice.



Aplicaciones:
* Redes sociales (para relacionar usuarios)
![Grafo_Redes_Sociales](../_src/assets/09-Algoritmos_2/grafos_twiter.jpg)
* Sistemas de Navegación (Representaciones urbanas y en rutas)
![Grafo_Ciudad](../_src/assets/09-Algoritmos_2/grafos_ciudad.jpg)
* Sistemas de recomendación (Relación de productos con usuarios)
* Enrutamiento de paquetes entre routers (Protocolo TCP/IP)

## Problema de la Distancia más corta entre Nodos del Grafo

El algoritmo de **Dijkstra** es utilizado para resolver esta problemática, se puede definir como un algoritmo que se puede utilizar para encontrar la distancia más corta posible desde un vértice de origen a cualquier otro vértice posible que exista en un gráfico ponderado, siempre que el vértice sea accesible desde el vértice de origen.
El algoritmo de Dijkstra se enfoca en construir una solución pieza por pieza para el problema dado, eligiendo entonces la opción más beneficiosa.
Su funcionamiento es el siguiente:
1) Dados un par de vértices no visitados, seleccione el vértice con la menor distancia desde la fuente y visítelo.
2) A continuación, se actualiza la distancia de cada vecino. Lo mismo se hace para el vértice visitado, que tiene una distancia actual mayor que la suma y el peso del borde dado entre ellos.
3) Los pasos 1 y 2 deben repetirse hasta que no queden vértices no visitados.

![Grafos_ejemplo](../_src/assets/09-Algoritmos_2/Dijkstra_ejemplo.jpg)

### Matríz de adyacencia

Para representar un grafo, se puede utilizar lo que se conoce como **matríz de adyacencia**. La matriz de adyacencia de un grafo es simétrica. Si un vértice es aislado entonces la correspondiente fila (columna) esta compuesta sólo por ceros. Si el grafo es simple entonces la matriz de adyacencia contiene solo ceros y unos (matriz binaria) y la diagonal esta compuesta sólo por ceros.

* Para convertir nuestro grafo en una matriz de adyacencia, analizaremos las conexiones de cada nodo y las representaremos con la forma de una matriz, donde relacionamos los grados de los vértices de cada uno de ellos.
* La suma de las filas de cada vértice nos dirá el total de grados que tiene el vértice

![Matriz_Adyacencia_1](../_src/assets/09-Algoritmos_2/grafos_matriz1.jpg)
![Matriz_Adyacencia_2](../_src/assets/09-Algoritmos_2/grafos_matriz2.jpg)
![Matriz_Adyacencia_3](../_src/assets/09-Algoritmos_2/grafos_matriz3.jpg)

### Algoritmo de Dijkstra en Python.

```python
>>> import sys
>>> 
>>> class Graph():
>>>     def __init__(self, vertx):
>>>       self.V = vertx
>>>       self.graph = [[0 for column in range(vertx)]
>>>                       for row in range(vertx)]
>>>                       
>>>     def pSol(self, dist):
>>>         print("Distancia del vértice desde el orígen")
>>>         for node in range(self.V):
>>>             print(node, "t", dist[node])
>>> 
>>>     def minDistance(self, dist, sptSet):
>>>         min = sys.maxsize
>>>         for v in range(self.V):
>>>             if dist[v] < min and sptSet[v] == False:
>>>                 min = dist[v]
>>>                 min_index = v
>>>         return min_index
>>>  
>>>     def dijk(self, source):
>>>         dist = [sys.maxsize] * self.V
>>>         dist[source] = 0
>>>         sptSet = [False] * self.V
>>>         for cout in range(self.V):
>>>             u = self.minDistance(dist, sptSet)
>>>             sptSet[u] = True
>>>             for v in range(self.V):
>>>                 if ((self.graph[u][v] > 0) 
>>>                     and (sptSet[v] == False) 
>>>                     and (dist[v] > dist[u] + self.graph[u][v])):
>>>                     dist[v] = dist[u] + self.graph[u][v]
>>>         self.pSol(dist)
>>> 
>>> f = Graph(9)
>>> f.graph
[[0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0]]
>>> f.graph = [[0, 4, 0, 0, 0, 0, 0, 8, 0],
           [4, 0, 8, 0, 0, 0, 0, 11, 0],
           [0, 8, 0, 7, 0, 4, 0, 0, 2],
           [0, 0, 7, 0, 9, 14, 0, 0, 0],
           [0, 0, 0, 9, 0, 10, 0, 0, 0],
           [0, 0, 4, 14, 10, 0, 2, 0, 0],
           [0, 0, 0, 0, 0, 2, 0, 1, 6],
           [8, 11, 0, 0, 0, 0, 1, 0, 7],
           [0, 0, 2, 0, 0, 0, 6, 7, 0]
           ]
>>> f.dijk(0)
Distancia del vértice desde el orígen
0 t 0
1 t 4
2 t 12
3 t 19
4 t 21
5 t 11
6 t 9
7 t 8
8 t 14
>>> f = Graph(5)
>>> f.graph = [[0, 1, 0, 0, 0],
           [1, 0, 1, 1, 0],
           [0, 1, 0, 0, 0],
           [0, 1, 0, 0, 1],
           [0, 0, 0, 1, 0]]
>>> f.dijk(0)
Distancia del vértice desde el orígen
0 t 0
1 t 1
2 t 2
3 t 2
4 t 3
```

![Grafos_ejemplo](../_src/assets/09-Algoritmos_2/grafos_ejemplo.png)

## Grafos: Recursos Adicionales

* [Teoría de Grafos] (https://www.topcoder.com/community/competitive-programming/tutorials/introduction-to-graphs-and-their-data-structures-section-1/)
* [Euler y los puentes de Königsberg, actualmente Kaliningrado] (https://es.wikipedia.org/wiki/Grafo)
* [Dijkstra-Floyd-Warshall] (http://micaminomaster.com.co/grafo-algoritmo/algoritmos-dijkstra-floyd-warshall-python-3-5/)
* [Matríz de Adyacencia] (https://es.wikipedia.org/wiki/Matriz_de_adyacencia)

## Homework

Completa la tarea descrita en el archivo [README](https://github.com/soyHenry/Python-Prep/blob/4aec1885136fdcff98899d2be13c8908b39f8b21/02%20-%20Variables%20y%20Tipos%20de%20Datos/Prep_Course_Homework_02.md)

<table class="hide" width="100%" style='table-layout:fixed;'>
  <tr>
    <td>
      <a href="https://airtable.com/shrCubCO1XC2BwYIT?prefill_clase=9-AlgoritmosII">
        <img src="https://static.thenounproject.com/png/204643-200.png" width="100"/>
        <br>
        Hacé click acá para dejar tu feedback sobre esta clase.
      </a>
    </td>
  </tr>
</table>
