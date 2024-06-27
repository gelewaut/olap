import pandas as pd
import re

obras = "./utiles_caba/obras/observatorio-de-obras-urbanas.csv"
barrios = "./utiles_caba/tables/barrios_tables.csv"
out_obras = "./utiles_caba/tables/obras.csv"

df = pd.read_csv(obras, on_bad_lines='skip', encoding='iso-8859-2', delimiter=';')
df_barrios = pd.read_csv(barrios)
# print(df.info())


def split_and_uppercase(barrio):
    barrios = re.split(r', | / |/| y ', barrio)
    return [b.strip().upper() for b in barrios]

df['barrio'] = df['barrio'].apply(split_and_uppercase)

df = df.explode('barrio')

unique_barrios = df_barrios['BARRIO'].str.upper().unique()
df['barrio'] = df['barrio'].str.upper()
df = df[df['barrio'].isin(unique_barrios)]

etapa_values = [
    'Finalizada', 'Finalizado', 'Finalizada/desestimada', 
    'finalizada', 'FInalizada', 'Proyecto finalizado'
]

df = df[df['etapa'].isin(etapa_values)]

tipo_values = [
    'Hidráulica E Infraestructura', 'Hidráulica e Infraestructura', 'Hidráulica e Infraestructura/ Espacio Público', 
    'Infraestructura'
]

df = df[df['tipo'].isin(tipo_values)]


df = df[['nombre', 'tipo', 'barrio', 'fecha_fin_inicial']]
df.to_csv(out_obras, index=False)
