import Foundation

public class DataSourceConfiguration {

    public private(set) var cellConfigurations = [String: CellConfiguration<CollectionCell>]()
    
    public init(builder: DataSourceConfiguration.Builder) {
        cellConfigurations = builder.configurations
    }

    public class Builder {

        public var configurations = [String: CellConfiguration<CollectionCell>]()

        public init(build: (Builder) -> Void) {
            build(self)
        }

    }

}
