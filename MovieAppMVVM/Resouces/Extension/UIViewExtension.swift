//
//  UIViewExtension.swift
//  MovieAppMVVM
//
//  Created by Abhay Chaurasia on 16/06/25.
//

import UIKit
 
extension UIView {
    func round( _ radious: CGFloat = 12) {
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}


extension UIImageView {
    func loadImage(from url: URL?) {
        guard let url = url else {
            self.image = UIImage(systemName: "film")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
    func setImage(with url: URL?) {
          self.sd_setImage(
              with: url,
              placeholderImage: UIImage(systemName: "film"),
              options: [.continueInBackground, .progressiveLoad],
              completed: nil
          )
      }
}
