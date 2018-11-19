//
//  UIImageView.swift
//  DailyFitness
//
//  Created by Nataly Tatarintseva on 11/19/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func loadAsyncFrom(url: String, placeholder: UIImage?) {
        guard let requestURL = URL(string: url) else {
            self.image = placeholder
            return
        }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                if error == nil,  let imageData = data, let imageToPresent = UIImage(data: imageData){
                    self?.image = imageToPresent
                }
            }
            }.resume()
    }
}
