## 0.27.0

- Fix #1: Remove :invalid trait
- Fix #2: Use url_for(action: :index) for cancel button on forms
- Use url_for for new action on index

## 0.26.1

- Remove RSpec formatter as this was a TFG thing for our CI server.

## 0.26.0

- Remove controller specs. They're stupid.

## 0.25.0

- Update to ruby to 2.5.0
- Update to latest version of Rails 4
- Fix #118: Ensure booleans are compared to true in feature specs
- Fix #146: Handle cases where soft delete is false in delete specs
- Fix #161: Check for flash when destroying a record

## 0.24.2

- Create absolute paths from relative paths when finding template overrides

## 0.24.1

- Use syntax consistent with README for template overrides

## 0.24.0

- Can override templates
- Remove autofocus in forms
- Large code clean up

## 0.23.0

- Fix #130: Line up factory output
- Fix #140, #151: Use human readable names in specs
- Fix #145: Use diff assertion when soft delete is off

## 0.22.0

- Add support for fax and surname factory fields
- Use Lorem.sentence for a default (over FFaker::Company.bs)
- Fix #131: Correctly setup nested models in controllers

## 0.21.0

- Fix #139: Remove extra WS

- Fix flash messages

## 0.20.0

- Remove superfluous comments from feature specs
- Fix #134: Don't select fields that shouldn't be on form
- Fix #129: Add alerts in feature specs
- Fix #132: Feature specs generate nested resources correctly

## 0.19.1

- Fix #127: Remove duplicate subject block
- Fix #128: Use params.fetch instead of params.require
- Fix #46: No more duplicate routes in top level namespace
- Fix reference to #sortable

## 0.19.0

- Feature: Add support for first/last name in factories
- Remove some superfluous comments from controller specs
- Feature: Add support for 'hide_on_form' property on models
- Order attributes alphabetically where possible
- Feature: Add support for 'sortable' property on attributes and associations

## 0.18.0

- Feature: Support nested models in find methods in controllers
- Feature #119: Provide strong params

## 0.17.0

- Feature #96: Support scope argument in uniqueness validation
- Bug Fix #112: Don't use ivar @whatever in nested routes in specs
- Feature #111: Use build strategy in factories
- By default, don't order in controller index action

## 0.16.0

- Feature: Add partial support for nested objects with new controller_prefixes argument

## 0.15.0

- Bug Fix: Fix typo in spec for validating uniqueness
- Bug Fix: Pass local variables through for authorization in index
- Feature: Add support for inline forms
- Feature: Add a call to action to the 'no results message'
- Feature: Improve the 'no results message'
- Bug Fix: Only show actions %td if there are some actions on the index

## 0.14.0

Code refactoring only

## 0.13.0

- Feature: Add authorization option with support for CanCanCan and Pundit

## 0.12.0

- Feature: Add skip_model and skip_factory options

## 0.11.0

- Feature: Add skip_policy option

# 0.10.0

- Feature: Don't show new, edit, or delete actions when they are disabled
- Feature: Numericality validations will effect the output factories
- Feature: Nicer assertions in delete specs
