import streamlit as st
import pandas as pd
from src import funciones_exploracion as fe 
# importamos matplotlibexpres
import plotly.express as px
 

st.title("Análisis exploratorio de datos")

fichero = st.file_uploader("carga tus datos")

if fichero is not None:
    df = pd.read_csv(fichero)


    # Big numbers
    col1, col2, col3 = st.columns(3)
    ## Boton para eliminar duplicados
    with col1:
        st.write("¿Desea eliminar duplicados?") 
        if st.button("Eliminar"): 
            df.drop_duplicates(inplace=True) 
            df.reset_index(drop=True, inplace=True)          
            st.write("Duplicados eliminados")    
    ## Big number total duplicados
    col2.metric("Duplicados", df.duplicated().sum())
    ## Big number porcentaje duplicados
    col3.metric("Porcentaje Duplcados", f"{(df.duplicated().sum()/df.shape[0]).round(2)*100} %")


    # Eliminacion de columnas 
    df_limpios = fe.eliminar_columnas(df)
    st.table(df_limpios.head(3))

 
    # Tabla resumen
    st.markdown("### **Características generales de los datos**")
    df_descriptivo = df_limpios.describe().T
    ## redondemaos a dos decimales
    df_descriptivo["count"] = ((1-df_descriptivo["count"]/df_limpios.shape[0])*100).round(2)
    ## ronombramos la columna count por % nulos 
    df_descriptivo.rename(columns={"count": "% nulos"}, inplace=True)
        
    st.table(df_descriptivo.style.background_gradient())


    st.write("¿Desea guardar los datos?")  
    if st.button("Guardar"):            
        df_limpios.to_csv("data/df_limpios.csv", index=False)
        st.write("Archivo guardado")


 

 

 

 

