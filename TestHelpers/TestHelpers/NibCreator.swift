import UIKit

public class NibCreator {

    public class func createNib(ofClass aClass: AnyClass) -> UIView? {
        let nibName: String = NSStringFromClass(aClass).components(separatedBy: ".").last! as String
        let bundle = Bundle(for: aClass)
        let nib: UINib = UINib(nibName: nibName, bundle: bundle)
        let view: UIView? = nib.instantiate(withOwner: nil, options: nil).first as? UIView
        return view
    }

}
