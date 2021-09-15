
# Common

Common package is designed to include functionality that has the potential to be used in the whole system regardless of the functionality. In this version this package has two main sections.

## Initial API

When we are retrieving data for initializing another package, we would need to call an API. An example of this behaviour is Welcome screen's retrieving currency list and injecting the data to the Currency module. This can be a common bahaviour throughout the system. Therefore I designed this as a protocol to make thie a common generalized bahaviour.

### APIBaseProtocol

    public protocol APIBaseProtocol {
        var baseDelegate: DataSourceBaseProtocol? {get set}
        func initialCall() 
    }

This makes sure that every API that has this initial data injection support defines an initial call and also has the ability to call functions on DataSourceBaseProtocol when it receives the data back.

### DataSourceBaseProtocol

    public protocol DataSourceBaseProtocol {
        func initialDataRetrieved(data: Data)
    }

Whoever utilizes APIBaseProtocol supported API to retrieve data need to implement this protocol to receive the data back. It retrieved the data in Data class to be able to leave the processing details to the target user. In our example its Currencies package. Welcome package just receives the data and send it to the appropriate package through Data Transfer mechanism.

## Data Transfer

In this section, I tried to develop a mechanism to be able to transfer data between packages. I designed this as a generalized key-value storage using a dictionary.

### DataTransferProtocol

    public protocol DataTransferProtocol {
        var uniqueDataKey: String? {get set}
    }

Any class that will use this key value storage needs to implement this protocol. These calsses will be ObservableObject type in general. We make sure that the implementer will have a unqie key in hand trying to read or write to the key-value storage.

### DataTransferObservableObject

    public final class DataTransferObservableObject {
        public var DataDictionary: Dictionary<String, Data> = [String: Data]()
        public  init() {}
    }

This is the implementation of key-value storage. This need to be supplied as an environment object to the project in or der to be used as the key-value storage instance.

## Further Discussion
