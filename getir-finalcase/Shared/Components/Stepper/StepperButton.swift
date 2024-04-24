//
//  StepperButton.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 15.04.2024.
//

import UIKit

class StepperButton: UIButton {
    
    var referenceProduct: Product?
    
    init(withImage image: UIImage?) {
        super.init(frame: .zero)
        backgroundColor = Config.Components.Stepper.Visual.Colors.buttonBackgroundColor
        setImage(image, for: .normal)
        contentEdgeInsets = Config.Components.Stepper.Dimensions.buttonContentInset
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
