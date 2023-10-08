//
//  CustomCell.swift
//  Classwork_3
//
//  Created by Maria Slepneva on 04.10.2023.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func starButtonTapped(_ cell: TableViewCell)
}

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    let fats = UILabel()
    let carbs = UILabel()
    let protein = UILabel()
    let images = [UIImage(named: "fats"), UIImage(named: "protein"), UIImage(named: "carbs")]
    let substances: UIStackView = {
        let substances = UIStackView()
        substances.axis = .horizontal
        substances.spacing = 12
        return substances
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    let label = UILabel()
    let kcalLabel = UILabel()
    let starButton: UIButton = {
        let starButton = UIButton()
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        starButton.tintColor = UIColor(named: "green_for_button")
        starButton.isUserInteractionEnabled = true
        return starButton
    }()
    
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
        if let titleFont = titleFont {
            let title = NSMutableAttributedString(
                string: " " + amount,
                attributes: [
                    .font: titleFont,
                    .foregroundColor: UIColor.gray,
                    .paragraphStyle: titleParagraphStyle
                ]
            )
            attributedText.append(imageString)
            attributedText.append(title)
        }
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
    
    func setConstraints() {
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
    
    private func setupUI() {
        self.selectionStyle = .none
        
        [protein, fats, carbs].forEach {
            substances.addArrangedSubview($0)
        }
        
        [label, substances].forEach {
            stack.addArrangedSubview($0)
        }
        
        [stack, kcalLabel, starButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        setConstraints()
    }
}
