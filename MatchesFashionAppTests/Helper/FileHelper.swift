import Foundation

class FileHelper {

    func createData(from filename: String, ofType: String) -> Data? {
        do {
            let bundle: Bundle = Bundle(for: type(of: self))
            if let url: URL = bundle.url(forResource: filename, withExtension: ofType) {
                return try Data(contentsOf: url, options: NSData.ReadingOptions.init(rawValue: 0))
            }
        } catch {
        }
        return nil
    }

}
