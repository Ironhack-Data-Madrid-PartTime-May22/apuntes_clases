import plotly.express as px


def visualizar_relaciones_numericas(df,col1,col2):
    fig = px.scatter(df, x=col1, y=col2)
    return fig


def visualizar_categorica_o_numerica(df, col1):
    fig = px.histogram(df, x=col1)
    return fig



def visualizar_numerica_con_categorica(df, col1, col_hue):
    fig = px.histogram(df, x=col1, color=col_hue)
    return fig

def visualizar_boxplot(df, col1):
    fig = px.box(df, x=col1)
    return fig