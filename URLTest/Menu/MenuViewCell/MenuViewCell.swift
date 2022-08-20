//
//  MenuViewCell.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import UIKit

class MenuViewCell: UICollectionViewCell {

    //var viewModel = MenuViewModel()
    @IBOutlet weak var imagenPoster: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var rangeMovie: UILabel!
    @IBOutlet weak var overMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    
    
}
