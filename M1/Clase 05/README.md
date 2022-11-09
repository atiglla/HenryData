![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Estructuras de Datos

Cuando hablamos a estructura de Datos nos referimos a cómo organizamos los datos cuando programamos. Básicamente, este tema trata de encontrar formas particulares de  organizar datos de tal manera que puedan ser utilizados de manera eficiente.

Imaginen que los datos que tenemos que manejar son libros!, y en un principio tenemos muchísimos libros desordenados por casa. Cada vez que queremos leer un libro, tardamos dos horas buscando uno por uno hasta dar con el libro. Eso no es eficiente. Entonces, ¿qué hacemos? Bueno, podemos armar una biblioteca, por ejemplo, y acomodamos los libros en orden alfabético, esto nos ahorra tiempo en buscarlos. Y, ¿qué pasa si tenemos demasiados libros y no entran en una biblioteca? Podemos tener un lugar donde depositamos los libros que menos usamos, y mantenemos una libretita donde especificamos qué libros dejamos ahí y en que depósito están.
En fin, podemos organizarlos de mil maneras, pero se entiende la idea que organizando los datos vamos a ser más eficientes, no?

## Pilas

Las pilas, como sugiere el nombre, siguen el principio "Último en entrar, primero en salir"  (LIFO). Como si apilamos monedas una encima de la otra, la última moneda que ponemos en la parte superior es la que es la primera que se saca de la pila más tarde.
Para implementar una pila, por lo tanto, necesitamos dos operaciones simples:

* push – agrega un elemento a la parte superior de la pila:
* pop – elimina el elemento en la parte superior de la pila:

![](../_src/assets/05-Estructuras_Datos_1/ejemplo_pila.jpg)

### Implementación de una pila en Python

```python
>>> class Estructura_Pila(object):
>>>     def __init__(self):
>>>         self.__list = []
>>> 
>>>     # Agregar un elemento a la Pila
>>>     def push(self, item):
>>>         self.__list.append(item)
>>> 
>>>     # Quitar un elemento de la Pila
>>>     def pop(self):
>>>         return self.__list.pop()
>>> 
>>>     # Obtener el elemento superior de la pila
>>>     def peek(self):
>>>         if self.__list:
>>>             return self.__list[-1]
>>>         else:
>>>             return None
>>> 
>>>     # Determinar si la Pila está vacía
>>>     def is_empty(self):
>>>         return self.__list == []
>>> 
>>>     # Devuelve el número de elementos en la Pila
>>>     def size(self):
>>>         return len(self.__list)
>>> 
>>> if __name__ == '__main__':
>>>     s = Estructura_Pila()
>>>     s.push(1)
>>>     s.push(2)
>>>     s.push(3)
>>>     s.push(4)
>>>     s.push(5)
>>>     print(s.pop()) # Muestra 5
>>>     print(s.pop()) # Muestra 4
>>>     print(s.pop()) # Muestra 3
```

## Colas

Las colas, como sugiere el nombre, siguen las Primero en entrar primero en salir (FIFO) principio. Como si esperara en una cola las entradas del cine, el primero en hacer fila es el primero en comprar una entrada y disfrutar de la película.

Para implementar una cola, por lo tanto, necesitamos dos operaciones simples:

enqueue – agrega un elemento al final de la cola:
dequeue – elimina el elemento al principio de la cola:

![](../_src/assets/05-Estructuras_Datos_1/ejemplo_cola.jpg)

### Implementación de una cola en Python

```python
>>> class Estructura_Cola(object):
>>>     def __init__(self):
>>>         self.__list = []
>>> 
>>>     # Agregar un elemento en la Cola
>>>     def enqueue(self, item):
>>>         self.__list.append(item)
>>> 
>>>     # Quitar un elemento de la Cola
>>>     def dequeue(self):
>>>         return self.__list.pop(0)
>>> 
>>>     # Verificar si la Cola está vacía
>>>     def is_empty(self):
>>>         return self.__list == []
>>> 
>>>     # Devolver cantidad de elementos den la Cola
>>>     def size(self):
>>>         return len(self.__list)
>>> 
>>> if __name__ == '__main__':
>>>     q=Estructura_Cola()
>>>     q.enqueue(1)
>>>     q.enqueue(2)
>>>     q.enqueue(3)
>>>     q.enqueue(4)
>>>     q.enqueue(5)
>>>     print(q.dequeue()) # Muestra 1
>>>     print(q.dequeue()) # Muestra 2
>>>     print(q.dequeue()) # Muestra 3
```

### Ejemplos de implementación:

Imagina que eres un desarrollador que trabaja en un nuevo procesador de textos. Tiene la tarea de crear una función de deshacer, lo que permite a los usuarios retroceder en sus acciones hasta el comienzo de la sesión.
Una pila es ideal para este escenario. Podemos registrar cada acción que realiza el usuario empujándola a la pila. Cuando el usuario quiera deshacer una acción, la sacará de la pila. Podemos simular rápidamente la función de esta manera:

```python
>>> document_actions = Estructura_Pila()
>>> # The first enters the title of the document
>>> document_actions.push('action: enter; text_id: 1; text: This is my favourite document')
>>> # Next they center the text
>>> document_actions.push('action: format; text_id: 1; alignment: center')
>>> # As with most writers, the user is unhappy with the first draft and undoes the center alignment
>>> document_actions.pop()
>>> # The title is better on the left with bold font
>>> document_actions.push('action: format; text_id: 1; style: bold')
```

Las colas también tienen usos generalizados en programación. Piense en juegos como Street Fighter o Super Smash Brothers. Los jugadores de esos juegos pueden realizar movimientos especiales presionando una combinación de botones. Estas combinaciones de botones se pueden almacenar en una cola.
Ahora imagina que eres un desarrollador que trabaja en un nuevo juego de lucha. En su juego, cada vez que se presiona un botón, se activa un evento de entrada. Un evaluador notó que si los botones se presionan demasiado rápido, el juego solo procesa el primero y los movimientos especiales no funcionarán.
Puedes arreglar eso con una cola. Podemos poner en cola todos los eventos de entrada a medida que ingresan. De esta manera, no importa si los eventos de entrada vienen con poco tiempo entre ellos, todos se almacenarán y estarán disponibles para su procesamiento. Cuando procesamos los movimientos, podemos quitarlos de la cola. Se puede realizar un movimiento especial de la siguiente manera:

```python
>>> input_queue = Estructura_Cola()
>>> # The player wants to get the upper hand so pressing the right combination of buttons quickly
>>> input_queue.enqueue('DOWN')
>>> input_queue.enqueue('RIGHT')
>>> input_queue.enqueue('B')
>>> # Now we can process each item in the queue by dequeueing them
>>> key_pressed = input_queue.dequeue() # 'DOWN'
>>> # We'll probably change our player position
>>> key_pressed = input_queue.dequeue() # 'RIGHT'
>>> # We'll change the player's position again and keep track of a potential special move to perform
>>> key_pressed = input_queue.dequeue() # 'B'
>>> # This can do the act, but the game's logic will know to do the special move
```

## Homework

Completa la tarea descrita en el archivo [Notebook](https://github.com/soyHenry/DS-M1/blob/a948bc4b078f6ba12a0b484ad0d99ce8e0c364ef/Clase%2005/Homework_05.ipynb)

<table class="hide" width="100%" style='table-layout:fixed;'>
  <tr>
    <td>
      <a href="https://airtable.com/shrCubCO1XC2BwYIT?prefill_clase=5-EstructuradedatosI">
        <img src="https://static.thenounproject.com/png/204643-200.png" width="100"/>
        <br>
        Hacé click acá para dejar tu feedback sobre esta clase.
      </a>
    </td>
  </tr>
</table>
