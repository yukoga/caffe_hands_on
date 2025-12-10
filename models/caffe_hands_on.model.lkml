connection: "bq_hands_on"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: caffe_hands_on_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: caffe_hands_on_default_datagroup

explore: dm_survey_responses {
  label: "Customer Survey Analysis"
  description: "This Explore contains customer survey data including NPS scores, satisfaction ratings, purchase history, and comments. Use this to analyze customer feedback and store performance."

  join: dm_survey_responses__usage_scenes {
    view_label: "Dm Survey Responses: Usage Scenes"
    sql: LEFT JOIN UNNEST(${dm_survey_responses.usage_scenes}) as dm_survey_responses__usage_scenes ;;
    relationship: one_to_many
  }
  join: dm_survey_responses__purchased_products {
    view_label: "Dm Survey Responses: Purchased Products"
    sql: LEFT JOIN UNNEST(${dm_survey_responses.purchased_products}) as dm_survey_responses__purchased_products ;;
    relationship: one_to_many
  }
  join: dm_survey_responses__satisfaction_reasons {
    view_label: "Dm Survey Responses: Satisfaction Reasons"
    sql: LEFT JOIN UNNEST(${dm_survey_responses.satisfaction_reasons}) as dm_survey_responses__satisfaction_reasons ;;
    relationship: one_to_many
  }
  join: dm_survey_responses__staff_improvement_points {
    view_label: "Dm Survey Responses: Staff Improvement Points"
    sql: LEFT JOIN UNNEST(${dm_survey_responses.staff_improvement_points}) as dm_survey_responses__staff_improvement_points ;;
    relationship: one_to_many
  }
  join: dm_survey_responses__product_improvement_points {
    view_label: "Dm Survey Responses: Product Improvement Points"
    sql: LEFT JOIN UNNEST(${dm_survey_responses.product_improvement_points}) as dm_survey_responses__product_improvement_points ;;
    relationship: one_to_many
  }
  join: dm_survey_responses__atmosphere_improvement_points {
    view_label: "Dm Survey Responses: Atmosphere Improvement Points"
    sql: LEFT JOIN UNNEST(${dm_survey_responses.atmosphere_improvement_points}) as dm_survey_responses__atmosphere_improvement_points ;;
    relationship: one_to_many
  }

  join: comment_analysis {
    type: left_outer
    sql_on: ${dm_survey_responses.response_id} = ${comment_analysis.response_id} ;;
    relationship: one_to_one
  }
}
