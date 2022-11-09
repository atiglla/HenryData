![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Listas Enlazadas

Básicamente, las listas enlazadas, son una secuencia de nodos enlazados entre ellos y que contienen información. Podemos decir que cada nodo contiene datos y además uno o más links a otros nodos. Según las restricciones que tengan la cantidad de links, estas pueden ser simplemente enlazadas, dobles o múltiples.

![no-box](../_src/assets/06-Estructuras_Datos_2/singlelist.png)

¿Donde podemos usar una lista enlazada? Por ejemplo, si tenemos que modelar el plan de vuelo de un avión una buena posibilidad sería una lista enlazada de aeropuertos. O en el browser para poder ir hacia atrás y adelante en las páginas web del historial también podríamos usar una lista doblemente enlazada, o también las podes usar para representar un mazo de cartas para jugar blackjack. :smile:

### Lista Enlazada simple en Python

Hagamos nuestra primera lista enlazada.
Como cada nodo puede ser un objeto por sí mismo, vamos a codear dos constructores: el _nodo_ y la _lista_ en si.

El nodo contiene "val" y un puntero o un link al siguiente nodo, por defecto el nodo no va a apuntar a ningún otro nodo.

```python
>>> class Node:
>>>     def __init__(self, val):
>>>         self.data = val
>>>         self.next = None
>>> 
>>>     def getData(self):
>>>         return self.data
>>> 
>>>     def getNext(self):
>>>         return self.next
>>> 
>>>     def setData(self, val):
>>>         self.data = val
>>> 
>>>     def setNext(self, val):
>>>         self.next = val
```

La clase lista, necesita sólamente un puntero o link que apunte al primer nodo de la lista. Adicionalmente vamos a agregar la propiedad length, para poder saber siempre la longitud de nuestra lista enlazada. Al crear una lista va a estar vacía por o tanto la cabeza es `null` y _length_ es cero.

```python
>>> class LinkedList:
>>>     def __init__(self):
>>>         self.head = None
>>> 
>>>     def isEmpty(self):
>>>         """Check if the list is empty"""
>>>         return self.head is None
>>> 
>>>     def add(self, item):
>>>         """Add the item to the list"""
>>>         new_node = Node(item)
>>>         new_node.setNext(self.head)
>>>         self.head = new_node
>>> 
>>>     def size(self):
>>>         """Return the length/size of the list"""
>>>         count = 0
>>>         current = self.head
>>>         while current is not None:
>>>             count += 1
>>>             current = current.getNext()
>>>         return count
>>> 
>>>     def search(self, item):
>>>         """Search for item in list. If found, return True. If not found, return False"""
>>>         current = self.head
>>>         found = False
>>>         while current is not None and not found:
>>>             if current.getData() is item:
>>>                 found = True
>>>             else:
>>>                 current = current.getNext()
>>>         return found
>>> 
>>>     def remove(self, item):
>>>         """Remove item from list. If item is not found in list, raise ValueError"""
>>>         current = self.head
>>>         previous = None
>>>         found = False
>>>         while current is not None and not found:
>>>             if current.getData() is item:
>>>                 found = True
>>>             else:
>>>                 previous = current
>>>                 current = current.getNext()
>>>         if found:
>>>             if previous is None:
>>>                 self.head = current.getNext()
>>>             else:
>>>                 previous.setNext(current.getNext())
>>>         else:
>>>             raise ValueError
>>>             print 'Value not found.'
>>> 
>>>     def insert(self, position, item):
>>>         """
>>>         Insert item at position specified. If position specified is
>>>         out of bounds, raise IndexError
>>>         """
>>>         if position > self.size() - 1:
>>>             raise IndexError
>>>             print "Index out of bounds."
>>>         current = self.head
>>>         previous = None
>>>         pos = 0
>>>         if position is 0:
>>>             self.add(item)
>>>         else:
>>>             new_node = Node(item)
>>>             while pos < position:
>>>                 pos += 1
>>>                 previous = current
>>>                 current = current.getNext()
>>>             previous.setNext(new_node)
>>>             new_node.setNext(current)
>>> 
>>>     def index(self, item):
>>>         """
>>>         Return the index where item is found.
>>>         If item is not found, return None.
>>>         """
>>>         current = self.head
>>>         pos = 0
>>>         found = False
>>>         while current is not None and not found:
>>>             if current.getData() is item:
>>>                 found = True
>>>             else:
>>>                 current = current.getNext()
>>>                 pos += 1
>>>         if found:
>>>             pass
>>>         else:
>>>             pos = None
>>>         return pos
>>> 
>>>     def pop(self, position = None):
>>>         """
>>>         If no argument is provided, return and remove the item at the head. 
>>>         If position is provided, return and remove the item at that position.
>>>         If index is out of bounds, raise IndexError
>>>         """
>>>         if position > self.size():
>>>             print 'Index out of bounds'
>>>             raise IndexError
>>>             
>>>         current = self.head
>>>         if position is None:
>>>             ret = current.getData()
>>>             self.head = current.getNext()
>>>         else:
>>>             pos = 0
>>>             previous = None
>>>             while pos < position:
>>>                 previous = current
>>>                 current = current.getNext()
>>>                 pos += 1
>>>                 ret = current.getData()
>>>             previous.setNext(current.getNext())
>>>         print ret
>>>         return ret
>>> 
>>>     def append(self, item):
>>>         """Append item to the end of the list"""
>>>         current = self.head
>>>         previous = None
>>>         pos = 0
>>>         length = self.size()
>>>         while pos < length:
>>>             previous = current
>>>             current = current.getNext()
>>>             pos += 1
>>>         new_node = Node(item)
>>>         if previous is None:
>>>             new_node.setNext(current)
>>>             self.head = new_node
>>>         else:
>>>             previous.setNext(new_node)
>>> 
>>>     def printList(self):
>>>         """Print the list"""
>>>         current = self.head
>>>         while current is not None:
>>>             print current.getData()
>>>             current = current.getNext()
>>> 
```

### Operaciones en una lista

Veamos que operaciones podemos hacer en una lista:

* _Iterar sobre la lista_: Recorrer la lista viendo sus elementos o hasta que encontremos el elemento deseado.
* _Insertar un nodo_: La operación va a cambiar según el lugar donde querramos insertar el nodo nuevo:
  * Al principio de la lista.
  * En el medio de la lista.
  * Al final de la lista.

![InsertarTop](../_src/assets/06-Estructuras_Datos_2/listAdd.gif)

_El orden en el que actualizan los punteros es muy importante. Si actualizan el la cabeza de la lista primero, pierden la lista!!_

* _Sacar un nodo_:
  * Del principio de la lista.
  * Del medio de la lista.

![ScarNodo](../_src/assets/06-Estructuras_Datos_2/listaRemove.gif)

![Remove](../_src/assets/06-Estructuras_Datos_2/listaRemove.png)

_Para sacar un item, directamente hacemos que no se pueda alcanzar desde el comienzo de la lista_

Escribamos algo para poder ver la lista que hemos creado y sus nodos:

```python
>>> lis = LinkedList()
>>> lis.isEmpty()
True
>>> lis.add('rojo')
>>> lis.size()
1
>>> lis.add('azul')
>>> lis.add('blanco')
>>> lis.add('verde')
>>> lis.search('rojo')
True
>>> lis.search('amarillo')
False
>>> lis.remove('rojo')
>>> lis.search('rojo')
False
>>> lis.printList()
verde
blanco
azul
>>> lis.insert(2,'rojo')
>>> lis.printList()
verde
blanco
rojo
azul
>>> lis.index('blanco')
1
>>> lis.pop()
verde
>>> lis.printList()
blanco
rojo
azul
>>> lis.append('verde')
>>> lis.printList()
blanco
rojo
azul
verde
>>> lis.add('negro')
>>> lis.printList()
negro
blanco
rojo
azul
verde
```

### Listas Doblemente Enlazadas

En la lista que vimos antes, sólo podemos recorrer la lista en un solo sentido. En algunos casos nos puede servir recorrer la lista en los dos sentidos, para tales casos lo que vamos a usar es una lista doblemente enlazada.
Como se puede imaginar, una lista doblemente enlazada es aquella que cada nodo tiene dos links, uno para el nodo siguiente, y otro para el nodo anterior.

![no-box](../_src/assets/06-Estructuras_Datos_2/doueblelist.png)

Ahora es fácil ir y venir entre los items. Ahora las operaciones tienen un paso más, que es hacer que los nuevos links apunten al nodo correcto.

## Tablas Hash (Hash tables)

Esta estructura que guarda los datos de una manera asociativa, o sea con un par clave-valor o key-value. Los datos son guardados como en un arreglo, pero los índices tienen que ver con lo qué está guardado adentro. Esto hace que sean muy rápidas para buscar datos.

![no-box](../_src/assets/06-Estructuras_Datos_2/hashfunction.png)

De hecho, la función que transforman un elemento en una cadena de longitud finita (a esto se lo conoce como _hash_) se llama función _hash_. El término hash proviene, aparentemente, de la analogía con el significado estándar (en inglés) de dicha palabra en el mundo real: picar y mezclar. Donald Knuth cree que H. P. Luhn, empleado de IBM, fue el primero en utilizar el concepto en un memorándum fechado en enero de 1953. Su utilización masiva no fue hasta después de 10 años.

Como las funciones hash nos devuelven un número finito de posibilidades, vamos a tener que reservar la misma cantidad de memoria para poder guardar cualquier cosa que, al ser hasheada, 'caiga' en esa key. Por lo tanto, las tablas hash van a ocupar más espacio, con el objetivo de ganar velocidad. De nuevo, según la naturaleza del problema te a convenir o no usarlas.

Para construir una hash table vamos a necesitar:

* _Una estrucura de datos_:  Acá vamos a guardar los datos y buscarlos por el índice. Puede ser un arreglo, o un árbol, etc..
* _Una función hasheadora_: Vamos a necesitar una función que nos transforme lo que elegimos de key a un hash que será nuestro índice.
* _Una política de resolución de colisiones_: Es la política que definiremos para decidir qué pasa cuando dos keys distintas generar dos hash iguales (las funciones no son perfectas !).

## Homework

Completa la tarea descrita en el archivo [Notebook](https://github.com/soyHenry/DS-M1/blob/a948bc4b078f6ba12a0b484ad0d99ce8e0c364ef/Clase%2006/Homework_06.ipynb)

<table class="hide" width="100%" style='table-layout:fixed;'>
  <tr>
    <td>
      <a href="https://airtable.com/shrCubCO1XC2BwYIT?prefill_clase=6-EstructuradedatosII">
        <img src="https://static.thenounproject.com/png/204643-200.png" width="100"/>
        <br>
        Hacé click acá para dejar tu feedback sobre esta clase.
      </a>
    </td>
  </tr>
</table>
