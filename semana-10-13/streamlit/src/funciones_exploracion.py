import streamlit as st
import pandas as pd


def caracteristicas_generales_df(df):    
    st.markdown(" Principales caracteristyicas numericas")
    st.table(df.describe().T)
    st.markdown(" Principales caracteristyicas categoricas")
    st.table(df.describe(include= "object").T)

def exploracion_nulos(df):

    df_nulos = pd.DataFrame(df.isnull().sum() / df.shape[0] * 100, columns=["% valores nulos"]).reset_index().rename(columns={"index": "columna"})
    df_nulos = df_nulos[df_nulos["% valores nulos"] > 0].sort_values("% valores nulos", ascending=False)
    return df_nulos

def eliminar_columnas(df):
    todas_columnas = df.columns.to_list()
    eliminar = st.multiselect("selecciona columnas a eliminar", todas_columnas)
    df.drop(columns= eliminar  , axis=1, inplace=True)
    return df