import Foundation

public class FileHelper {


    public func createData(from filename: String, fileExtension: String) -> Data? {
        do {
            let bundle: Bundle = Bundle(for: FileHelper.self)
            if let url: URL = bundle.url(forResource: filename, withExtension: fileExtension) {
                return try Data(contentsOf: url, options: NSData.ReadingOptions.init(rawValue: 0))
            }
        } catch {
        }
        return nil
    }

}
