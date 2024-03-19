
view: prueba_tarjeta {
  derived_table: {
    sql: select *
                from ligocloudplatform.lake.rw_tb_datos_tarjetas 
                where numero_documento in ('47510150') ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: numero_tarjeta {
    type: string
    sql: ${TABLE}.Numero_Tarjeta ;;
  }

  dimension: estado_tarjeta {
    type: string
    sql: ${TABLE}.Estado_Tarjeta ;;
  }

  dimension: apellido_paterno {
    type: string
    sql: ${TABLE}.Apellido_Paterno ;;
  }

  dimension: apellido_materno {
    type: string
    sql: ${TABLE}.Apellido_Materno ;;
  }

  dimension: nombres {
    type: string
    sql: ${TABLE}.Nombres ;;
  }

  dimension: categoria_tarjeta {
    type: string
    sql: ${TABLE}.Categoria_Tarjeta ;;
  }

  dimension: nombre_corto_titular {
    type: string
    sql: ${TABLE}.Nombre_Corto_Titular ;;
  }

  dimension: nombre_corto_tarjeta {
    type: string
    sql: ${TABLE}.Nombre_Corto_Tarjeta ;;
  }

  dimension: id_tarjetahabientes {
    type: number
    sql: ${TABLE}.Id_Tarjetahabientes ;;
  }

  dimension: ruc {
    type: string
    sql: ${TABLE}.RUC ;;
  }

  dimension: tipo_registro {
    type: string
    sql: ${TABLE}.Tipo_Registro ;;
  }

  dimension: tipo_mensaje1 {
    type: string
    sql: ${TABLE}.Tipo_Mensaje1 ;;
  }

  dimension: fecha_transmision {
    type: string
    sql: ${TABLE}.Fecha_Transmision ;;
  }

  dimension: hora_transmision {
    type: string
    sql: ${TABLE}.Hora_Transmision ;;
  }

  dimension: numero_clave {
    type: number
    sql: ${TABLE}.Numero_Clave ;;
  }

  dimension: codigo_adquiriente {
    type: string
    sql: ${TABLE}.Codigo_Adquiriente ;;
  }

  dimension: codigo_emisor {
    type: string
    sql: ${TABLE}.Codigo_Emisor ;;
  }

  dimension: codigo_respuesta {
    type: string
    sql: ${TABLE}.Codigo_Respuesta ;;
  }

  dimension: tipo_mensaje2 {
    type: string
    sql: ${TABLE}.Tipo_Mensaje2 ;;
  }

  dimension: fecha_afiliacion {
    type: string
    sql: ${TABLE}.Fecha_Afiliacion ;;
  }

  dimension: titulo {
    type: string
    sql: ${TABLE}.Titulo ;;
  }

  dimension: direccion_remision1 {
    type: string
    sql: ${TABLE}.Direccion_Remision1 ;;
  }

  dimension: direccion_remision2 {
    type: string
    sql: ${TABLE}.Direccion_Remision2 ;;
  }

  dimension: ciudad_remision {
    type: string
    sql: ${TABLE}.Ciudad_Remision ;;
  }

  dimension: departamento_remision {
    type: string
    sql: ${TABLE}.Departamento_Remision ;;
  }

  dimension: codigo_postal {
    type: string
    sql: ${TABLE}.Codigo_Postal ;;
  }

  dimension: telefono_particular {
    type: string
    sql: ${TABLE}.Telefono_Particular ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.Sexo ;;
  }

  dimension: fecha_nacimiento {
    type: string
    sql: ${TABLE}.Fecha_Nacimiento ;;
  }

  dimension: estado_civil {
    type: string
    sql: ${TABLE}.Estado_Civil ;;
  }

  dimension: codigo_plaza_afiliacion {
    type: string
    sql: ${TABLE}.Codigo_Plaza_Afiliacion ;;
  }

  dimension: tipo_documento {
    type: string
    sql: ${TABLE}.Tipo_Documento ;;
  }

  dimension: numero_documento {
    type: string
    sql: ${TABLE}.Numero_Documento ;;
  }

  dimension: status_tarjeta {
    type: string
    sql: ${TABLE}.Status_Tarjeta ;;
  }

  dimension: contador_malos_intentos {
    type: string
    sql: ${TABLE}.Contador_Malos_Intentos ;;
  }

  dimension: fecha_ejecucion {
    type: string
    sql: ${TABLE}.Fecha_Ejecucion ;;
  }

  dimension: fecha_expiracion {
    type: string
    sql: ${TABLE}.Fecha_Expiracion ;;
  }

  dimension: visitas {
    type: number
    sql: ${TABLE}.Visitas ;;
  }

  dimension: fecha_ingreso {
    type: string
    sql: ${TABLE}.Fecha_Ingreso ;;
  }

  dimension: hora_ingreso {
    type: string
    sql: ${TABLE}.Hora_Ingreso ;;
  }

  dimension: fecha_actualizacion {
    type: string
    sql: ${TABLE}.Fecha_Actualizacion ;;
  }

  dimension: hora_actualizacion {
    type: string
    sql: ${TABLE}.Hora_Actualizacion ;;
  }

  dimension: fecha_actividad_financ {
    type: string
    sql: ${TABLE}.Fecha_Actividad_Financ ;;
  }

  dimension: hora_actividad_financ {
    type: string
    sql: ${TABLE}.Hora_Actividad_Financ ;;
  }

  dimension: indicador_distribucion {
    type: string
    sql: ${TABLE}.Indicador_Distribucion ;;
  }

  dimension: ult_act_saldo {
    type: string
    sql: ${TABLE}.ult_act_saldo ;;
  }

  dimension: bloqueo {
    type: string
    sql: ${TABLE}.Bloqueo ;;
  }

  dimension: saldo {
    type: number
    sql: ${TABLE}.Saldo ;;
  }

  dimension: saldo_antier {
    type: number
    sql: ${TABLE}.Saldo_Antier ;;
  }

  dimension: credito {
    type: number
    sql: ${TABLE}.Credito ;;
  }

  dimension: saldo_credito {
    type: number
    sql: ${TABLE}.SaldoCredito ;;
  }

  dimension: saldo_uba {
    type: number
    sql: ${TABLE}.SaldoUBA ;;
  }

  dimension: saldo_cc {
    type: number
    sql: ${TABLE}.SaldoCC ;;
  }

  dimension: saldo_inicial {
    type: number
    sql: ${TABLE}.SaldoInicial ;;
  }

  dimension: total_cargo {
    type: number
    sql: ${TABLE}.TotalCargo ;;
  }

  dimension: total_abono {
    type: number
    sql: ${TABLE}.TotalAbono ;;
  }

  dimension: total_comision {
    type: number
    sql: ${TABLE}.TotalComision ;;
  }

  dimension: reposicion {
    type: string
    sql: ${TABLE}.Reposicion ;;
  }

  dimension: fecha_ultima_txn {
    type: string
    sql: ${TABLE}.Fecha_Ultima_Txn ;;
  }

  dimension: fecha_ultima_recarga {
    type: string
    sql: ${TABLE}.Fecha_Ultima_Recarga ;;
  }

  dimension: fecha_activacion {
    type: string
    sql: ${TABLE}.Fecha_Activacion ;;
  }

  dimension: fecha_suspension {
    type: string
    sql: ${TABLE}.Fecha_Suspension ;;
  }

  dimension: fecha_inactivacion {
    type: string
    sql: ${TABLE}.Fecha_Inactivacion ;;
  }

  dimension: codigo_seguimiento {
    type: string
    sql: ${TABLE}.Codigo_Seguimiento ;;
  }

  dimension: grupo_afinidad {
    type: string
    sql: ${TABLE}.Grupo_Afinidad ;;
  }

  dimension: uactualiza {
    type: string
    sql: ${TABLE}.UActualiza ;;
  }

  dimension: fecha_ssmensual_ant {
    type: string
    sql: ${TABLE}.Fecha_ssmensual_ant ;;
  }

  dimension: fecha_ssmensual {
    type: string
    sql: ${TABLE}.Fecha_ssmensual ;;
  }

  dimension: codigo_externo {
    type: string
    sql: ${TABLE}.Codigo_Externo ;;
  }

  dimension: fecha_activacion_primera {
    type: string
    sql: ${TABLE}.Fecha_Activacion_Primera ;;
  }

  dimension: transferencia_cantidad_dia {
    type: number
    sql: ${TABLE}.transferencia_cantidad_dia ;;
  }

  dimension: tarjeta_maestra {
    type: string
    sql: ${TABLE}.tarjeta_maestra ;;
  }

  dimension: venta {
    type: string
    sql: ${TABLE}.venta ;;
  }

  dimension_group: venta_asignacion {
    type: time
    sql: ${TABLE}.venta_asignacion ;;
  }

  dimension_group: venta_anulacion {
    type: time
    sql: ${TABLE}.venta_anulacion ;;
  }

  dimension: puntos {
    type: number
    sql: ${TABLE}.Puntos ;;
  }

  dimension: fecha_primera_recarga {
    type: string
    sql: ${TABLE}.Fecha_Primera_Recarga ;;
  }

  dimension: numero_programa_lealtad {
    type: string
    sql: ${TABLE}.Numero_Programa_Lealtad ;;
  }

  dimension: nombre_track_1 {
    type: string
    sql: ${TABLE}.Nombre_Track_1 ;;
  }

  dimension: tipo_programa_lealtad {
    type: string
    sql: ${TABLE}.Tipo_Programa_Lealtad ;;
  }

  dimension: fecha_ultima_transaccion {
    type: string
    sql: ${TABLE}.Fecha_Ultima_Transaccion ;;
  }

  dimension: estado_scoring_activacion {
    type: string
    sql: ${TABLE}.estado_scoring_activacion ;;
  }

  dimension: scoring_activacion {
    type: number
    sql: ${TABLE}.scoring_activacion ;;
  }

  dimension: pago_servicio {
    type: string
    sql: ${TABLE}.pago_servicio ;;
  }

  dimension: apellido_paterno_ant {
    type: string
    sql: ${TABLE}.Apellido_Paterno_Ant ;;
  }

  dimension: apellido_materno_ant {
    type: string
    sql: ${TABLE}.Apellido_Materno_Ant ;;
  }

  dimension: nombres_ant {
    type: string
    sql: ${TABLE}.Nombres_Ant ;;
  }

  dimension: id_motivos_suspensiones {
    type: number
    sql: ${TABLE}.id_motivos_suspensiones ;;
  }

  dimension: id_clientes_uba {
    type: number
    sql: ${TABLE}.id_clientes_uba ;;
  }

  dimension: fecha_ultima_txn_suspension {
    type: string
    sql: ${TABLE}.Fecha_Ultima_Txn_Suspension ;;
  }

  dimension: regimen {
    type: string
    sql: ${TABLE}.Regimen ;;
  }

  dimension: estado_scoring {
    type: string
    sql: ${TABLE}.estado_scoring ;;
  }

  dimension: tipo_tarjeta {
    type: string
    sql: ${TABLE}.tipo_tarjeta ;;
  }

  dimension: business_api {
    type: yesno
    sql: ${TABLE}.business_api ;;
  }

  dimension: id_db {
    type: string
    sql: ${TABLE}.id_db ;;
  }

  dimension: usuario_creacion {
    type: string
    sql: ${TABLE}.usuario_creacion ;;
  }

  dimension_group: fecha_creacion {
    type: time
    sql: ${TABLE}.fecha_creacion ;;
  }

  set: detail {
    fields: [
        numero_tarjeta,
	estado_tarjeta,
	apellido_paterno,
	apellido_materno,
	nombres,
	categoria_tarjeta,
	nombre_corto_titular,
	nombre_corto_tarjeta,
	id_tarjetahabientes,
	ruc,
	tipo_registro,
	tipo_mensaje1,
	fecha_transmision,
	hora_transmision,
	numero_clave,
	codigo_adquiriente,
	codigo_emisor,
	codigo_respuesta,
	tipo_mensaje2,
	fecha_afiliacion,
	titulo,
	direccion_remision1,
	direccion_remision2,
	ciudad_remision,
	departamento_remision,
	codigo_postal,
	telefono_particular,
	sexo,
	fecha_nacimiento,
	estado_civil,
	codigo_plaza_afiliacion,
	tipo_documento,
	numero_documento,
	status_tarjeta,
	contador_malos_intentos,
	fecha_ejecucion,
	fecha_expiracion,
	visitas,
	fecha_ingreso,
	hora_ingreso,
	fecha_actualizacion,
	hora_actualizacion,
	fecha_actividad_financ,
	hora_actividad_financ,
	indicador_distribucion,
	ult_act_saldo,
	bloqueo,
	saldo,
	saldo_antier,
	credito,
	saldo_credito,
	saldo_uba,
	saldo_cc,
	saldo_inicial,
	total_cargo,
	total_abono,
	total_comision,
	reposicion,
	fecha_ultima_txn,
	fecha_ultima_recarga,
	fecha_activacion,
	fecha_suspension,
	fecha_inactivacion,
	codigo_seguimiento,
	grupo_afinidad,
	uactualiza,
	fecha_ssmensual_ant,
	fecha_ssmensual,
	codigo_externo,
	fecha_activacion_primera,
	transferencia_cantidad_dia,
	tarjeta_maestra,
	venta,
	venta_asignacion_time,
	venta_anulacion_time,
	puntos,
	fecha_primera_recarga,
	numero_programa_lealtad,
	nombre_track_1,
	tipo_programa_lealtad,
	fecha_ultima_transaccion,
	estado_scoring_activacion,
	scoring_activacion,
	pago_servicio,
	apellido_paterno_ant,
	apellido_materno_ant,
	nombres_ant,
	id_motivos_suspensiones,
	id_clientes_uba,
	fecha_ultima_txn_suspension,
	regimen,
	estado_scoring,
	tipo_tarjeta,
	business_api,
	id_db,
	usuario_creacion,
	fecha_creacion_time
    ]
  }
}
