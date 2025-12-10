view: dm_survey_responses {
  view_label: "Survey Responses"
  sql_table_name: `yukoga-sandbox-001.bq_hands_on.dm_survey_responses` ;;

  dimension: atmosphere_improvement_points {
    hidden: yes
    sql: ${TABLE}.atmosphere_improvement_points ;;
  }
  dimension: answer_categories {
    type: string
    description: "Merged category from survey or comment analysis."
    sql: COALESCE(${categories}, ${comment_analysis.comment_categories}, '該当カテゴリなし') ;;
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

  dimension: is_valid_response {
    type: number
    description: "Flag (1/0) indicating a valid response (non-null key fields)."
    sql: CASE WHEN ${response_id} IS NOT NULL
               AND ${purchased_products} IS NOT NULL
               AND ${sales_group} IS NOT NULL
               AND ${store_name} IS NOT NULL
               AND ${store_code} IS NOT NULL
              THEN 1 ELSE 0 END ;;
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
    primary_key: yes
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

  measure: n_responses {
    type: count_distinct
    description: "Distinct count of Response IDs."
    sql: ${response_id} ;;
  }

  measure: n_valid_responses {
    type: count_distinct
    description: "Distinct count of Response IDs for valid responses."
    sql: ${response_id} ;;
    filters: [is_valid_response: "1"]
  }

  measure: average_nps_score {
    type: average
    description: "Average NPS Score for valid responses."
    sql: ${nps_score} ;;
    filters: [is_valid_response: "1"]
  }

  measure: n_satisfaction {
    type: count_distinct
    description: "Count of satisfied customers (Satisfied or Very Satisfied)."
    sql: ${response_id} ;;
    filters: [overall_satisfaction: "満足, とても満足"]
  }

  measure: valid_response_rate {
    type: number
    description: "Rate of valid responses against total responses."
    sql: 1.0 * ${n_valid_responses} / NULLIF(${n_responses}, 0) ;;
    value_format_name: percent_1
  }

  measure: satisfaction_rate {
    type: number
    description: "Rate of satisfied customers against total responses."
    sql: 1.0 * ${n_satisfaction} / NULLIF(${n_responses}, 0) ;;
    value_format_name: percent_1
  }

  measure: n_promoters {
    type: count_distinct
    description: "Count of Promoter customers."
    sql: ${response_id} ;;
    filters: [nps_segment: "Promoter"]
  }

  measure: nps_promoter_ratio {
    type: number
    description: "Ratio of Promoters against total responses."
    sql: 1.0 * ${n_promoters} / NULLIF(${n_responses}, 0) ;;
    value_format_name: percent_1
  }

  measure: satisfaction_rate_yoy {
    label: "Satisfaction Rate YoY"
    type: period_over_period
    kind: relative_change
    based_on: satisfaction_rate
    based_on_time: responded_date
    period: year
    value_format_name: percent_1
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

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${dm_survey_responses.response_id} AS STRING), ${dm_survey_responses__purchased_products}) ;;
  }

  measure: n_purchased_products {
    type: count
    description: "Total count of purchased products."
  }

  measure: n_purchased_products_yoy {
    label: "N Purchased Products YoY"
    type: period_over_period
    kind: relative_change
    based_on: n_purchased_products
    based_on_time: dm_survey_responses.responded_date
    period: year
    value_format_name: percent_1
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
