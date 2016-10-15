import UIKit

class MainViewController: UIViewController {
    
    private(set) var data: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try readCSV()
        } catch {
            
        }
        edgesForExtendedLayout = UIRectEdge.None
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let options = ViewPagerOptions()
        let viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.view.frame = self.view.frame
        
        self.addChildViewController(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMoveToParentViewController(self)
   }
    
    func readCSV() throws {
        do {
            
            let lang = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode)!
            var path = "/Users/jihyechoe/Documents/quote/content-en.tsv"

            if lang as! String == "kr" {
                path = "/Users/jihyechoe/Documents/quote/content-kr.tsv"
            }
            let csv = try CSV(name: path, delimiter: NSCharacterSet(charactersInString: "\t"), encoding: NSUTF8StringEncoding)
            
            // Rows
            data = csv.rows
        } catch {
            throw error
        }
    }
}

extension MainViewController: ViewPagerControllerDataSource {
    func numberOfPages() -> Int {
        return 100
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ItemViewController") as! ItemViewController
        vc.itemText = data[position]["text"]
        vc.authorText = data[position]["author"]
        vc.numberText = "\(position+1)"
        return vc
    }
}

extension MainViewController: ViewPagerControllerDelegate {
    func willMoveToViewControllerAtIndex(index:Int) {

    }
    
    func didMoveToViewControllerAtIndex(index:Int) {

    }
}