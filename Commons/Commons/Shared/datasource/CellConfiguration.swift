public class CellConfiguration<CELL: CollectionCell> {

    public let reuseIdentifier: String
    public let cellType: CELL.Type

    public init(reuseIdentifier: String, cellType: CELL.Type) {
        self.reuseIdentifier = reuseIdentifier
        self.cellType = cellType
    }

}
