//
//  ActionButton.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 22.04.2024.
//

import UIKit

class ActionButton: UIButton {

    init() {
        super.init(frame: .zero)
        backgroundColor = Config.Components.Action.Visual.Colors.actionButtonBackgroundColor
        titleLabel?.font = Config.Components.Action.Text.Fonts.actionButtonFont
        titleLabel?.textColor = Config.Components.Action.Visual.Colors.actionButtonTextColor
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
