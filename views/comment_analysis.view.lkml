view: comment_analysis {
  sql_table_name: `yukoga-sandbox-001.bq_hands_on.comment_analysis` ;;

  dimension: comment_categories {
    type: string
    description: "Categories associated with the comment."
    sql: ${TABLE}.comment_categories ;;
  }
  dimension: comment_sentiment {
    type: string
    description: "Sentiment analysis result for the comment."
    sql: ${TABLE}.comment_sentiment ;;
  }
  dimension: response_id {
    type: number
    description: "Unique identifier for each response."
    sql: ${TABLE}.response_id ;;
  }
  measure: count {
    type: count
  }
}
