
import UIKit
import WowonderMessengerSDK

class IntroVC: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var scrollNextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            self.scrollView.delegate = self
        }
    }
    
    var slides:[IntroItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setepUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.pageControl.currentPageIndicatorTintColor = UIColor.mainColor
        self.skipBtn.setTitleColor(UIColor.mainColor, for: .normal)
        self.scrollNextBtn.backgroundColor = UIColor.mainColor
    }
    
    func setepUI() {
        self.skipBtn.setTitle(NSLocalizedString("Skip", comment: ""), for: .normal)
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        let vc = R.storyboard.dashboard.mainNavigationViewController()
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "UserSuggestionVC") as? UserSuggestionVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func moveToNextPressed(_ sender: Any) {
        if scrollNextBtn.titleLabel?.text == NSLocalizedString("Done", comment: ""){
            let vc = R.storyboard.dashboard.mainNavigationViewController()
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        }else{
            scrollToNextSlide()
        }
    }
    
    private func createSlides() -> [IntroItem] {
        
        let slide1:IntroItem = Bundle.main.loadNibNamed("IntroItemView", owner: self, options: nil)?.first as! IntroItem
        slide1.imageLabel.image = UIImage(named: "ic_spl_location")?.withRenderingMode(.alwaysTemplate)
        slide1.imageLabel.tintColor = UIColor.mainColor
        slide1.firstLabel.text = NSLocalizedString("Set your location", comment: "")
        slide1.secondLabel.text =  NSLocalizedString("Set your location so we can tell you where the nearest intresting people are, Discover friends near by.", comment: "")
        
        let slide2:IntroItem = Bundle.main.loadNibNamed("IntroItemView", owner: self, options: nil)?.first as! IntroItem
        slide2.imageLabel.image = UIImage(named: "ic_Chat_spl")?.withRenderingMode(.alwaysTemplate)
        slide2.imageLabel.tintColor = UIColor.mainColor
        slide2.firstLabel.text = NSLocalizedString("Make Group chat", comment: "")
        slide2.secondLabel.text = NSLocalizedString("You are getting boared? start and create a new group and add your friends and contacts and share all your posts from one place.", comment: "")
        
        let slide3:IntroItem = Bundle.main.loadNibNamed("IntroItemView", owner: self, options: nil)?.first as! IntroItem
        slide3.imageLabel.image = UIImage(named: "ic_recoding_access_spl")?.withRenderingMode(.alwaysTemplate)
        slide3.imageLabel.tintColor = UIColor.mainColor
        slide3.firstLabel.text = NSLocalizedString("Recording Access", comment: "")
        slide3.secondLabel.text = NSLocalizedString("Grant us the permission to allow your app to leave voice notes and recorded songs on your news feed comments.", comment: "")
        
        let slide4:IntroItem = Bundle.main.loadNibNamed("IntroItemView", owner: self, options: nil)?.first as! IntroItem
        slide4.imageLabel.image = UIImage(named: "ic_vidoe")?.withRenderingMode(.alwaysTemplate)
        slide4.imageLabel.tintColor = UIColor.mainColor
        slide4.firstLabel.text = NSLocalizedString("Multimedia Files", comment: "")
        slide4.secondLabel.text = NSLocalizedString("Post all kind of images & stickers & videos & document files on your own news feed.", comment: "")
        
        return [slide1, slide2, slide3, slide4]
    }
    
    private func setupSlideScrollView(slides : [IntroItem]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollToNextSlide() {
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        let contentOffset = scrollView.contentOffset;
        
        scrollView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        if pageControl.currentPage == 3 {
            self.skipBtn.isHidden = true
            self.scrollNextBtn.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
        }else {
            self.skipBtn.isHidden = false
            self.scrollNextBtn.setTitle("Next", for: .normal)
        }
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
            
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
