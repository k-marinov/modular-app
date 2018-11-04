
# Modular App

## Developer Prerequisites

### macOS Mojave

10.14

### Xcode

Xcode Version  Version 10.0 (10A255)

### Swift

Apple Swift version 4.2 (swiftlang-1000.11.37.1 clang-1000.11.45.1)

### Deployment Target 

iOS 10.0

## TEST COVERAGE

96% of the classes are tested, including all the resources, services, view models, routers and view controllers.
There are also http mock tests for http requests done by the services.

## App Architecture

**MVVM** with Routers and layered service architecture. Dependency injection with Creator (Service Locator Pattern) for services and routers.

Main components of MVVM with Routers and Services architecture are

• Router - Navigation

• ViewController - Views

• ViewModel - Model for view controller / Views

• Creator - Dependency injection for view model, services, routers

• Service - Handle business logic, make api request, read write to disk

• Repository / DAO   -  Class or protocol for CRUD operations on local storage (if needed)

• Request - API request that holds the http method type, API response and resource 

• Response - it holds the success logic for the request

• Resource - equivalent DTO of JSON object


## Modular App Drilldown of the classes

**• App**

- AppDelegate 

- AppRouter


**• Product**

- ProductRouter

- ProductsViewController

- ProductsViewModel

- ProductService

- ProductsRequest

- ProductsResource

- PriceResource

- ProductCellRepresentable

**• Exchange Rate**

- Currency

- ExchangeRateRequest

- ExchangeRateResource

- CurrencyExchangeRateResource


## Dependencies


**RxSwift / RxCocoa**

• Concurrency 

• Binding ui 

• Functional reactive programming style

• Allows easy testing capabilities 

• It enables developer to write more immutable style of coding

**OHTTPStubs**

• For stubbing your network requests

• It enables complex scenarios to be tested in isolation.

• Useful for testing your service layer.

**Kingfisher**

• Image caching

**SwiftyJSON**

• JSON mapping

• Easy to use for payloads where there are lots nested objects.
