//
//  CustomCell.swift
//  Classwork_3
//
//  Created by Maria Slepneva on 04.10.2023.
//

import UIKit

protocol TableViewCellDelegate: class {
    func starButtonTapped(_ cell: TableViewCell)
}

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    let fats = UILabel()
    let carbs = UILabel()
    let protein = UILabel()
    let images = [UIImage(named: "fats"), UIImage(named: "protein"), UIImage(named: "carbs")]
    let substances = UIStackView()
    let stack = UIStackView()
    let label = UILabel()
    let kcalLabel = UILabel()
    let starButton = UIButton()
    
    weak var delegate: TableViewCellDelegate?
    
    func configureSubstances(image: UIImage?, substance: UILabel, amount: String) {
        let attributedText = NSMutableAttributedString()
                
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        let imageString = NSAttributedString(attachment: imageAttachment)
        let newImageSize = CGSize(width: 26, height: 26)
        imageAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: -6.5), size: newImageSize)

        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center

        let titleFont = UIFont(name: "Helvetica Neue", size: 17)
        let title = NSMutableAttributedString(string: " " + amount,
            attributes: [.font: titleFont,
            .foregroundColor: UIColor.gray,
            .paragraphStyle: titleParagraphStyle])

        attributedText.append(imageString)
        attributedText.append(title)

        substance.attributedText = attributedText
        substance.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureName(name: String) {
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        label.text = name
    }
    
    func configureKcal(amount: String) {
        kcalLabel.font = UIFont(name:"HelveticaNeue", size: 17.0)
        kcalLabel.text = amount + " kcal"
        kcalLabel.textColor = .gray
    }
    
    func configureButton(isFavorive: Bool) {
        starButton.isSelected = isFavorive
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        delegate?.starButtonTapped(self)
    }
    
    private func setupUI() {
        self.addSubview(stack)
        self.addSubview(kcalLabel)
        self.addSubview(starButton)
        
        self.selectionStyle = .none
        
        substances.addArrangedSubview(protein)
        substances.addArrangedSubview(fats)
        substances.addArrangedSubview(carbs)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(substances)
        
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        kcalLabel.translatesAutoresizingMaskIntoConstraints = false
        starButton.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        starButton.tintColor = UIColor(named: "green_for_button")
        starButton.isUserInteractionEnabled = true
        
        substances.axis = .horizontal
        substances.spacing = 12
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            
            starButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 26),
            starButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -22),
            starButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            kcalLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            kcalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23),
            kcalLabel.trailingAnchor.constraint(equalTo: starButton.leadingAnchor, constant: -12),
            kcalLabel.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 12),
        ])
    }
}
