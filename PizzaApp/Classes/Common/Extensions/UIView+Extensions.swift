//
//  UIView+Extensions.swift
//  PizzaApp
//
//  Created by TungImac on 10/31/20.
//  Copyright © 2020 TungImac. All rights reserved.
//
import UIKit
extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    
    get{
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    set {
      layer.borderColor = borderColor?.cgColor
    }
  }
  
  class func fromNib<T: UIView>() -> T {
    return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
}
public protocol NibInstantiatable {
  
  static func nibName() -> String
  
}

extension NibInstantiatable {
  
  static func nibName() -> String {
    return String(describing: self)
  }
  
}

extension NibInstantiatable where Self: UIView {
  
  static func fromNib() -> Self {
    
    let bundle = Bundle(for: self)
    let nib = bundle.loadNibNamed(nibName(), owner: self, options: nil)
    
    return nib!.first as! Self
    
  }
  
}
// MARK: Blur
extension UIView {
  
  private struct AssociatedKeys {
    static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
  }
  
  private (set) var blurView: BlurView {
    get {
      if let blurView = objc_getAssociatedObject(
        self,
        &AssociatedKeys.descriptiveName
      ) as? BlurView {
        return blurView
      }
      self.blurView = BlurView(to: self)
      return self.blurView
    }
    set(blurView) {
      objc_setAssociatedObject(
        self,
        &AssociatedKeys.descriptiveName,
        blurView,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }
  
  class BlurView {
    
    private var superview: UIView
    private var blur: UIVisualEffectView?
    private var editing: Bool = false
    private (set) var blurContentView: UIView?
    private (set) var vibrancyContentView: UIView?
    
    var animationDuration: TimeInterval = 0.1
    
    /**
     * Blur style. After it is changed all subviews on
     * blurContentView & vibrancyContentView will be deleted.
     */
    var style: UIBlurEffect.Style = .light {
      didSet {
        guard oldValue != style,
              !editing else { return }
        applyBlurEffect()
      }
    }
    /**
     * Alpha component of view. It can be changed freely.
     */
    var alpha: CGFloat = 0 {
      didSet {
        guard !editing else { return }
        if blur == nil {
          applyBlurEffect()
        }
        let alpha = self.alpha
        UIView.animate(withDuration: animationDuration) {
          self.blur?.alpha = alpha
        }
      }
    }
    
    init(to view: UIView) {
      self.superview = view
    }
    
    func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
      self.editing = true
      
      self.style = style
      self.alpha = alpha
      
      self.editing = false
      
      return self
    }
    
    func enable(isHidden: Bool = false) {
      if blur == nil {
        applyBlurEffect()
      }
      
      self.blur?.isHidden = isHidden
    }
    
    private func applyBlurEffect() {
      blur?.removeFromSuperview()
      
      applyBlurEffect(
        style: style,
        blurAlpha: alpha
      )
    }
    
    private func applyBlurEffect(style: UIBlurEffect.Style,
                                 blurAlpha: CGFloat) {
      superview.backgroundColor = UIColor.clear
      
      let blurEffect = UIBlurEffect(style: style)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      
      let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
      let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
      blurEffectView.contentView.addSubview(vibrancyView)
      
      blurEffectView.alpha = blurAlpha
      
      superview.insertSubview(blurEffectView, at: 0)
      
      blurEffectView.addAlignedConstrains()
      vibrancyView.addAlignedConstrains()
      
      self.blur = blurEffectView
      self.blurContentView = blurEffectView.contentView
      self.vibrancyContentView = vibrancyView.contentView
    }
  }
  
  private func addAlignedConstrains() {
    translatesAutoresizingMaskIntoConstraints = false
    addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
    addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
    addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
    addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
  }
  
  private func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
    superview?.addConstraint(
      NSLayoutConstraint(
        item: self,
        attribute: attribute,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: superview,
        attribute: attribute,
        multiplier: 1,
        constant: 0
      )
    )
  }
}
// MARK: Safe area height
extension UIView {
  var safeAreaBottom : CGFloat {
    if #available(iOS 11, *){
      let window = UIApplication.shared.keyWindow;
      return window?.safeAreaInsets.bottom ?? 0;
    }
    return 0;
  }
  
  var safeAreaTop : CGFloat {
    if #available(iOS 11, *){
      let window = UIApplication.shared.keyWindow;
      return window?.safeAreaInsets.top ?? 0;
    }
    return 0;
  }
  static var identifier: String {
    return String(describing: self)
  }
}
