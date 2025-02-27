SELECT
    "awards"."generated_unique_award_id" AS "contract_award_unique_key",
    "awards"."piid" AS "award_id_piid",
    "transaction_fpds"."referenced_idv_agency_iden" AS "parent_award_agency_id",
    "transaction_fpds"."referenced_idv_agency_desc" AS "parent_award_agency_name",
    "awards"."parent_award_piid" AS "parent_award_id_piid",
    DEFC."disaster_emergency_funds" AS "disaster_emergency_fund_codes",
    DEFC."gross_outlay_amount_by_award_cpe" + DEFC."ussgl487200_down_adj_pri_ppaid_undel_orders_oblig_refund_cpe" + DEFC."ussgl497200_down_adj_pri_paid_deliv_orders_oblig_refund_cpe" AS "outlayed_amount_funded_by_COVID-19_supplementals",
    DEFC."transaction_obligated_amount" AS "obligated_amount_funded_by_COVID-19_supplementals",
    "awards"."total_obligation" AS "total_obligated_amount",
    "transaction_fpds"."current_total_value_award" AS "current_total_value_of_award",
    "transaction_fpds"."potential_total_value_awar" AS "potential_total_value_of_award",
    "awards"."date_signed" AS "award_base_action_date",
    EXTRACT (YEAR FROM ("awards"."date_signed") + INTERVAL '3 months') AS "award_base_action_date_fiscal_year",
    "transaction_fpds"."action_date" AS "award_latest_action_date",
    EXTRACT (YEAR FROM ("transaction_fpds"."action_date"::DATE) + INTERVAL '3 months') AS "award_latest_action_date_fiscal_year",
    "awards"."period_of_performance_start_date" AS "period_of_performance_start_date",
    "transaction_fpds"."period_of_performance_curr" AS "period_of_performance_current_end_date",
    "transaction_fpds"."period_of_perf_potential_e" AS "period_of_performance_potential_end_date",
    "transaction_fpds"."ordering_period_end_date" AS "ordering_period_end_date",
    "earliest_transaction"."solicitation_date" AS "solicitation_date",
    "transaction_fpds"."awarding_agency_code" AS "awarding_agency_code",
    "transaction_fpds"."awarding_agency_name" AS "awarding_agency_name",
    "transaction_fpds"."awarding_sub_tier_agency_c" AS "awarding_sub_agency_code",
    "transaction_fpds"."awarding_sub_tier_agency_n" AS "awarding_sub_agency_name",
    "transaction_fpds"."awarding_office_code" AS "awarding_office_code",
    "transaction_fpds"."awarding_office_name" AS "awarding_office_name",
    "transaction_fpds"."funding_agency_code" AS "funding_agency_code",
    "transaction_fpds"."funding_agency_name" AS "funding_agency_name",
    "transaction_fpds"."funding_sub_tier_agency_co" AS "funding_sub_agency_code",
    "transaction_fpds"."funding_sub_tier_agency_na" AS "funding_sub_agency_name",
    "transaction_fpds"."funding_office_code" AS "funding_office_code",
    "transaction_fpds"."funding_office_name" AS "funding_office_name",
    (SELECT STRING_AGG (DISTINCT U2."tas_rendering_label", ';') AS "value" FROM "awards" U0 LEFT OUTER JOIN "financial_accounts_by_awards" U1 ON (U0. "id" = U1. "award_id") LEFT OUTER JOIN "treasury_appropriation_account" U2 ON (U1. "treasury_account_id" = U2. "treasury_account_identifier") WHERE U0. "id" = ("awards"."id") GROUP BY U0. "id") AS "treasury_accounts_funding_this_award",
    (SELECT STRING_AGG (DISTINCT U3."federal_account_code", ';') AS "value" FROM "awards" U0 LEFT OUTER JOIN "financial_accounts_by_awards" U1 ON (U0. "id" = U1. "award_id") LEFT OUTER JOIN "treasury_appropriation_account" U2 ON (U1. "treasury_account_id" = U2. "treasury_account_identifier") LEFT OUTER JOIN "federal_account" U3 ON (U2. "federal_account_id" = U3. "id") WHERE U0. "id" = ("awards"."id") GROUP BY U0. "id") AS "federal_accounts_funding_this_award",
    (SELECT STRING_AGG(DISTINCT CONCAT(U2."object_class", ':', U2.object_class_name), ';')FROM "awards" U0 LEFT OUTER JOIN "financial_accounts_by_awards" U1 ON (U0. "id" = U1. "award_id") INNER JOIN "object_class" U2 ON (U1. "object_class_id" = U2. "id") WHERE U0. "id" = ("awards"."id") and U1.object_class_id is not null GROUP BY U0. "id")AS "object_classes_funding_this_award",
    (SELECT STRING_AGG(DISTINCT CONCAT(U2."program_activity_code", ':', U2.program_activity_name), ';') FROM "awards" U0 LEFT OUTER JOIN "financial_accounts_by_awards" U1 ON (U0. "id" = U1. "award_id") INNER JOIN "ref_program_activity" U2 ON (U1. "program_activity_id" = U2. "id") WHERE U0. "id" = ("awards"."id") and U1.program_activity_id is not null GROUP BY U0. "id") AS "program_activities_funding_this_award",
    "transaction_fpds"."foreign_funding" AS "foreign_funding",
    "transaction_fpds"."foreign_funding_desc" AS "foreign_funding_description",
    "transaction_fpds"."sam_exception" AS "sam_exception",
    "transaction_fpds"."sam_exception_description" AS "sam_exception_description",
    "transaction_fpds"."awardee_or_recipient_uniqu" AS "recipient_duns",
    "transaction_fpds"."awardee_or_recipient_legal" AS "recipient_name",
    "transaction_fpds"."vendor_doing_as_business_n" AS "recipient_doing_business_as_name",
    "transaction_fpds"."cage_code" AS "cage_code",
    "transaction_fpds"."ultimate_parent_unique_ide" AS "recipient_parent_duns",
    "transaction_fpds"."ultimate_parent_legal_enti" AS "recipient_parent_name",
    "transaction_fpds"."legal_entity_country_code" AS "recipient_country_code",
    "transaction_fpds"."legal_entity_country_name" AS "recipient_country_name",
    "transaction_fpds"."legal_entity_address_line1" AS "recipient_address_line_1",
    "transaction_fpds"."legal_entity_address_line2" AS "recipient_address_line_2",
    "transaction_fpds"."legal_entity_city_name" AS "recipient_city_name",
    "transaction_fpds"."legal_entity_county_name" AS "recipient_county_name",
    "transaction_fpds"."legal_entity_state_code" AS "recipient_state_code",
    "transaction_fpds"."legal_entity_state_descrip" AS "recipient_state_name",
    "transaction_fpds"."legal_entity_zip4" AS "recipient_zip_4_code",
    "transaction_fpds"."legal_entity_congressional" AS "recipient_congressional_district",
    "transaction_fpds"."vendor_phone_number" AS "recipient_phone_number",
    "transaction_fpds"."vendor_fax_number" AS "recipient_fax_number",
    "transaction_fpds"."place_of_perform_country_c" AS "primary_place_of_performance_country_code",
    "transaction_fpds"."place_of_perf_country_desc" AS "primary_place_of_performance_country_name",
    "transaction_fpds"."place_of_perform_city_name" AS "primary_place_of_performance_city_name",
    "transaction_fpds"."place_of_perform_county_na" AS "primary_place_of_performance_county_name",
    "transaction_fpds"."place_of_performance_state" AS "primary_place_of_performance_state_code",
    "transaction_fpds"."place_of_perfor_state_desc" AS "primary_place_of_performance_state_name",
    "transaction_fpds"."place_of_performance_zip4a" AS "primary_place_of_performance_zip_4",
    "transaction_fpds"."place_of_performance_congr" AS "primary_place_of_performance_congressional_district",
    "transaction_fpds"."pulled_from" AS "award_or_idv_flag",
    "transaction_fpds"."contract_award_type" AS "award_type_code",
    "transaction_fpds"."contract_award_type_desc" AS "award_type",
    "transaction_fpds"."idv_type" AS "idv_type_code",
    "transaction_fpds"."idv_type_description" AS "idv_type",
    "transaction_fpds"."multiple_or_single_award_i" AS "multiple_or_single_award_idv_code",
    "transaction_fpds"."multiple_or_single_aw_desc" AS "multiple_or_single_award_idv",
    "transaction_fpds"."type_of_idc" AS "type_of_idc_code",
    "transaction_fpds"."type_of_idc_description" AS "type_of_idc",
    "transaction_fpds"."type_of_contract_pricing" AS "type_of_contract_pricing_code",
    "transaction_fpds"."type_of_contract_pric_desc" AS "type_of_contract_pricing",
    "awards"."description" AS "award_description",
    "transaction_fpds"."solicitation_identifier" AS "solicitation_identifier",
    "transaction_fpds"."number_of_actions" AS "number_of_actions",
    "transaction_fpds"."inherently_government_func" AS "inherently_governmental_functions",
    "transaction_fpds"."inherently_government_desc" AS "inherently_governmental_functions_description",
    "transaction_fpds"."product_or_service_code" AS "product_or_service_code",
    "transaction_fpds"."product_or_service_co_desc" AS "product_or_service_code_description",
    "transaction_fpds"."contract_bundling" AS "contract_bundling_code",
    "transaction_fpds"."contract_bundling_descrip" AS "contract_bundling",
    "transaction_fpds"."dod_claimant_program_code" AS "dod_claimant_program_code",
    "transaction_fpds"."dod_claimant_prog_cod_desc" AS "dod_claimant_program_description",
    "transaction_fpds"."naics" AS "naics_code",
    "transaction_fpds"."naics_description" AS "naics_description",
    "transaction_fpds"."recovered_materials_sustai" AS "recovered_materials_sustainability_code",
    "transaction_fpds"."recovered_materials_s_desc" AS "recovered_materials_sustainability",
    "transaction_fpds"."domestic_or_foreign_entity" AS "domestic_or_foreign_entity_code",
    "transaction_fpds"."domestic_or_foreign_e_desc" AS "domestic_or_foreign_entity",
    "transaction_fpds"."program_system_or_equipmen" AS "dod_acquisition_program_code",
    "transaction_fpds"."program_system_or_equ_desc" AS "dod_acquisition_program_description",
    "transaction_fpds"."information_technology_com" AS "information_technology_commercial_item_category_code",
    "transaction_fpds"."information_technolog_desc" AS "information_technology_commercial_item_category",
    "transaction_fpds"."epa_designated_product" AS "epa_designated_product_code",
    "transaction_fpds"."epa_designated_produc_desc" AS "epa_designated_product",
    "transaction_fpds"."country_of_product_or_serv" AS "country_of_product_or_service_origin_code",
    "transaction_fpds"."country_of_product_or_desc" AS "country_of_product_or_service_origin",
    "transaction_fpds"."place_of_manufacture" AS "place_of_manufacture_code",
    "transaction_fpds"."place_of_manufacture_desc" AS "place_of_manufacture",
    "transaction_fpds"."subcontracting_plan" AS "subcontracting_plan_code",
    "transaction_fpds"."subcontracting_plan_desc" AS "subcontracting_plan",
    "transaction_fpds"."extent_competed" AS "extent_competed_code",
    "transaction_fpds"."extent_compete_description" AS "extent_competed",
    "transaction_fpds"."solicitation_procedures" AS "solicitation_procedures_code",
    "transaction_fpds"."solicitation_procedur_desc" AS "solicitation_procedures",
    "transaction_fpds"."type_set_aside" AS "type_of_set_aside_code",
    "transaction_fpds"."type_set_aside_description" AS "type_of_set_aside",
    "transaction_fpds"."evaluated_preference" AS "evaluated_preference_code",
    "transaction_fpds"."evaluated_preference_desc" AS "evaluated_preference",
    "transaction_fpds"."research" AS "research_code",
    "transaction_fpds"."research_description" AS "research",
    "transaction_fpds"."fair_opportunity_limited_s" AS "fair_opportunity_limited_sources_code",
    "transaction_fpds"."fair_opportunity_limi_desc" AS "fair_opportunity_limited_sources",
    "transaction_fpds"."other_than_full_and_open_c" AS "other_than_full_and_open_competition_code",
    "transaction_fpds"."other_than_full_and_o_desc" AS "other_than_full_and_open_competition",
    "transaction_fpds"."number_of_offers_received" AS "number_of_offers_received",
    "transaction_fpds"."commercial_item_acquisitio" AS "commercial_item_acquisition_procedures_code",
    "transaction_fpds"."commercial_item_acqui_desc" AS "commercial_item_acquisition_procedures",
    "transaction_fpds"."small_business_competitive" AS "small_business_competitiveness_demonstration_program",
    "transaction_fpds"."commercial_item_test_progr" AS "simplified_procedures_for_certain_commercial_items_code",
    "transaction_fpds"."commercial_item_test_desc" AS "simplified_procedures_for_certain_commercial_items",
    "transaction_fpds"."a_76_fair_act_action" AS "a76_fair_act_action_code",
    "transaction_fpds"."a_76_fair_act_action_desc" AS "a76_fair_act_action",
    "transaction_fpds"."fed_biz_opps" AS "fed_biz_opps_code",
    "transaction_fpds"."fed_biz_opps_description" AS "fed_biz_opps",
    "transaction_fpds"."local_area_set_aside" AS "local_area_set_aside_code",
    "transaction_fpds"."local_area_set_aside_desc" AS "local_area_set_aside",
    "transaction_fpds"."price_evaluation_adjustmen" AS "price_evaluation_adjustment_preference_percent_difference",
    "transaction_fpds"."clinger_cohen_act_planning" AS "clinger_cohen_act_planning_code",
    "transaction_fpds"."clinger_cohen_act_pla_desc" AS "clinger_cohen_act_planning",
    "transaction_fpds"."materials_supplies_article" AS "materials_supplies_articles_equipment_code",
    "transaction_fpds"."materials_supplies_descrip" AS "materials_supplies_articles_equipment",
    "transaction_fpds"."labor_standards" AS "labor_standards_code",
    "transaction_fpds"."labor_standards_descrip" AS "labor_standards",
    "transaction_fpds"."construction_wage_rate_req" AS "construction_wage_rate_requirements_code",
    "transaction_fpds"."construction_wage_rat_desc" AS "construction_wage_rate_requirements",
    "transaction_fpds"."interagency_contracting_au" AS "interagency_contracting_authority_code",
    "transaction_fpds"."interagency_contract_desc" AS "interagency_contracting_authority",
    "transaction_fpds"."other_statutory_authority" AS "other_statutory_authority",
    "transaction_fpds"."program_acronym" AS "program_acronym",
    "transaction_fpds"."referenced_idv_type" AS "parent_award_type_code",
    "transaction_fpds"."referenced_idv_type_desc" AS "parent_award_type",
    "transaction_fpds"."referenced_mult_or_single" AS "parent_award_single_or_multiple_code",
    "transaction_fpds"."referenced_mult_or_si_desc" AS "parent_award_single_or_multiple",
    "transaction_fpds"."major_program" AS "major_program",
    "transaction_fpds"."national_interest_action" AS "national_interest_action_code",
    "transaction_fpds"."national_interest_desc" AS "national_interest_action",
    "transaction_fpds"."cost_or_pricing_data" AS "cost_or_pricing_data_code",
    "transaction_fpds"."cost_or_pricing_data_desc" AS "cost_or_pricing_data",
    "transaction_fpds"."cost_accounting_standards" AS "cost_accounting_standards_clause_code",
    "transaction_fpds"."cost_accounting_stand_desc" AS "cost_accounting_standards_clause",
    "transaction_fpds"."government_furnished_prope" AS "government_furnished_property_code",
    "transaction_fpds"."government_furnished_prope" AS "government_furnished_property",
    "transaction_fpds"."sea_transportation" AS "sea_transportation_code",
    "transaction_fpds"."sea_transportation_desc" AS "sea_transportation",
    "transaction_fpds"."consolidated_contract" AS "consolidated_contract_code",
    "transaction_fpds"."consolidated_contract_desc" AS "consolidated_contract",
    "transaction_fpds"."performance_based_service" AS "performance_based_service_acquisition_code",
    "transaction_fpds"."performance_based_se_desc" AS "performance_based_service_acquisition",
    "transaction_fpds"."multi_year_contract" AS "multi_year_contract_code",
    "transaction_fpds"."multi_year_contract_desc" AS "multi_year_contract",
    "transaction_fpds"."contract_financing" AS "contract_financing_code",
    "transaction_fpds"."contract_financing_descrip" AS "contract_financing",
    "transaction_fpds"."purchase_card_as_payment_m" AS "purchase_card_as_payment_method_code",
    "transaction_fpds"."purchase_card_as_paym_desc" AS "purchase_card_as_payment_method",
    "transaction_fpds"."contingency_humanitarian_o" AS "contingency_humanitarian_or_peacekeeping_operation_code",
    "transaction_fpds"."contingency_humanitar_desc" AS "contingency_humanitarian_or_peacekeeping_operation",
    "transaction_fpds"."alaskan_native_owned_corpo" AS "alaskan_native_corporation_owned_firm",
    "transaction_fpds"."american_indian_owned_busi" AS "american_indian_owned_business",
    "transaction_fpds"."indian_tribe_federally_rec" AS "indian_tribe_federally_recognized",
    "transaction_fpds"."native_hawaiian_owned_busi" AS "native_hawaiian_organization_owned_firm",
    "transaction_fpds"."tribally_owned_business" AS "tribally_owned_firm",
    "transaction_fpds"."veteran_owned_business" AS "veteran_owned_business",
    "transaction_fpds"."service_disabled_veteran_o" AS "service_disabled_veteran_owned_business",
    "transaction_fpds"."woman_owned_business" AS "woman_owned_business",
    "transaction_fpds"."women_owned_small_business" AS "women_owned_small_business",
    "transaction_fpds"."economically_disadvantaged" AS "economically_disadvantaged_women_owned_small_business",
    "transaction_fpds"."joint_venture_women_owned" AS "joint_venture_women_owned_small_business",
    "transaction_fpds"."joint_venture_economically" AS "joint_venture_economic_disadvantaged_women_owned_small_bus",
    "transaction_fpds"."minority_owned_business" AS "minority_owned_business",
    "transaction_fpds"."subcontinent_asian_asian_i" AS "subcontinent_asian_asian_indian_american_owned_business",
    "transaction_fpds"."asian_pacific_american_own" AS "asian_pacific_american_owned_business",
    "transaction_fpds"."black_american_owned_busin" AS "black_american_owned_business",
    "transaction_fpds"."hispanic_american_owned_bu" AS "hispanic_american_owned_business",
    "transaction_fpds"."native_american_owned_busi" AS "native_american_owned_business",
    "transaction_fpds"."other_minority_owned_busin" AS "other_minority_owned_business",
    "transaction_fpds"."contracting_officers_desc" AS "contracting_officers_determination_of_business_size",
    "transaction_fpds"."contracting_officers_deter" AS "contracting_officers_determination_of_business_size_code",
    "transaction_fpds"."emerging_small_business" AS "emerging_small_business",
    "transaction_fpds"."community_developed_corpor" AS "community_developed_corporation_owned_firm",
    "transaction_fpds"."labor_surplus_area_firm" AS "labor_surplus_area_firm",
    "transaction_fpds"."us_federal_government" AS "us_federal_government",
    "transaction_fpds"."federally_funded_research" AS "federally_funded_research_and_development_corp",
    "transaction_fpds"."federal_agency" AS "federal_agency",
    "transaction_fpds"."us_state_government" AS "us_state_government",
    "transaction_fpds"."us_local_government" AS "us_local_government",
    "transaction_fpds"."city_local_government" AS "city_local_government",
    "transaction_fpds"."county_local_government" AS "county_local_government",
    "transaction_fpds"."inter_municipal_local_gove" AS "inter_municipal_local_government",
    "transaction_fpds"."local_government_owned" AS "local_government_owned",
    "transaction_fpds"."municipality_local_governm" AS "municipality_local_government",
    "transaction_fpds"."school_district_local_gove" AS "school_district_local_government",
    "transaction_fpds"."township_local_government" AS "township_local_government",
    "transaction_fpds"."us_tribal_government" AS "us_tribal_government",
    "transaction_fpds"."foreign_government" AS "foreign_government",
    "transaction_fpds"."organizational_type" AS "organizational_type",
    "transaction_fpds"."corporate_entity_not_tax_e" AS "corporate_entity_not_tax_exempt",
    "transaction_fpds"."corporate_entity_tax_exemp" AS "corporate_entity_tax_exempt",
    "transaction_fpds"."partnership_or_limited_lia" AS "partnership_or_limited_liability_partnership",
    "transaction_fpds"."sole_proprietorship" AS "sole_proprietorship",
    "transaction_fpds"."small_agricultural_coopera" AS "small_agricultural_cooperative",
    "transaction_fpds"."international_organization" AS "international_organization",
    "transaction_fpds"."us_government_entity" AS "us_government_entity",
    "transaction_fpds"."community_development_corp" AS "community_development_corporation",
    "transaction_fpds"."domestic_shelter" AS "domestic_shelter",
    "transaction_fpds"."educational_institution" AS "educational_institution",
    "transaction_fpds"."foundation" AS "foundation",
    "transaction_fpds"."hospital_flag" AS "hospital_flag",
    "transaction_fpds"."manufacturer_of_goods" AS "manufacturer_of_goods",
    "transaction_fpds"."veterinary_hospital" AS "veterinary_hospital",
    "transaction_fpds"."hispanic_servicing_institu" AS "hispanic_servicing_institution",
    "transaction_fpds"."contracts" AS "receives_contracts",
    "transaction_fpds"."grants" AS "receives_financial_assistance",
    "transaction_fpds"."receives_contracts_and_gra" AS "receives_contracts_and_financial_assistance",
    "transaction_fpds"."airport_authority" AS "airport_authority",
    "transaction_fpds"."council_of_governments" AS "council_of_governments",
    "transaction_fpds"."housing_authorities_public" AS "housing_authorities_public_tribal",
    "transaction_fpds"."interstate_entity" AS "interstate_entity",
    "transaction_fpds"."planning_commission" AS "planning_commission",
    "transaction_fpds"."port_authority" AS "port_authority",
    "transaction_fpds"."transit_authority" AS "transit_authority",
    "transaction_fpds"."subchapter_s_corporation" AS "subchapter_scorporation",
    "transaction_fpds"."limited_liability_corporat" AS "limited_liability_corporation",
    "transaction_fpds"."foreign_owned_and_located" AS "foreign_owned",
    "transaction_fpds"."for_profit_organization" AS "for_profit_organization",
    "transaction_fpds"."nonprofit_organization" AS "nonprofit_organization",
    "transaction_fpds"."other_not_for_profit_organ" AS "other_not_for_profit_organization",
    "transaction_fpds"."the_ability_one_program" AS "the_ability_one_program",
    "transaction_fpds"."private_university_or_coll" AS "private_university_or_college",
    "transaction_fpds"."state_controlled_instituti" AS "state_controlled_institution_of_higher_learning",
    "transaction_fpds"."c1862_land_grant_college" AS "1862_land_grant_college",
    "transaction_fpds"."c1890_land_grant_college" AS "1890_land_grant_college",
    "transaction_fpds"."c1994_land_grant_college" AS "1994_land_grant_college",
    "transaction_fpds"."minority_institution" AS "minority_institution",
    "transaction_fpds"."historically_black_college" AS "historically_black_college",
    "transaction_fpds"."tribal_college" AS "tribal_college",
    "transaction_fpds"."alaskan_native_servicing_i" AS "alaskan_native_servicing_institution",
    "transaction_fpds"."native_hawaiian_servicing" AS "native_hawaiian_servicing_institution",
    "transaction_fpds"."school_of_forestry" AS "school_of_forestry",
    "transaction_fpds"."veterinary_college" AS "veterinary_college",
    "transaction_fpds"."dot_certified_disadvantage" AS "dot_certified_disadvantage",
    "transaction_fpds"."self_certified_small_disad" AS "self_certified_small_disadvantaged_business",
    "transaction_fpds"."small_disadvantaged_busine" AS "small_disadvantaged_business",
    "transaction_fpds"."c8a_program_participant" AS "c8a_program_participant",
    "transaction_fpds"."historically_underutilized" AS "historically_underutilized_business_zone_hubzone_firm",
    "transaction_fpds"."sba_certified_8_a_joint_ve" AS "sba_certified_8a_joint_venture",
    "awards"."officer_1_name" AS "highly_compensated_officer_1_name",
    "awards"."officer_1_amount" AS "highly_compensated_officer_1_amount",
    "awards"."officer_2_name" AS "highly_compensated_officer_2_name",
    "awards"."officer_2_amount" AS "highly_compensated_officer_2_amount",
    "awards"."officer_3_name" AS "highly_compensated_officer_3_name",
    "awards"."officer_3_amount" AS "highly_compensated_officer_3_amount",
    "awards"."officer_4_name" AS "highly_compensated_officer_4_name",
    "awards"."officer_4_amount" AS "highly_compensated_officer_4_amount",
    "awards"."officer_5_name" AS "highly_compensated_officer_5_name",
    "awards"."officer_5_amount" AS "highly_compensated_officer_5_amount",
    CONCAT('https://www.usaspending.gov/award/', urlencode("awards"."generated_unique_award_id"), '/') AS "usaspending_permalink",
    "transaction_fpds"."last_modified" AS "last_modified_date"
