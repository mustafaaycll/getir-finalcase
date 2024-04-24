//
//  SectionCollectionReusableView.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 14.04.2024.
//

import UIKit

class SectionCollectionReusableView: UICollectionReusableView {
    
    static let elementKind: String = Config.Components.Section.Text.Texts.elementKindText
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Config.Components.Section.Visual.Colors.viewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
