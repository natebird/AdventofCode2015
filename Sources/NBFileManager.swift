import XCPlayground
import Foundation

public class NBFileManager: NSObject {
    
    private struct Constants {
        static let sharedInstance = NBFileManager()
    }
    
    public class var shared: NBFileManager {
        return Constants.sharedInstance
    }
 
    public func loadStringInputFromResource(fileName: String) -> String {
        var content = ""
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt"),
           let data = NSFileManager.defaultManager().contentsAtPath(path),
           let encoded = String(data: data, encoding: NSUTF8StringEncoding) {
            
            content = encoded
        }
        return content
    }
}
