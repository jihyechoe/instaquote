import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    var authorText: String?
    var itemText: String?
    var numberText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = numberText!
        numberLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 50.0)
        numberLabel.textColor = UIColor(white:0.2, alpha:1.0)
        
        itemLabel.text = itemText!
        itemLabel.font = UIFont(name: "Avenir-Medium", size: 20.0)
        itemLabel.textColor = UIColor(white:0.2, alpha:1.0)

        authorLabel.text = authorText!
        authorLabel.font = UIFont(name: "Avenir-Book", size: 20.0)
        authorLabel.textColor = UIColor(white:0.55, alpha:1.0)
        
        /* let lang = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode)!
        if lang as! String == "en" {
            kakaotalk.hidden = true;
        } */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
