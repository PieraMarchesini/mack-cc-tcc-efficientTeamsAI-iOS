//
//  Round+ImageView.swift
//  Personality Insights
//
//  Created by Piera Marchesini on 17/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