FROM "awards"
INNER JOIN "transaction_fpds" ON ("awards"."latest_transaction_id" = "transaction_fpds"."transaction_id")
INNER JOIN "transaction_fpds" AS "earliest_transaction" ON ("awards"."earliest_transaction_id" = "earliest_transaction"."transaction_id")
INNER JOIN (
    SELECT
        faba.award_id,
        STRING_AGG(DISTINCT CONCAT(disaster_emergency_fund_code, ': ', public_law), '; ' ORDER BY CONCAT(disaster_emergency_fund_code, ': ', public_law)) AS disaster_emergency_funds,
        COALESCE(SUM(CASE WHEN sa.is_final_balances_for_fy = TRUE THEN faba.gross_outlay_amount_by_award_cpe END), 0) AS gross_outlay_amount_by_award_cpe,
        COALESCE(SUM(CASE WHEN sa.is_final_balances_for_fy = TRUE THEN faba.ussgl487200_down_adj_pri_ppaid_undel_orders_oblig_refund_cpe END), 0) AS ussgl487200_down_adj_pri_ppaid_undel_orders_oblig_refund_cpe,
        COALESCE(SUM(CASE WHEN sa.is_final_balances_for_fy = TRUE THEN faba.ussgl497200_down_adj_pri_paid_deliv_orders_oblig_refund_cpe END), 0) AS ussgl497200_down_adj_pri_paid_deliv_orders_oblig_refund_cpe,
        COALESCE(SUM(faba.transaction_obligated_amount), 0) AS transaction_obligated_amount
    FROM
        financial_accounts_by_awards faba
    INNER JOIN disaster_emergency_fund_code defc
        ON defc.code = faba.disaster_emergency_fund_code
        AND defc.group_name = 'covid_19'
    INNER JOIN submission_attributes sa
        ON faba.submission_id = sa.submission_id
        AND sa.reporting_period_start >= '2020-04-01'
    INNER JOIN dabs_submission_window_schedule ON (
        sa."submission_window_id" = dabs_submission_window_schedule."id"
        AND dabs_submission_window_schedule."submission_reveal_date" <= now()
    )
    WHERE
        faba.award_id IS NOT NULL
    GROUP BY
        faba.award_id
    HAVING
        COALESCE(
            SUM(
                CASE
                    WHEN sa.is_final_balances_for_fy = TRUE
                    THEN
                        COALESCE(faba.gross_outlay_amount_by_award_cpe, 0)
                        + COALESCE(faba.ussgl487200_down_adj_pri_ppaid_undel_orders_oblig_refund_cpe, 0)
                        + COALESCE(faba.ussgl497200_down_adj_pri_paid_deliv_orders_oblig_refund_cpe, 0)
                END
            ),
            0
        ) != 0
        OR COALESCE(SUM(faba.transaction_obligated_amount), 0) != 0
) DEFC ON (DEFC.award_id = awards.id)
