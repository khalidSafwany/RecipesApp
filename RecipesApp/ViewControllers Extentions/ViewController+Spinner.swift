//
//  ViewController+Spinner.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/8/21.
//

import Foundation

import Foundation
import UIKit

fileprivate var aView:UIView?


extension UIViewController{
    
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        let ai = UIActivityIndicatorView()
        ai.color = UIColor.black
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func stopSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
    
}
