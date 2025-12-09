view: dm_survey_responses {
  sql_table_name: `yukoga-sandbox-001.bq_hands_on.dm_survey_responses` ;;

  dimension: atmosphere_improvement_points {
    hidden: yes
    sql: ${TABLE}.atmosphere_improvement_points ;;
  }
  dimension: categories {
    type: string
    description: "Main categories related to the survey."
    sql: ${TABLE}.categories ;;
  }
  dimension: comment_satisfaction {
    type: string
    description: "Customer's open-text feedback on satisfaction."
    sql: ${TABLE}.comment_satisfaction ;;
  }
  dimension: customer_age_group {
    type: string
    description: "Age group of the customer."
    sql: ${TABLE}.customer_age_group ;;
  }
  dimension: customer_gender {
    type: string
    description: "Gender of the customer."
    sql: ${TABLE}.customer_gender ;;
  }
  dimension: is_detractor {
    type: number
    description: "Boolean flag (1/0) indicating if the customer is a Detractor."
    sql: ${TABLE}.is_detractor ;;
  }
  dimension: is_promoter {
    type: number
    description: "Boolean flag (1/0) indicating if the customer is a Promoter."
    sql: ${TABLE}.is_promoter ;;
  }
  dimension: nps_score {
    type: number
    description: "Net Promoter Score (0-10)."
    sql: ${TABLE}.nps_score ;;
  }
  dimension: nps_segment {
    type: string
    description: "NPS segment calculated from nps_score (Promoter, Passive, Detractor)."
    sql: ${TABLE}.nps_segment ;;
  }
  dimension: opinion_flag_yn {
    type: string
    description: "Flag indicating if the customer provided a specific opinion."
    sql: ${TABLE}.opinion_flag_yn ;;
  }
  dimension: overall_satisfaction {
    type: string
    description: "Customer's overall satisfaction rating."
    sql: ${TABLE}.overall_satisfaction ;;
  }
  dimension: product_improvement_points {
    hidden: yes
    sql: ${TABLE}.product_improvement_points ;;
  }
  dimension: purchased_products {
    hidden: yes
    sql: ${TABLE}.purchased_products ;;
  }
  dimension_group: responded {
    type: time
    description: "Timestamp when the survey was submitted."
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.responded_at ;;
  }
  dimension: response_id {
    type: number
    description: "Unique identifier for each survey response."
    sql: ${TABLE}.response_id ;;
  }
  dimension: reuse_intent {
    type: string
    description: "Likelihood of the customer visiting again."
    sql: ${TABLE}.reuse_intent ;;
  }
  dimension: sales_group {
    type: string
    description: "Sales group or region for the store."
    sql: ${TABLE}.sales_group ;;
  }
  dimension: satisfaction_atmosphere {
    type: string
    description: "Satisfaction with the store's atmosphere."
    sql: ${TABLE}.satisfaction_atmosphere ;;
  }
  dimension: satisfaction_product_taste {
    type: string
    description: "Satisfaction with the taste of the products."
    sql: ${TABLE}.satisfaction_product_taste ;;
  }
  dimension: satisfaction_reasons {
    hidden: yes
    sql: ${TABLE}.satisfaction_reasons ;;
  }
  dimension: satisfaction_staff_service {
    type: string
    description: "Satisfaction with the staff's service."
    sql: ${TABLE}.satisfaction_staff_service ;;
  }
  dimension: service_speed_rating {
    type: string
    description: "Rating of the service speed."
    sql: ${TABLE}.service_speed_rating ;;
  }
  dimension: staff_improvement_points {
    hidden: yes
    sql: ${TABLE}.staff_improvement_points ;;
  }
  dimension: store_code {
    type: number
    description: "Unique code for the store where the survey was taken."
    sql: ${TABLE}.store_code ;;
  }
  dimension: store_name {
    type: string
    description: "Name of the store."
    sql: ${TABLE}.store_name ;;
  }
  dimension: sub_categories {
    type: string
    description: "Sub-categories related to the survey."
    sql: ${TABLE}.sub_categories ;;
  }
  dimension: usage_scenes {
    hidden: yes
    sql: ${TABLE}.usage_scenes ;;
  }
  dimension: visit_frequency {
    type: string
    description: "How often the customer visits."
    sql: ${TABLE}.visit_frequency ;;
  }
  measure: count {
    type: count
    drill_fields: [store_name]
  }
}

view: dm_survey_responses__usage_scenes {

  dimension: dm_survey_responses__usage_scenes {
    type: string
    description: "Situations in which the customer uses the coffee shop (e.g., takeout, with friends)."
    sql: dm_survey_responses__usage_scenes ;;
  }
}

view: dm_survey_responses__purchased_products {

  dimension: dm_survey_responses__purchased_products {
    type: string
    description: "Products purchased by the customer."
    sql: dm_survey_responses__purchased_products ;;
  }
}

view: dm_survey_responses__satisfaction_reasons {

  dimension: dm_survey_responses__satisfaction_reasons {
    type: string
    description: "Reasons for the customer's satisfaction level."
    sql: dm_survey_responses__satisfaction_reasons ;;
  }
}

view: dm_survey_responses__staff_improvement_points {

  dimension: dm_survey_responses__staff_improvement_points {
    type: string
    description: "Customer suggestions for staff service improvements."
    sql: dm_survey_responses__staff_improvement_points ;;
  }
}

view: dm_survey_responses__product_improvement_points {

  dimension: dm_survey_responses__product_improvement_points {
    type: string
    description: "Customer suggestions for product improvements."
    sql: dm_survey_responses__product_improvement_points ;;
  }
}

view: dm_survey_responses__atmosphere_improvement_points {

  dimension: dm_survey_responses__atmosphere_improvement_points {
    type: string
    description: "Customer suggestions for atmosphere improvements."
    sql: dm_survey_responses__atmosphere_improvement_points ;;
  }
}
