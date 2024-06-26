import pandas as pd

# Define the paths to your CSV files
barrio_comuna = "./utiles_caba/barrios/caba_pob_barrios_2010.csv"
barrio_poblacion = "./utiles_caba/barrios/barrios_comunas_p_Ciencia_de_Datos_y_PP.csv"
barrio_info = "./utiles_caba/barrios/barrios.csv"


# Load the CSV files into pandas DataFrames
df_barrio_comuna = pd.read_csv(barrio_comuna)
df_barrio_poblacion = pd.read_csv(barrio_poblacion)
df_barrio_info = pd.read_csv(barrio_info, delimiter=';')

# Merge the DataFrames
df_merged = df_barrio_comuna.merge(df_barrio_poblacion, on='BARRIO')
df_merged = df_merged.merge(df_barrio_info[['BARRIO', 'COMUNA', 'AREA']], on=['BARRIO', 'COMUNA'])


output = "./utiles_caba/tables/barrios_tables.csv"
df_merged.to_csv(output, index=False)
