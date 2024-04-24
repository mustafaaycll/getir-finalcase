//
//  ActionLabel.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 22.04.2024.
//

import UIKit

class ActionLabel: UILabel {

    init() {
        super.init(frame: .zero)
        textColor = Config.Components.Action.Visual.Colors.actionLabelTextColor
        font = Config.Components.Action.Text.Fonts.actionLabelFont
        textAlignment = Config.Components.Action.Text.Alignments.actionLabelAlignment
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
