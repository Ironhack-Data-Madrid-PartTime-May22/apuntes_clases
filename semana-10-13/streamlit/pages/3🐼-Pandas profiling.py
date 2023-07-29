import pandas as pd
import streamlit as st
import pandas_profiling as pp

from streamlit_pandas_profiling import st_profile_report

df = pd.read_csv("data/df_limpios.csv")
pr = df.profile_report()

st_profile_report(pr)

