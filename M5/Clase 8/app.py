import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# Definimos las columnas que nos interesan
fields = ['country', 'points','price', 'variety']

# Cargamos el DataFrame solo con esas columnas
df = pd.read_csv('wine_reviews.csv', usecols = fields)
df.dropna(inplace=True)

def main_page():
	# Título y subtítulo.
	#st.title('Introducción a Streamlit')
	st.markdown('# Introducción a Streamlit') 
	st.subheader("DS03 - M5 - Clase 8")
	st.markdown('***')
	st.sidebar.markdown('''
	* Introducción a Streamlit 
	* Streamlit vs Dash
	* Ventajas''')

	st.markdown('''
	### ¿Qué es y para qué sirve Streamlit?
	Streamlit es una librería que permite crear `aplicaciones web` para Data Science y Machine Learning de forma rápida y sin necesidad de saber otro lenguaje de programación, debido a que son `desarrolladas en Python`. 
	
	Es compatible con las librerías más usadas en esta área, como Numpy, Pandas, Matplotlib, Seaborn, Scikit-Learn, Keras, PyTorch, etc. 
	
	### ¿Por qué Streamlit?

	Para poder tener un `dashboard en Python` necesitamos unir la manipulación de datos, con la visualización e incorporar interacción con el usuario. 
	
	Para poder hacer esta unión sin tener que utilizar código específico para la creación de aplicaciones web, existen las `librerías Streamlit y Dash`. Ambas brindan un servicio para construir aplicaciones webs a través de datos trabajados en Python pero Streamlit, `a diferencia de Dash`, no requiere experiencia en temas front-end (como css, html u otro lenguaje) ni necesita grandes servidores de almacenamiento. 

	Por esto, se recomienda utilizar Streamlit en proyectos que se necesite crear dashboards de forma `rápida, sencilla y sólo con lenguaje Python`. 
	''')

	st.markdown('***')

def pageII():
	#Título.
	st.title('Visualizaciones')
	st.markdown('***')
	#Subtítulo.
	st.subheader('Exploración inicial del dataset de reseñas de vinos')

	#Uso de Checkboxs: Muestra información cuando se selecciona la caja.
	if st.checkbox('Mostrar DF'): #Nombre al lado de la caja.
		st.dataframe(df) #Qué hace cuando se selecciona la caja.

	if st.checkbox('Vista de datos'):#, disabled=True
		#Botones: Muestra información cuando se selecciona el botón.
		if st.button("Mostrar head"): #Nombre del botón.
			st.write(df.head()) #Qué hace cuando se selecciona el botón.
		if st.button("Mostrar tail"):
			st.write(df.tail())

	st.subheader("Información de las dimensiones")
	#Radios: 
	df_dim = st.radio('Dimensión a mostrar:', ('Filas', 'Columnas', 'Ambas'), horizontal=True)

	if df_dim == 'Filas':
		st.write('Cantidad de filas:', df.shape[0])

	elif df_dim == 'Columnas':
		st.write('Cantidad de columnas:', df.shape[1])
		st.write('Columnas: ',df.columns)
	else:
		st.write('Cantidad de filas:', df.shape[0])
		st.write('Cantidad de columnas:', df.shape[1])

	st.title('Visualizaciones')

	if st.checkbox('Gráfico de dispersión entre Precio y Puntaje', True):
		ancho = st.sidebar.slider('Ancho del gráfico', 1,10,6)
		alto = st.sidebar.slider('Alto del gráfico', 1,10,4)
		fig = plt.figure(figsize=(ancho,alto))
		sns.scatterplot(x="price", y="points", data=df[df['price']<1500])
		st.pyplot(fig)
	
	if st.checkbox('Gráfico de dispersión entre Precio y Puntaje, según país seleccionado', True):
		countries_list = df['country'].unique().tolist()
		countries = st.multiselect('Seleccione un país:', countries_list, default=['Argentina', 'Chile', 'Spain'])
		df_countries = df[df['country'].isin(countries)]
		fig = plt.figure(figsize=(6,3))
		sns.scatterplot(x='price', y='points', hue='country', data=df_countries, alpha=0.3)
		st.pyplot(fig)

	x = np.arange(2010, 2022, 1)
	y1 = np.random.randint(10, size=12)
	y2 = np.random.randint(10, size=12)
	columnas = st.checkbox('Mostrar gráficos de dispersión en dos columnas', True)
	if columnas:
		col1, col2 = st.columns(2)
		with col1:
			fig, ax = plt.subplots()
			ax.plot(x, y1, marker = 'o', color = 'r', linestyle = '-.')
			ax.set(xlabel='Años', ylabel='Cantidad ventas', title='Comportamiento anual de producto A, entre 2010 y 2021')
			st.pyplot(fig)
		with col2:
			fig, ax = plt.subplots()
			ax.plot(x, y2, marker = 'x', color = 'g', linestyle = ':')
			ax.set(xlabel='Años', ylabel='Cantidad ventas', title='Comportamiento anual de producto B, entre 2010 y 2021')
			st.pyplot(fig)
	else:
		fig, ax = plt.subplots(figsize=(6,3))
		ax.plot(x, y1, marker = 'o', color = 'r', linestyle = '-.')
		ax.set(xlabel='Años', ylabel='Cantidad ventas', title='Comportamiento anual de producto A, entre 2010 y 2021')
		st.pyplot(fig)

		fig, ax = plt.subplots(figsize=(6,3))
		ax.plot(x, y2, marker = 'x', color = 'g', linestyle = ':')
		ax.set(xlabel='Años', ylabel='Cantidad ventas', title='Comportamiento anual de producto B, entre 2010 y 2021')
		st.pyplot(fig)

	st.markdown('***')


page_names_to_funcs = {
    'I. Introducción': main_page,
    'II. Visualizaciones': pageII}
	
selected_page = st.sidebar.selectbox("Seleccione página", page_names_to_funcs.keys())
page_names_to_funcs[selected_page]()



st.write('## Material complementario')
st.markdown('''	* [Uso de Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
* [Documentación oficial Streamlit](https://docs.streamlit.io/)
* [Blog oficial Streamlit](https://blog.streamlit.io/)''')

