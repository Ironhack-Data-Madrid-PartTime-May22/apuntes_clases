import streamlit as st 
import pandas as pd 
import numpy as np
from src import funciones_visualizacion as fv

st.markdown("## **Visualización de conjunto de datos**")


#if st.button("cargar datos"):
df = pd.read_csv("data/df_limpios.csv")
st.table(df.sample(3))


st.markdown("### Visualización")

opciones = st.selectbox("Qué tipo de variables quierers visualizar",["Elige una opcion"]+["Numerica Vs Numerica","Categoricas","Numericas","Numerica Vs Categorica"])

if opciones == "Numerica Vs Numerica":
    columna1 = st.selectbox("Elige la primera columna", ["Elige una opcion"]+ df.select_dtypes(include=np.number).columns.to_list())
    columna2 = st.selectbox("Elige la segunda columna", ["Elige una opcion"]+ df.select_dtypes(include=np.number).columns.to_list())
    if columna1 == "Elige una opcion" or columna2 == "Elige una opcion":
        st.write("Necesito una opcion primo")
    else:
        st.plotly_chart(fv.visualizar_relaciones_numericas(df, columna1, columna2))

elif opciones == "Categoricas":
    col_categoricas = st.selectbox("Elige la columna categorica", ["Elige una opcion"] + df.select_dtypes(include="O").columns.to_list() )

    if col_categoricas == "Elige una opcion":
        st.write("Necesito una opcion primo")
    else:
        st.plotly_chart(fv.visualizar_categorica_o_numerica(df, col_categoricas))
    
elif opciones == "Numericas":
    col_numericas = st.selectbox("Elige la columna Numerica", ["Elige una opcion"] + df.select_dtypes(include=np.number).columns.to_list() )

    if col_numericas == "Elige una opcion":
        st.write("Necesito una opcion primo")
    else:
        st.plotly_chart(fv.visualizar_categorica_o_numerica(df, col_numericas))


elif opciones == "Numerica Vs Categorica":
    col_num = st.selectbox("Elige una columna numerica",["Elige una opcion"] + df.select_dtypes(include=np.number).columns.to_list() )
    col_cat_hue = st.selectbox("Elige una columna categorica",["Elige una opcion"] + df.select_dtypes(include="O").columns.to_list() )
    
    if col_num == "Elige una opcion" or col_cat_hue == "Elige una opcion":
        st.write("Necesito una opcion primo")
    else:
        st.plotly_chart(fv.visualizar_numerica_con_categorica(df, col_num, col_cat_hue))


st.markdown("### Visualización de estadisticas")

col_num_box = st.selectbox("Elige una columna numerica nueva",["Elige una opcion"] + df.select_dtypes(include=np.number).columns.to_list() )

if col_num_box == "Elige una opcion":
    st.write("Necesito una opcion primo")
else:
    st.plotly_chart(fv.visualizar_boxplot(df, col_num_box))