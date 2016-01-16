
import UIKit

class ViewController: UIViewController, PiechartDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var views: [String: UIView] = [:]
        
        var error = Piechart.Slice()
        error.value = 4
        error.color = UIColor.magentaColor()
        error.text = "Error"
        
        var zero = Piechart.Slice()
        zero.value = 6
        zero.color = UIColor.blueColor()
        zero.text = "Zero"
        
        var win = Piechart.Slice()
        win.value = 10
        win.color = UIColor.orangeColor()
        win.text = "Winner"
        
        let piechart = Piechart()
        piechart.delegate = self
        piechart.title = "Service"
        piechart.activeSlice = 2
        piechart.layer.borderWidth = 1
        piechart.slices = [error, zero, win]
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[piechart(==200)]", options: [], metrics: nil, views: views))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setSubtitle(total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value / total * 100))% \(slice.text)"
    }
    
    func setInfo(total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value))/\(Int(total))"
    }


}

