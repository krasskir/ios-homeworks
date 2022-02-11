//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Kirill Krasavin on 10.02.2022.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDateLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var storyLable: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        let view = self.loadViewFromXib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
//        self.nameLabel.text = "Kirill"
    }
    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? UIView else {
            return UIView()
        }
        return view
    }
}

