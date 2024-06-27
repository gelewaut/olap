import pandas as pd

out_ingreso = "./utiles_caba/tables/ingreso.csv"
barrios = "./utiles_caba/tables/barrios_tables.csv"

ingreso_2019 = "./utiles_caba/ingreso/encuesta-anual-hogares-2019.csv"
ingreso_2018 = "./utiles_caba/ingreso/encuesta-anual-hogares-2018.csv"
ingreso_2017 = "./utiles_caba/ingreso/encuesta-anual-hogares-2017.csv"
ingreso_2016 = "./utiles_caba/ingreso/encuesta-anual-hogares-2016.csv"


df_2019 = pd.read_csv(ingreso_2019, on_bad_lines='skip', encoding='iso-8859-2')
df_2018 = pd.read_csv(ingreso_2018, on_bad_lines='skip', encoding='iso-8859-2')
df_2017 = pd.read_csv(ingreso_2017, on_bad_lines='skip', encoding='iso-8859-2')
df_2016 = pd.read_csv(ingreso_2016, on_bad_lines='skip', encoding='iso-8859-2')

# print(df.info())

df_2019['anio'] = 2019
df_2018['anio'] = 2018
df_2017['anio'] = 2017
df_2016['anio'] = 2016

dfs = [df_2019, df_2018, df_2017, df_2016]

df = pd.concat(dfs, ignore_index=True)

barrio_comuna_df = pd.read_csv(barrios)
barrio_comuna_df.columns = barrio_comuna_df.columns.str.lower()
merged_df = df.merge(barrio_comuna_df, on='comuna', how='left')
merged_df = merged_df.drop('comuna', axis=1)


# print(merged_df)
# df = df.drop_duplicates(['ingresos_totales'])[['comuna', 'ingresos_totales', 'anio']]
df = merged_df[['barrio', 'ingresos_totales', 'anio']]



df.to_csv(out_ingreso, index=False)
# print(df)