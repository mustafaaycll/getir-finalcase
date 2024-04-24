//
//  Config.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 12.04.2024.
//

import UIKit

struct Config {
    
    struct General {
        struct Visual {
            struct Images {}
            
            struct ContentModes {}
            
            struct Colors {
                static let navbarBackgroundColor = UIColor(named: "DarkPurple")
                static let navbarTextColor = UIColor(named: "White")
            }
            
            struct Decorations {}
        }
        
        struct Text {
            struct Texts {}
            
            struct Fonts {}
            
            struct Alignments {}
        }
        
        struct Dimensions {}
    }
    
    struct Modules {
        struct Home {
            struct Visual {
                struct Images {}
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                    static let collectionBackgroundColor = UIColor(named: "LightPurple")
                }
                
                struct Decorations {
                    static let suggestionSectionDecorationItems = [
                        NSCollectionLayoutDecorationItem.background(
                            elementKind: SectionCollectionReusableView.elementKind
                        )
                    ]
                    static let productSectionDecorationItems = [
                        NSCollectionLayoutDecorationItem.background(
                            elementKind: SectionCollectionReusableView.elementKind
                        )
                    ]
                }
            }
            
            struct Text {
                struct Texts {
                    static let moduleTitleText: String = "Ürünler"
                    static let suggestionSectionCellReuseIdentifierText: String = "suggestionTileCell"
                    static let productSectionCellReuseIdentifierText: String = "productTileCell"
                }
                
                struct Fonts {}
                
                struct Alignments {}
            }
            
            struct Dimensions {
                static let collectionContentInset: UIEdgeInsets = .init(top: 16, left: 0, bottom: 0, right: 0)
                static let collectionInterSectionSpacing: CGFloat = 16
                
                static let suggestionSectionItemWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
                static let suggestionSectionItemHeight: NSCollectionLayoutDimension = .fractionalHeight(1)
                static let suggestionSectionGroupWidth: NSCollectionLayoutDimension = .absolute(120)
                static let suggestionSectionGroupHeight: NSCollectionLayoutDimension = .absolute(180)
                
                static let productsSectionItemCountPerRow: Int = 3
                static let productSectionItemWidth: NSCollectionLayoutDimension = .fractionalWidth(1/3)
                static let productSectionItemHeight: NSCollectionLayoutDimension = .fractionalHeight(1)
                static let productSectionGroupWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
                static let productSectionGroupHeight: NSCollectionLayoutDimension = .absolute(200)
            }
        }
        
        struct Basket {
            struct Visual {
                struct Images {
                    static let trashImage: UIImage = UIImage(named: "WhiteTrash")!
                }
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                    static let collectionBackgroundColor = UIColor(named: "LightPurple")
                }
                
                struct Decorations {
                    static let basketSectionDecorationItems = [
                        NSCollectionLayoutDecorationItem.background(
                            elementKind: SectionCollectionReusableView.elementKind
                        )
                    ]
                    static let suggestionSectionDecorationItems = [
                        NSCollectionLayoutDecorationItem.background(
                            elementKind: SectionCollectionReusableView.elementKind
                        )
                    ]
                }
            }
            
            struct Text {
                struct Texts {
                    static let moduleTitleText: String = "Sepetim"
                    static let moduleActionText: String = "Siparişi Tamamla"
                    static let basketSectionCellReuseIdentifierText: String = "basketTileCell"
                    static let suggestionSectionCellReuseIdentifierText: String = "suggestionTileCell"
                }
                
                struct Fonts {}
                
                struct Alignments {}
            }
            
            struct Dimensions {
                static let collectionContentInset: UIEdgeInsets = .init(top: 16, left: 0, bottom: 0, right: 0)
                static let collectionInterSectionSpacing: CGFloat = 16
                
                static let basketSectionItemWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
                static let basketSectionItemHeight: NSCollectionLayoutDimension = .fractionalHeight(1)
                static let basketSectionGroupWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
                static let basketSectionGroupHeight: NSCollectionLayoutDimension = .absolute(100)
                
