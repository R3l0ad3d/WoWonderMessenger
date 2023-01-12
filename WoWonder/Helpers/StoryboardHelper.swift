//
//
import UIKit

extension UIStoryboard {
    
    enum Storyboard: String {
        case main = "Main"
        case chat = "Chat"
        case dashboard = "Dashboard"
        case group = "Group"
        case settings = "Settings"
        case favorite = "Favorite"
        case call = "Call"
        case story = "Story"
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}

public enum ViewControllers {
    case mobileNumberViewController
    case loginViewController
    case signUpViewController
}

extension UIViewController: StoryboardIdentifiable {}

// MARK: identifiable
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
    static func getViewController(from storyboard: UIStoryboard.Storyboard) -> Self
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func getViewController(from storyboard: UIStoryboard.Storyboard) -> Self {
        let sB = UIStoryboard(storyboard: storyboard)
        return sB.instantiateViewController()
    }
    
    static func initialize(from storyboard: UIStoryboard.Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self // swiftlint:disable:this force_cast
    }
}
