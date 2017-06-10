
import UIKit


public protocol PiechartDelegate {
    func setSubtitle(_ total: CGFloat, slice: Piechart.Slice) -> String
    func setInfo(_ total: CGFloat, slice: Piechart.Slice) -> String
}



/**
 * Piechart
 */
open class Piechart: UIControl {
    
    /**
     * Slice
     */
    public struct Slice {
        public var color: UIColor!
        public var value: CGFloat!
        public var text: String!
    }
    
    /**
     * Radius
     */
    public struct Radius {
        public var inner: CGFloat = 40
        public var outer: CGFloat = 60
    }
    
    /**
     * private
     */
    fileprivate var titleLabel: UILabel!
    fileprivate var subtitleLabel: UILabel!
    fileprivate var infoLabel: UILabel!
    fileprivate var total: CGFloat!
    
    
    /**
     * public
     */
    open var radius: Radius = Radius()
    open var activeSlice: Int = 0
    open var delegate: PiechartDelegate?
    
    open var title: String = "title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    open var subtitle: String = "subtitle" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    open var info: String = "info" {
        didSet {
            infoLabel.text = info
        }
    }
    
    open var slices: [Slice] = [] {
        didSet {
            total = 0
            for slice in slices {
                total = slice.value + total
            }
        }
    }
    
    
    
    /**
     * methods
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.addTarget(self, action: #selector(Piechart.click), for: .touchUpInside)
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        subtitleLabel.textColor = UIColor.gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subtitleLabel)
        
        infoLabel = UILabel()
        infoLabel.text = subtitle
        infoLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        infoLabel.textColor = UIColor.gray
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(infoLabel)
        
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: subtitleLabel, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)

        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        var startValue: CGFloat = 0
        var startAngle: CGFloat = 0
        var endValue: CGFloat = 0
        var endAngle: CGFloat = 0
        
        for (index, slice) in slices.enumerated() {
            
            startAngle = (startValue * 2 * CGFloat(Double.pi)) - CGFloat(Double.pi / 2)
            endValue = startValue + (slice.value / self.total)
            endAngle = (endValue * 2 * CGFloat(Double.pi)) - CGFloat(Double.pi / 2)
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius.outer, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            var color = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
            if (index == activeSlice) {
                color = slice.color
                subtitle = delegate?.setSubtitle(self.total, slice: slice) ?? "subtitle"
                info = delegate?.setInfo(self.total, slice: slice) ?? "info"
            }
            color.setFill()
            path.fill()
            
            // add white border to slice
            UIColor.white.setStroke()
            path.stroke()
            
            // increase start value for next slice
            startValue += slice.value / self.total
        }
        
        // create center donut hole
        let innerPath = UIBezierPath()
        innerPath.move(to: center)
        innerPath.addArc(withCenter: center, radius: radius.inner, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        UIColor.white.setFill()
        innerPath.fill()
    }
    
    func click() {
        activeSlice += 1
        if activeSlice >= slices.count {
            activeSlice = 0
        }
        setNeedsDisplay()
    }
    
    
}
