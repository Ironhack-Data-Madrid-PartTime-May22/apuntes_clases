import streamlit as st


from PIL import Image

image = Image.open('images/header.jpeg')
st.image(image, use_column_width=True)

row0_spacer1, row0_1, row0_spacer2, row0_2, row0_spacer3 = st.columns((.1, 2.3, .1, 1.3, .1))
with row0_1:
    st.title(" Análisis de reservas horteleras")

with row0_2:
    st.text('')
    st.subheader('Stramlit App by [GarciaYamada]((https://http.cat/status/204))')


st.markdown("Este es un ejemplo de como podemos crear una interfaz web para nuestro proyecto de análisis de datos. En este caso, se trata de un análisis de reservas hoteleras. Para ello, hemos utilizado la librería [Streamlit](https://streamlit.io/), que nos permite crear una interfaz web de manera muy sencilla. Para más información, puedes consultar la [documentación](https://docs.streamlit.io/en/stable/).")




with st.expander("Haz clic para expandir"):
    st.write("Contenido oculto")


opcion = st.sidebar.selectbox(
    'Selecciona una opción',
    ('Opción 1', 'Opción 2', 'Opción 3'))
st.write('Seleccionaste:', opcion)



col1, col2 = st.columns(2)
with col1:
    st.line_chart([0, 1, 2, 3, 4])
with col2:
    st.line_chart([4, 3, 2, 1, 0])

col1, col2, col3 = st.columns(3)
col1.metric("Temperature", "70 °F", "1.2 °F")
col2.metric("Wind", "9 mph", "-8%")
col3.metric("Humidity", "86%", "4%")

