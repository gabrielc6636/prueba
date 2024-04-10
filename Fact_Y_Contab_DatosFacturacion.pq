let
  Origen = PowerBI.Dataflows([]),
  #"Navegación 1" = Origen{[workspaceId = "098cd3d2-f267-4ff5-8658-31b196d74dea"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[dataflowId = "96aaa540-972d-4fb1-b094-140a33519bf5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[entity = "DatosFacturacion"]}[Data]
in
  #"Navegación 3"
