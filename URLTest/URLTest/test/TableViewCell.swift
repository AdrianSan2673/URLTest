//
//  TableViewCell.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descView: UILabel!
    @IBOutlet weak var imagenView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /*func onBind(data: Movie){
      titleView.text = data.title
      descView.text = data.overview
    }*/
}