                static let suggestionSectionItemWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
                static let suggestionSectionItemHeight: NSCollectionLayoutDimension = .fractionalHeight(1)
                static let suggestionSectionGroupWidth: NSCollectionLayoutDimension = .absolute(120)
                static let suggestionSectionGroupHeight: NSCollectionLayoutDimension = .absolute(180)
            }
        }
        
        struct Detail {
            
            struct Visual {
                struct Images {}
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "LightPurple")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {
                    static let moduleTitleText: String = "Ürün Detayı"
                    static let moduleActionText: String = "Sepete Ekle"
                }
                
                struct Fonts {}
                
                struct Alignments {}
            }
            
            struct Dimensions {
                static let productDetailTopPadding: CGFloat = 16
            }
        }
    }
    
    struct Components {
        
        struct Action {
            struct Visual {
                struct Images {}
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "LightPurple")
                    static let actionButtonBackgroundColor = UIColor(named: "DarkPurple")
                    static let actionButtonTextColor = UIColor(named: "White")
                    static let actionLabelTextColor = UIColor(named: "DarkPurple")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {
                    static let actionButtonFont: UIFont = UIFont.boldSystemFont(ofSize: 14)
                    static let actionLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
                }
                
                struct Alignments {
                    static let actionLabelAlignment: NSTextAlignment = .center
                }
            }
            
            struct Dimensions {
                static let actionButtonWidthMultiplierWhenNoInfo: CGFloat = 100/100
                static let actionButtonWidthMultiplierWhenWithInfo: CGFloat = 65/100
            }
        }
        
        struct BasketIndicator {
            struct Visual {
                struct Images {
                    static let bagImage: UIImage = UIImage(named: "Bag")!
                }
                
                struct ContentModes {
                    static let imageContentMode: UIView.ContentMode = .scaleAspectFill
                }
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                    static let imageBackgroundColor = UIColor(named: "White")
                    static let priceContainerBackgroundColor = UIColor(named: "LightPurple")
                    static let priceTextColor = UIColor(named: "DarkPurple")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {
                    static let priceLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
                }
                
                struct Alignments {
                    static let priceLabelAlignment: NSTextAlignment = .center
                }
            }
            
            struct Dimensions {
                static let cornerRadius: CGFloat = 8
                static let width: CGFloat = 100
                static let height: CGFloat = 30
                static let imageViewLeadingPadding: CGFloat = 8
                static let imageViewTopPadding: CGFloat = 8
                static let imageViewTrailingPadding: CGFloat = -8
                static let imageViewBottomPadding: CGFloat = -8
            }
        }
        
        struct BasketTile {
            struct Visual {
                struct Images {}
                
                struct ContentModes {
                    static let productImageContentMode: UIView.ContentMode = .scaleAspectFill
                }
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                    static let containerBackgroundColor = UIColor(named: "White")
                    static let imageBorderColor = UIColor(named: "LightPurple")
                    static let priceTextColor = UIColor(named: "DarkPurple")
                    static let titleTextColor = UIColor(named: "Black")
                    static let attrTextColor = UIColor(named: "Gray")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {
                    static let priceLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
                    static let titleLabelFont: UIFont = UIFont.systemFont(ofSize: 10)
                    static let attrLabelFont: UIFont = UIFont.systemFont(ofSize: 10)
                }
                
                struct Alignments {
                    static let priceLabelAlignment: NSTextAlignment = .left
                    static let titleLabelAlignment: NSTextAlignment = .left
                    static let attrLabelAlignment: NSTextAlignment = .left
                }
                
                struct Properties {
                    static let titleLabelNumberOfLines: Int = 2
                }
            }
            
            struct Dimensions {
                static let imageCornerRadius: CGFloat = 16
                static let imageBorderWidth: CGFloat = 2
                
                static let containerViewLeadingPadding: CGFloat = 8
                static let containerViewTopPadding: CGFloat = 8
                static let containerViewTrailingPadding: CGFloat = -8
                static let containerViewBottomPadding: CGFloat = -8
                
                static let labelWidthToContainerWidthRatio: CGFloat = 50/100
                static let horizontalStepperHeigthToViewHeigthRatio: CGFloat = 1/3
                
                static let titleLabelTopPadding: CGFloat = 4
                static let titleLabelLeadingPadding: CGFloat = 4
                
                static let attrLabelTopPadding: CGFloat = 4
                static let attrLabelLeadingPadding: CGFloat = 4
                
                static let priceLabelTopPadding: CGFloat = 4
                static let priceLabelLeadingPadding: CGFloat = 4
            }
        }
        
        struct BottomBar {
            struct Visual {
                struct Images {}
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {}
                
                struct Alignments {}
            }
            
            struct Dimensions {
                static let containerCornerRadius: CGFloat = 16
                static let widthToScreenHeightRatio: CGFloat = 15/100
                
                static let containerViewLeadingPadding: CGFloat = 16
                static let containerViewTopPadding: CGFloat = 16
                static let containerViewTrailingPadding: CGFloat = -16
                static let containerViewBottomPadding: CGFloat = -16
                
                static let stretchedViewWidthToContainerWidthRatio: CGFloat = 1
                static let unstretchedViewWidthToContainerWidthRatio: CGFloat = 0.5
            }
        }
        
        struct IconBarButton {
            struct Visual {
                struct Images {}
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor: UIColor = .clear
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {}
                
                struct Alignments {}
            }
            
            struct Dimensions {
                static let cornerRadius: CGFloat = 8
                static let width: CGFloat = 30
                static let height: CGFloat = 30
                
                static let imageViewLeadingPadding: CGFloat = 4
                static let imageViewTopPadding: CGFloat = 4
                static let imageViewTrailingPadding: CGFloat = -4
                static let imageViewBottomPadding: CGFloat = -4
            }
        }
        
        struct ProductDetail {
            struct Visual {
                struct Images {}
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                    
                    static let priceTextColor = UIColor(named: "DarkPurple")
                    static let titleTextColor = UIColor(named: "Black")
                    static let attrTextColor = UIColor(named: "Gray")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {
                    static let priceLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 18)
                    static let titleLabelFont: UIFont = UIFont.systemFont(ofSize: 14)
                    static let attrLabelFont: UIFont = UIFont.systemFont(ofSize: 14)
                }
                
                struct Alignments {
                    static let priceLabelAlignment: NSTextAlignment = .center
                    static let titleLabelAlignment: NSTextAlignment = .center
                    static let attrLabelAlignment: NSTextAlignment = .center
                }
                
                struct Properties {
                    static let titleLabelNumberOfLines: Int = 2
                }
            }
            
            struct Dimensions {
                static let imageHeightToViewHeightRatio: CGFloat = 2/3
                static let priceLabelWidthtoViewWidthRatio: CGFloat = 90/100
                static let titleLabelWidthtoViewWidthRatio: CGFloat = 90/100
                static let attrLabelWidthtoViewWidthRatio: CGFloat = 90/100
                
                static let priceLabelTopPadding: CGFloat = 8
                static let titleLabelTopPadding: CGFloat = 4
                static let attrLabelTopPadding: CGFloat = 4
                
            }
        }
        
        struct ProductTile {
            struct Visual {
                struct Images {}
                
                struct ContentModes {
                    static let productImageContentMode: UIView.ContentMode = .scaleAspectFill
                }
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                    static let containerBackgroundColor = UIColor(named: "White")
                    static let defaultImageBorderColor = UIColor(named: "LightPurple")
                    static let highlightedImageBorderColor = UIColor(named: "DarkPurple")
                    
                    static let priceTextColor = UIColor(named: "DarkPurple")
                    static let titleTextColor = UIColor(named: "Black")
                    static let attrTextColor = UIColor(named: "Gray")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {
                    static let priceLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
                    static let titleLabelFont: UIFont = UIFont.systemFont(ofSize: 10)
                    static let attrLabelFont: UIFont = UIFont.systemFont(ofSize: 10)
                }
                
                struct Alignments {
                    static let priceLabelAlignment: NSTextAlignment = .left
                    static let titleLabelAlignment: NSTextAlignment = .left
                    static let attrLabelAlignment: NSTextAlignment = .left
                }
                
                struct Properties {
                    static let titleLabelNumberOfLines: Int = 2
                }
            }
            
            struct Dimensions {
                static let imageCornerRadius: CGFloat = 16
                static let imageBorderWidth: CGFloat = 2
                
                static let stepperWidthToViewWidthRatio: CGFloat = 30/100
                
                static let containerViewLeadingPadding: CGFloat = 10
                static let containerViewTopPadding: CGFloat = 10
                static let containerViewTrailingPadding: CGFloat = -10
                
                static let priceLabelTopPadding: CGFloat = 4
                static let titleLabelTopPadding: CGFloat = 4
                static let attrLabelTopPadding: CGFloat = 4
                
                static let verticalStepperTopPadding: CGFloat = 4
                static let verticalStepperTrailingPadding: CGFloat = -4
            }
        }
        
        struct Section {
            struct Visual {
                struct Images {}
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {
                    static let elementKindText: String = "background-element-kind"
                }
                
                struct Fonts {}
                
                struct Alignments {}
            }
            
            struct Dimensions {}
        }
        
        struct Stepper {
            struct Visual {
                struct Images {
                    static let plusImage: UIImage = UIImage(named: "Plus")!
                    static let minusImage: UIImage = UIImage(named: "Minus")!
                    static let trashImage: UIImage = UIImage(named: "PurpleTrash")!
                }
                
                struct ContentModes {}
                
                struct Colors {
                    static let viewBackgroundColor = UIColor(named: "White")
                    static let stepCountBackgroundColor = UIColor(named: "DarkPurple")
                    static let buttonBackgroundColor = UIColor(named: "White")
                    static let viewBorderColor = UIColor(named: "LightPurple")
                    
                    static let stepCountTextColor = UIColor(named: "White")
                }
                
                struct Decorations {}
            }
            
            struct Text {
                struct Texts {}
                
                struct Fonts {
                    static let stepCountLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
                }
                
                struct Alignments {
                    static let stepCountLabelAlignment: NSTextAlignment = .center
                }
            }
            
            struct Dimensions {
                static let cornerRadius: CGFloat = 8
                static let borderWidth: CGFloat = 2
                
                static let buttonViewProportion: CGFloat = 1/3
                static let buttonContentInset: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
                
                static let widthHeightRationWhenCollapsed: CGFloat = 1
                
                static let widthHeightRatioWhenExpandedHorizontally: CGFloat = 3
                static let widthHeightRatioWhenExpandedVerticallly: CGFloat = 1/3
                
                static let heightWidthRatioWhenExpandedHorizontally: CGFloat = 1/3
                static let heightWidthRatioWhenExpandedVerticallly: CGFloat = 3
            }
        }
    }
}
