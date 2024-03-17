view: rw_tb_eventos {
  sql_table_name: `ligocloudplatform.lake.rw_tb_eventos` ;;

  dimension: brand_device {
    type: string
    sql: ${TABLE}.brandDevice ;;
  }
  dimension: created_at {
    type: string
    sql: ${TABLE}.createdAt ;;
  }
  dimension: created_at_utc {
    type: string
    sql: ${TABLE}.createdAtUTC ;;
  }
  dimension: document {
    type: string
    sql: ${TABLE}.document ;;
  }
  dimension: fecha {
    type: string
    sql: ${TABLE}.Fecha ;;
  }
  dimension: hora {
    type: string
    sql: ${TABLE}.Hora ;;
  }
  dimension: model_device {
    type: string
    sql: ${TABLE}.modelDevice ;;
  }
  dimension: name_event {
    type: string
    sql: ${TABLE}.nameEvent ;;
  }
  dimension: name_user {
    type: string
    sql: ${TABLE}.nameUser ;;
  }
  dimension: token_session2 {
    type: string
    sql: ${TABLE}.tokenSession2 ;;
  }
  dimension: type_document {
    type: string
    sql: ${TABLE}.typeDocument ;;
  }
  dimension: version_app {
    type: string
    sql: ${TABLE}.versionApp ;;
  }
  measure: count {
    type: count
  }
}
