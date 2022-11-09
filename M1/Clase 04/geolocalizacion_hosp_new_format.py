#Tarea adicional, brindar el archivo hospitales2.csv, y los alumnos deben generar un archivo de salida con las columnas: latitude,longitude,name,label en ese orden y con esos nombres, para que ese CSV sea utilizado como ejemplo de visualización en: https://www.gpsvisualizer.com
#En name va la dirección del hospital, y en label el nombre del hospital.
#Los alumnos lo hacen con Pandas, y en el code review se introduce el módulo CSV para resolverlo, así como también la versión en Pandas.

import csv
tabla = csv.reader( open('hospitales2.csv', encoding = 'utf-8'))
with open('salida.csv', 'w', encoding='utf-8', newline='') as salida:
    salida_writer = csv.writer(salida)
    next(tabla)
    salida_writer.writerow(['latitude','longitude','name','label'])
    for linea in tabla:
        coordenadas = linea[0][7:-1].split()
        salida_writer.writerow([coordenadas[1], coordenadas[0], linea[3], linea[8]])


