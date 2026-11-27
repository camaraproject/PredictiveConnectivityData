Feature: CAMARA Predictive Connectivity Data Subscriptions API, vwip
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Whether asynchronous creation/deletion processing is supported
  # * Max size of a route (number of waypoints) supported
  # * Pagination defaults and limits for listing subscriptions
  #
  # Testing assets:
  # * A route within the supported region
  # * A subscription identifier for an existing, active subscription
  # * A subscription identifier that does not exist
  #
  # References to OAS spec schemas refer to schemas specified in predictive-connectivity-data-subscriptions.yaml

  Background: Common subscriptions setup
    Given an environment at "apiRoot"
    And the resource "/predictive-connectivity-data-subscriptions/vwip/subscriptions"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"

  # Happy path scenarios

  @predictive_connectivity_data_subscriptions_01_create_success_scenario
  Scenario: Validate success response for a subscription creation request
    Given the request body is set by default to a request body compliant with the schema at "#/components/schemas/SubscriptionRequest"
    And the request body property "$.config.subscriptionDetail.route" is set to a valid route within the supported regions
    And the request body property "$.config.subscriptionDetail.serviceLevel" is set to a valid communication service level
    When the request "createPredictiveConnectivityDataSubscription" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response property "$.status" value is "ACTIVATION_REQUESTED"

  @predictive_connectivity_data_subscriptions_02_create_with_segment_ids_success_scenario
  Scenario: Validate success response for a subscription creation request scoped to specific segments
    Given the request body is set by default to a request body compliant with the schema at "#/components/schemas/SubscriptionRequest"
    And the request body property "$.config.subscriptionDetail.route" is set to a valid route within the supported regions
    And the request body property "$.config.subscriptionDetail.serviceLevel" is set to a valid communication service level
    And the request body property "$.config.subscriptionDetail.segmentIds" is set to a list of segment identifiers computed from the route waypoint indexes
    When the request "createPredictiveConnectivityDataSubscription" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @predictive_connectivity_data_subscriptions_03_create_async_success_scenario
  Scenario: Validate success response for a subscription creation request handled asynchronously
    Given the request body is set by default to a request body compliant with the schema at "#/components/schemas/SubscriptionRequest"
    And the request body property "$.config.subscriptionDetail.route" is set to a valid route within the supported regions
    And the request body property "$.config.subscriptionDetail.serviceLevel" is set to a valid communication service level
    When the request "createPredictiveConnectivityDataSubscription" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"

  @predictive_connectivity_data_subscriptions_04_list_success_scenario
  Scenario: Validate success response for a list subscriptions request
    When the request "listPredictiveConnectivityDataSubscriptions" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"

  @predictive_connectivity_data_subscriptions_05_retrieve_success_scenario
  Scenario: Validate success response for a retrieve subscription request
    Given the resource "/predictive-connectivity-data-subscriptions/vwip/subscriptions/{subscriptionId}"
    And the path parameter "subscriptionId" is set to the identifier of an existing, active subscription
    When the request "retrievePredictiveConnectivityDataSubscription" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @predictive_connectivity_data_subscriptions_06_delete_success_scenario
  Scenario: Validate success response for a delete subscription request
    Given the resource "/predictive-connectivity-data-subscriptions/vwip/subscriptions/{subscriptionId}"
    And the path parameter "subscriptionId" is set to the identifier of an existing, active subscription
    When the request "deletePredictiveConnectivityDataSubscription" is sent
    Then the response status code is 204
    And the response header "x-correlator" has same value as the request header "x-correlator"

  # Error scenarios

  @predictive_connectivity_data_subscriptions_400.01_area_and_segment_ids_combined
  Scenario: Error 400 when area and segmentIds are both set on the subscription detail
    Given the request body is set by default to a request body compliant with the schema at "#/components/schemas/SubscriptionRequest"
    And the request body property "$.config.subscriptionDetail.route" is set to a valid route within the supported regions
    And the request body property "$.config.subscriptionDetail.serviceLevel" is set to a valid communication service level
    And the request body property "$.config.subscriptionDetail.segmentIds" is set to a list of segment identifiers computed from the route waypoint indexes
    And the request body property "$.config.subscriptionDetail.area" is set to a valid circular area
    When the request "createPredictiveConnectivityDataSubscription" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @predictive_connectivity_data_subscriptions_400.02_missing_route
  Scenario: Error 400 when the request body does not comply with the schema
    Given the request body is not compliant with the OAS schema at "#/components/schemas/SubscriptionRequest"
    When the request "createPredictiveConnectivityDataSubscription" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @predictive_connectivity_data_subscriptions_401.01_invalid_token
  Scenario: Error response for invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set by default to a request body compliant with the schema at "#/components/schemas/SubscriptionRequest"
    When the request "createPredictiveConnectivityDataSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @predictive_connectivity_data_subscriptions_403.01_invalid_token_permissions
  Scenario: Error response for invalid access token permissions
    Given the header "Authorization" is set to a valid access token with insufficient permissions
    And the request body is set by default to a request body compliant with the schema at "#/components/schemas/SubscriptionRequest"
    When the request "createPredictiveConnectivityDataSubscription" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @predictive_connectivity_data_subscriptions_404.01_subscription_not_found
  Scenario: Error 404 when the subscription identifier does not exist
    Given the resource "/predictive-connectivity-data-subscriptions/vwip/subscriptions/{subscriptionId}"
    And the path parameter "subscriptionId" is set to an identifier that does not correspond to any existing subscription
    When the request "retrievePredictiveConnectivityDataSubscription" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
