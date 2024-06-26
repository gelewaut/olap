import pandas as pd

clubes = "utiles_caba/establecimientos/clubes.csv"
comisarias = "utiles_caba/establecimientos/comisarias.csv"
educacion = "utiles_caba/establecimientos/educacion.csv"
hospitales = "utiles_caba/establecimientos/hospitales.csv"

out_clubes = "utiles_caba/tables/clubes.csv"
out_comisarias = "utiles_caba/tables/comisarias.csv"
out_educacion = "utiles_caba/tables/educacion.csv"
out_hospitales = "utiles_caba/tables/hospitales.csv"

df_clubes = pd.read_csv(clubes)
df_clubes[['nombre', 'barrio']].to_csv(out_clubes, index=False)

df_comisarias = pd.read_csv(comisarias)
df_comisarias[['nombre', 'barrio']].to_csv(out_comisarias, index=False)

df_educacion = pd.read_csv(educacion)
df_educacion[['nombre_est', 'barrio']].to_csv(out_educacion, index=False)

df_hospitales = pd.read_csv(hospitales)
# print(df_hospitales['COD_POSTAL'])
# df_hospitales[['nombre', 'barrio']].to_csv(out_hospitales, index=False)
