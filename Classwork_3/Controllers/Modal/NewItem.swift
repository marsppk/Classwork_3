//
//  NewItem.swift
//  Classwork_3
//
//  Created by Maria Slepneva on 04.10.2023.
//

import UIKit

protocol NewItemViewControllerDelegate: AnyObject {
    func addNewElement(element: Dish)
}

class NewItemViewController: UIViewController {
    
    // MARK: - Proreties
    
    weak var delegate: NewItemViewControllerDelegate?
    
    // MARK: - Subviews
    
    private lazy var name: UITextField = {
        let name = UITextField()
        name.placeholder = "Название"
        NSLayoutConstraint.activate([
            name.heightAnchor.constraint(equalToConstant: 44)
        ])
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: name.frame.height))
        name.leftView = spacerView
        name.leftViewMode = .always
        name.translatesAutoresizingMaskIntoConstraints = false
        name.layer.cornerRadius = 16
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor(named: "green_for_button")?.cgColor
        return name
    }()
    
    private lazy var protein: UITextField = {
        let name = UITextField()
        name.placeholder = "Белки (на 100 грамм)"
        NSLayoutConstraint.activate([
            name.heightAnchor.constraint(equalToConstant: 44)
        ])
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: name.frame.height))
        name.leftView = spacerView
        name.leftViewMode = .always
        name.translatesAutoresizingMaskIntoConstraints = false
        name.layer.cornerRadius = 16
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor(named: "green_for_button")?.cgColor
        return name
    }()
    
    private lazy var fats: UITextField = {
        let name = UITextField()
        name.placeholder = "Жиры (на 100 грамм)"
        NSLayoutConstraint.activate([
            name.heightAnchor.constraint(equalToConstant: 44)
        ])
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: name.frame.height))
        name.leftView = spacerView
        name.leftViewMode = .always
        name.translatesAutoresizingMaskIntoConstraints = false
        name.layer.cornerRadius = 16
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor(named: "green_for_button")?.cgColor
        return name
    }()
    
    private lazy var carbs: UITextField = {
        let name = UITextField()
        name.placeholder = "Углеводы (на 100 грамм)"
        NSLayoutConstraint.activate([
            name.heightAnchor.constraint(equalToConstant: 44)
        ])
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: name.frame.height))
        name.leftView = spacerView
        name.leftViewMode = .always
        name.translatesAutoresizingMaskIntoConstraints = false
        name.layer.cornerRadius = 16
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor(named: "green_for_button")?.cgColor
        return name
    }()
    
    private lazy var kcals: UITextField = {
        let name = UITextField()
        name.placeholder = "Калории (на 100 грамм)"
        name.heightAnchor.constraint(equalToConstant: 44).isActive = true
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: name.frame.height))
        name.leftView = spacerView
        name.leftViewMode = .always
        name.translatesAutoresizingMaskIntoConstraints = false
        name.layer.cornerRadius = 16
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor(named: "green_for_button")?.cgColor
        return name
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let titleNewItem: UILabel = {
        let titleNewItem = UILabel()
        titleNewItem.text = "Добавить свое блюдо"
        titleNewItem.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        return titleNewItem
    }()
    
    let buttonNewDish: UIButton = {
        let buttonNewDish = UIButton()
        buttonNewDish.layer.cornerRadius = 16.0
        buttonNewDish.backgroundColor = UIColor(named: "green_for_button")
        buttonNewDish.tintColor = .white
        buttonNewDish.setTitle("Готово", for: .normal)
        return buttonNewDish
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Обед"
        
        [stack, titleNewItem, buttonNewDish].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [name, protein, fats, carbs, kcals].forEach {
            stack.addArrangedSubview($0)
        }
        
        setupAddTargetIsNotEmptyTextFields()
        addActionForButton()
        setConstraints()
    }
    
    // MARK: - Methods
    
    func setupAddTargetIsNotEmptyTextFields() {
        buttonNewDish.isEnabled = false
        [name, protein, fats, carbs, kcals].forEach {
            $0.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                         for: .editingChanged)
        }
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
              let name = name.text, !name.isEmpty,
              let protein = protein.text, !protein.isEmpty,
              let fats = fats.text, !fats.isEmpty,
              let carbs = carbs.text, !carbs.isEmpty,
              let kcals = kcals.text, !kcals.isEmpty
          else
        {
          self.buttonNewDish.isEnabled = false
          return
        }
        buttonNewDish.isEnabled = true
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleNewItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleNewItem.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            stack.topAnchor.constraint(equalTo: titleNewItem.bottomAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.heightAnchor.constraint(equalToConstant: 284),
            
            buttonNewDish.heightAnchor.constraint(equalToConstant: 44),
            buttonNewDish.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonNewDish.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonNewDish.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 32),
        ])
    }
    
    func addActionForButton() {
        buttonNewDish.addAction(
            .init {[weak self] _ in
                guard let self else { return }
                    self.navigationController?.popViewController(animated: true)
                guard
                      let name = name.text, !name.isEmpty,
                      let protein = protein.text, !protein.isEmpty,
                      let fats = fats.text, !fats.isEmpty,
                      let carbs = carbs.text, !carbs.isEmpty,
                      let kcals = kcals.text, !kcals.isEmpty
                  else
                {
                  self.buttonNewDish.isEnabled = false
                  return
                }
                buttonNewDish.isEnabled = true
                let newItem = Dish(name: name, protein: protein, fats: fats, carbs: carbs, kcal: kcals, isSelected: false)
                self.delegate?.addNewElement(element: newItem)
            },
            for: .touchUpInside
        )
    }
}
