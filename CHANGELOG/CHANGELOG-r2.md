# Changelog PredictiveConnectivityData

<!-- TOC:START -->
## Table of Contents
- [r2.1](#r21)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

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

