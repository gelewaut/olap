import pandas as pd

filename = "utiles_caba/delitos/delitos_2023.csv"


# Example CSV files
file_paths = ["utiles_caba/delitos/delitos_2022.csv",
              "utiles_caba/delitos/delitos_2021.csv",
              "utiles_caba/delitos/delitos_2020.csv",
              "utiles_caba/delitos/delitos_2019.csv",
              "utiles_caba/delitos/delitos_2018.csv",
              "utiles_caba/delitos/delitos_2017.csv",
              "utiles_caba/delitos/delitos_2016.csv"]

# Read each CSV file into a DataFrame
dfs = [pd.read_csv(file, on_bad_lines='skip') for file in file_paths]
dfs.insert(0, pd.read_csv(filename, on_bad_lines='skip', delimiter=";"))

# Concatenate all DataFrames vertically
df_delitos = pd.concat(dfs, ignore_index=True)

output_tipos = "utiles_caba/tables/tipos.csv"
output_subtipos = "utiles_caba/tables/subtipos.csv"
output_detalle = "utiles_caba/tables/detalle.csv"
output_fecha = "utiles_caba/tables/fechas.csv"

subtipo_counts = df_delitos[['subtipo', 'barrio', 'mes', 'anio']].value_counts().reset_index()
subtipo_counts.columns = [['subtipo',  'barrio', 'mes', 'anio', 'count']]
subtipo_counts.to_csv(output_detalle, index=False)

df_unique_tipo = df_delitos.drop_duplicates(subset=['tipo'])
df_unique_tipo['tipo'].to_csv(output_tipos, index=False)

df_unique_subtipo = df_delitos.drop_duplicates(subset=['subtipo'])
df_unique_subtipo[['subtipo', 'tipo']].to_csv(output_subtipos, index=False)

df_unique_subtipo = df_delitos.drop_duplicates(subset=['mes', 'anio'])
df_unique_subtipo[['mes', 'anio']].to_csv(output_fecha, index=False)

