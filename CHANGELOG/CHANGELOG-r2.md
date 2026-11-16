# Changelog PredictiveConnectivityData

<!-- TOC:START -->
## Table of Contents
- **[r2.3](#r23)**
- [r2.2](#r22)
- [r2.1](#r21)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r2.3

## Release Notes

This public release contains the definition and documentation of
* predictive-connectivity-data 0.2.0

The API definition(s) are based on
* Commonalities r4.4 (0.9.0)
* Identity and Consent Management r4.2 (0.5.0)

## predictive-connectivity-data 0.2.0

**predictive-connectivity-data 0.2.0 is an initial public version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PredictiveConnectivityData/r2.3/code/API_definitions/predictive-connectivity-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PredictiveConnectivityData/r2.3/code/API_definitions/predictive-connectivity-data.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PredictiveConnectivityData/blob/r2.3/code/API_definitions/predictive-connectivity-data.yaml)

### Breaking changes

* Add the `422` error `PREDICTIVE_CONNECTIVITY_DATA.UNSUPPORTED_SERVICE_LEVEL`: an API provider may now reject the service levels `C2` and `STREAM_4K`, which version 0.1.0 accepted without restriction, by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/50
* Add the `422` error `PREDICTIVE_CONNECTIVITY_DATA.UNSUPPORTED_ASYNC_RESPONSE`: an API provider that does not support asynchronous processing now rejects requests that include `sink`, which version 0.1.0 always answered with a callback, by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/78

### Added

* Add the `BEST_EFFORT` service level, which provides no specific service level guarantee by @eric-murray in https://github.com/camaraproject/PredictiveConnectivityData/pull/27
* Add optional `GEOHASHLIST` area type (reusable `GeohashList` and `Geohash` schemas), aligned with Population Density Data. Add the `422` errors `PREDICTIVE_CONNECTIVITY_DATA.UNSUPPORTED_AREA_TYPE` and `PREDICTIVE_CONNECTIVITY_DATA.UNSUPPORTED_SERVICE_LEVEL`, and restrict `precision` to `POLYGON` requests only (using it with `GEOHASHLIST` returns `400 INVALID_ARGUMENT`) by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/50
* Add the `PRIVATE_KEY_JWT` sink credential type, which requires a JWK Set pre-configured during onboarding, and the `422 PRIVATE_KEY_JWT_NOT_CONFIGURED` error returned when none is configured. The API never returns `sinkCredential`, so the provider's `jwksUri` is not conveyed in any response, by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/50 and https://github.com/camaraproject/PredictiveConnectivityData/pull/74
* Add Gherkin test scenarios for `GEOHASHLIST` (supported, partially supported and unsupported areas), the new `422` errors and general request validation, and update the existing scenarios to be area-type agnostic and to accept `BEST_EFFORT` by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/63
* Add test coverage for the `PRIVATE_KEY_JWT` sink credential and for the `422 PRIVATE_KEY_JWT_NOT_CONFIGURED` error by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/76

### Changed

* Align the API definition with Commonalities 0.9.0 (r4.4) by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/50 and https://github.com/camaraproject/PredictiveConnectivityData/pull/78, and by @eric-murray in https://github.com/camaraproject/PredictiveConnectivityData/pull/57 and https://github.com/camaraproject/PredictiveConnectivityData/pull/60
  * Use the common error responses and the common `Sink` and `SinkCredential` schemas
  * Add the `422 PREDICTIVE_CONNECTIVITY_DATA.UNSUPPORTED_ASYNC_RESPONSE` error for implementations that cannot answer asynchronously (see Breaking changes)
  * Reject request bodies with undeclared properties with `400 INVALID_ARGUMENT` (request body strictness)
  * Request inputs carry explicit length limits: `x-correlator` (256 characters), `startTime` and `endTime` (64), `sink` (2048); `precision` and `height` are declared as `int32` within their existing ranges. No request that conforms to the documented semantics is rejected
  * Responses carry explicit size limits: at most 168 time slots, 10000 cells per time slot and 100 layers per cell; `statusInfo` has at most 512 characters, and `requestedHeight` is an `int32` between 0 and 250
* Apply the r2.2 review findings: restructure the API description into shorter points with extra terminology definitions, rename the local schemas `Area`, `AreaType` and `Polygon` to `GeoArea`, `GeoAreaType` and `GeoPolygon` to avoid clashes with CAMARA common data types, and rename `ResponseStatus` to `ResponseQualityInfo` to separate data quality information from error responses by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/87
* Reword the Predictive Connectivity Data user story to reflect the latest API changes, with no functional change by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/43

### Fixed

* Add the missing type definition to the `CellConnectivityData` schema, which would otherwise fail CAMARA validation by @eric-murray in https://github.com/camaraproject/PredictiveConnectivityData/pull/58
* Fix the test definitions that wrongly required each returned time interval to lie strictly inside the requested range. The intervals must cover the requested range, so the first one may start earlier and the last one may end later by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/46

### Removed

* Remove the generic `404` response from `POST /retrieve` by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/78
* Remove the `QUOTA_EXCEEDED` code from the `429` response, following Commonalities 0.9.0, by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/78
* Remove the `PLAIN` and `REFRESHTOKEN` values of `sinkCredential.credentialType`, which version 0.1.0 already did not allow (it required `ACCESSTOKEN`), by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/50

**Full Changelog**: https://github.com/camaraproject/PredictiveConnectivityData/compare/r1.2...r2.3

# r2.2

## Release Notes

This release candidate contains the definition and documentation of
* predictive-connectivity-data 0.2.0-rc.2

The API definition(s) are based on
* Commonalities r4.4 (0.9.0)
* Identity and Consent Management r4.2 (0.5.0)

## predictive-connectivity-data 0.2.0-rc.2

**predictive-connectivity-data 0.2.0-rc.2 is a release-candidate version of this API.**

Changes documented below are compared to version 0.2.0-rc.1.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PredictiveConnectivityData/r2.2/code/API_definitions/predictive-connectivity-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PredictiveConnectivityData/r2.2/code/API_definitions/predictive-connectivity-data.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PredictiveConnectivityData/blob/r2.2/code/API_definitions/predictive-connectivity-data.yaml)

### Breaking changes

* Fix Release r2.1 issues by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/74
  * Add new error response code 422 PRIVATE_KEY_JWT_NOT_CONFIGURED
* Align Predictive Connectivity Data with Commonalities 0.9.0 (r4.4) by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/78
  * Add new error response code 422 PREDICTIVE_CONNECTIVITY_DATA.UNSUPPORTED_ASYNC_RESPONSE
  

### Added

* Add test coverage for `PRIVATE_KEY_JWT` sink credential and `422 PRIVATE_KEY_JWT_NOT_CONFIGURED` by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/76

### Changed

* Restructure API inline documentation (#84), rename local schemas to avoid clashes with CAMARA common types (`Area` → `GeoArea`, etc.) (#85), and rename `ResponseStatus` to `DataQualityInfo` to clarify data quality vs. HTTP error semantics (#86) by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/87
* Align Predictive Connectivity Data with Commonalities 0.9.0 (r4.4) by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/78

### Fixed

* Fix typos in feature file (#68), contradictory description of supported `sinkCredential.credentialType` values (#69), and `jwksUri` never returned for `PRIVATE_KEY_JWT` sink credentials (#70) by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/74

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/PredictiveConnectivityData/compare/r2.1...r2.2

# r2.1

## Release Notes

This release candidate contains the definition and documentation of
* predictive-connectivity-data 0.2.0-rc.1

The API definition(s) are based on
* Commonalities 0.8.0
* Identity and Consent Management 0.5.0

## predictive-connectivity-data 0.2.0-rc.1

**predictive-connectivity-data 0.2.0-rc.1 is a release-candidate version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PredictiveConnectivityData/r2.1/code/API_definitions/predictive-connectivity-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PredictiveConnectivityData/r2.1/code/API_definitions/predictive-connectivity-data.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PredictiveConnectivityData/blob/r2.1/code/API_definitions/predictive-connectivity-data.yaml)

### Breaking changes

* N/A

### Added

* Add "Best Effort" Service Level by @eric-murray in https://github.com/camaraproject/PredictiveConnectivityData/pull/27
* Add type definition for CellConnectivityData by @eric-murray in https://github.com/camaraproject/PredictiveConnectivityData/pull/58
* Add Sync26 new changes (Geohashlist+Commonalities & ICM) by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/50

### Changed

* Update README.md according to new meeting cadence by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/41
* Update User Story for Predictive Connectivity Data by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/43
* Update API definition to fix CAMARA validation warnings and hints by @eric-murray in https://github.com/camaraproject/PredictiveConnectivityData/pull/60
* Updates the Gherkin test definitions by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/63

### Fixed

* Fix incorrect ATP time-range assertions by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/46

### Removed

* Remove API-Readiness-Checklist.md by @albertoramosmonagas in https://github.com/camaraproject/PredictiveConnectivityData/pull/62

**Full Changelog**: https://github.com/camaraproject/PredictiveConnectivityData/compare/r1.2...r2.1

