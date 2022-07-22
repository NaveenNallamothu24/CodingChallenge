//
//  AcronymCell.swift
//  CodingChallenge
//
//  Created by Naveen Nallamothu on 07/21/22.
//

import UIKit

class AcronymCell: UITableViewCell {

    @IBOutlet weak var acronymLabel: UILabel!
    @IBOutlet weak var innerView: UIView!
    
    var acronym : Acronym? {
        didSet {
            acronymLabel?.text = (acronym?.lf ?? "unknown").capitalized
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        innerView.layer.cornerRadius = 5.0
        innerView.layer.masksToBounds = false
        innerView.layer.shadowColor = UIColor.gray.cgColor
        innerView.layer.shadowOffset = CGSize(width: 4, height: 4);
        innerView.layer.shadowOpacity = 0.5
        innerView.layer.borderWidth = 1.0
        innerView.layer.borderColor = UIColor(red:0.00, green:0.87, blue:0.39, alpha:1.0).cgColor

    }
}
