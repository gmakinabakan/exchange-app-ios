
# ExchangeApp

This is the implementation of the exchange application using the required packages. This application shows a splash screen for 2 seconds and then loads the Welcome screen.

## ExchangeApp.swift

This is where all the dependency injection happens. For each package that we use we create a dependency object and give it as a environment object.

    struct ExchangeApp: App {
    
        @StateObject private var currenciesDependency = CurrenciesDependencyObject(apiList: [CurrencyLocalCache(), FixerRestAPI()], uniqueDataKey: "dc7eb963-c89e-4137-9005-62f6b1e1c7a7")
    
        @StateObject private var welcomeDependency = WelcomeDependencyObject(nextView: AnyView(CurrencyListView()), headerMessage: "Welcome to the currency exchange rate application", captionMessage: "The app, where you can find an exchange rate of the currency that has been added by the developer👌", popupMessage: "We have a lot of new stuff for you", initialDataAPI: FixerRestAPI(), uniqueDataKey: "dc7eb963-c89e-4137-9005-62f6b1e1c7a7")
    
        @StateObject private var dataTransferDependency = DataTransferObservableObject()
    
        var body: some Scene {
            WindowGroup {
                ContentView()
                .environmentObject(currenciesDependency)
                .environmentObject(welcomeDependency)
                .environmentObject(dataTransferDependency)
            }
        }
    }

The properties and logic behind these dependency objects are defined in their respective documentation that you can find in each package's read me files. In this example we are creating the currencies package with two APIs. The first one is a local API. Currency package for now operates with FIFO logic for the API list as described further in the package documentation. So the API uses the local cache initially and the goes to the Fixer Rest API if the cache is empty. From here user can create any API implementation that implements Currency Base API protocol and supply it to the system. Unqie data key is used for getting the right data from the key-value storage, dataTransferDependency.

Data Transfer object is a key value protocol that is used for data ransferring between packages. It can also be used as a memory cache if required however durrently it doesn't support expiring.

Welcome screen dependency object receives the text that will be shown on the screen like header message, caption message and popup message. This package is also responsible for getting initial data and sending this data to the package it will display next. Therefore another API protocol supporting instance is injected. Fixer API package also implements the APIBaseProtocol so that an initial API call can be started from the Welcome screen. The data is inserted to the Data Transfer object with the uniqu key so that the Currency screen can use it as desired.

## ContentView.swift

This view displays a splash screen for 2 seconds and then loads the Welcome View. Also we have a UIKit call in the initializer. 

    init() {
        UITableView.appearance().backgroundColor = UIColor(ApplicationBackgroundColor.backgroundColor)
    }
    
This call makes sure that the table view has the correct background both in light and dark modes.

## Splash Screen

This view is the implementation of splash screen.

## Further Discussions

### Dependency Injection Mechanism

In my solution dependencies are injected through the environment object. I am not really sure this is the best solution esspecially for larger projects. However it served my purpose for this application. One limitation of this approach is currently you cannot use the same package twice with different settings in the same application because the environment object mapping depends on the type. The OS mapping algorithm will always find the same object that matches the type. 

If this injection mechanism stays and we want to support using same packages with different settings, then the dependency object structure should change. Different settings will need to be stored in a dictionary with unique keys. Then each package initial view will be initilized with this unique keys and the package retrieves the right settings from the dependency object's dictionary with the given key.
