from itertools import count
from tkinter import ANCHOR
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



st.title('Visualizaciones')
st.subheader('Clase 9 - M5')
st.write('***')

st.title('Exploración de las reseñas de vinos')

if st.checkbox('Mostrar DF'):
    st.dataframe(df)

if st.checkbox('Vista de datos'):
    if st.button('Mostrar head'):
        st.write(df.head())
    if st.button("Mostrar tail"):
        st.write(df.tail())

st.subheader("Información de las dimensiones")
df_dim = st.radio('Dimensión a mostrar:', ('Filas', 'Columnas', 'Ambas'), horizontal=True)
if df_dim == 'Filas':
    st.write('Cantidad de filas: ', df.shape[0])
if df_dim == 'Columnas':
    st.write('Cantidad de columnas: ', df.shape[1])
if df_dim == 'Ambas':
    st.write('Cantidad de filas y columnas: ', df.shape)

precio_max = st.sidebar.slider('Precio max', 0,5000,1500)

if st.checkbox('Gráfico de dispersión entre Precio y Puntaje', True):
    ancho = st.sidebar.slider('Ancho de la figura', 1,10,6)
    alto  = st.sidebar.slider('Alto de la figura', 1,10,4)  
    fig = plt.figure(figsize=(ancho,alto))
    sns.scatterplot(x="price", y="points", data=df[df['price']<precio_max])
    st.pyplot(fig)

countries_list = df['country'].unique().tolist()
countries = st.multiselect('Seleccione un país',countries_list,default=['Argentina', 'Chile', 'Spain'])
df_countries = df[df['country'].isin(countries)]
fig = plt.figure(figsize=(6,4))
sns.scatterplot(x="price", y="points", hue='country', data=df_countries[df_countries['price']<precio_max])
st.pyplot(fig)

x = np.arange(2010, 2022, 1)
y1 = np.random.randint(10, size=12)
y2 = np.random.randint(10, size=12)

column = st.checkbox('¿Quieres mostrar dos columnas?', True)
if column:
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


st.write('## Material complementario')
st.markdown('[Repo de markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)')
