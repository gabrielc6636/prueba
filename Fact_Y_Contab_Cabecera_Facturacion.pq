let
  Origen = DatosFacturacion,
  #"Columnas quitadas" = Table.RemoveColumns(Origen, {"NR_VAGAO",  "CD_CF", "PESO_REAL", "VRKME", "PESO_CALC", "VL_TARIFA", "VL_VALOR", "FKART", "FAC_TR", "XBLNR"}),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Columnas quitadas", {{"DT_EMI_DESP", type date}}),
  #"Columnas reordenadas 1" = Table.ReorderColumns(#"Tipo de columna cambiado", {"DT_EMI_DESP", "CD_CLI", "NAME1", "NR_FLUXO", "NM_FLUXO", "CD_MERC", "DS_MERC", "CD_EST_ORIG", "NM_ORIG", "CD_EST_DEST", "NM_DEST", "BSTKD", "NR_DESP", "NR_CP", "LINEA", "VKORG"}),
  #"Tipo de columna cambiado 1" = Table.TransformColumnTypes(#"Columnas reordenadas 1", {{"DT_EMI_DESP", type datetime}}),
  #"Columnas reordenadas" = Table.ReorderColumns(#"Tipo de columna cambiado 1", { "LINEA", "VKORG", "CD_CLI", "NAME1", "NR_FLUXO", "NM_FLUXO", "CD_MERC", "DS_MERC", "CD_EST_ORIG", "NM_ORIG", "CD_EST_DEST", "NM_DEST", "BSTKD", "NR_DESP", "NR_CP"}),
  #"Columnas quitadas 1" = Table.RemoveColumns(#"Columnas reordenadas", {"NR_DESP", "LINEA", "VKORG", "CD_CLI", "NAME1", "NM_FLUXO", "CD_MERC", "DS_MERC", "CD_EST_ORIG", "NM_ORIG", "CD_EST_DEST", "NM_DEST"}),
  #"Duplicados quitados" = Table.Distinct(#"Columnas quitadas 1"),
  #"Columna duplicada" = Table.DuplicateColumn(#"Duplicados quitados", "DT_EMI_DESP", "DT_EMI_DESP - Copia"),
  #"Tipo de columna cambiado 2" = Table.TransformColumnTypes(#"Columna duplicada", {{"DT_EMI_DESP - Copia", type text}}),
  #"Columnas con nombre cambiado" = Table.RenameColumns(#"Tipo de columna cambiado 2", {{"DT_EMI_DESP - Copia", "Fecha"}}),
  #"Personalizado agregado" = Table.AddColumn(#"Columnas con nombre cambiado", "Link", each [Fecha] & "-" & [NR_FLUXO] & "-" & [BSTKD] & "-" & [NR_CP]),
  #"Transformar columnas" = Table.TransformColumnTypes(#"Personalizado agregado", {{"Link", type text}}),
  #"Reemplazar errores" = Table.ReplaceErrorValues(#"Transformar columnas", {{"Link", null}})
in
  #"Reemplazar errores"
