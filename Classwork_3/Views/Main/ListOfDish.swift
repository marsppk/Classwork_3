//
//  ListOfDish.swift
//  Classwork_3
//
//  Created by Maria Slepneva on 04.10.2023.
//

import UIKit

class ListOfDish: UIViewController, NewItemDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func addNewElement(element: Dish) {
        dishes.append(element)
        tableView.reloadData()
    }
    
    let buttonNewDish: UIButton = {
        let buttonNewDish = UIButton()
        buttonNewDish.layer.cornerRadius = 16.0
        buttonNewDish.backgroundColor = UIColor(named: "green_for_button")
        buttonNewDish.tintColor = .white
        buttonNewDish.setTitle("Добавить блюдо", for: .normal)
        return buttonNewDish
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.tableHeaderView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()
    
    var dishes: [Dish] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { fatalError() }
        let dish = dishes[indexPath.row]
        cell.delegate = self
        cell.configureSubstances(image: cell.images[0], substance: cell.fats, amount: String(dish.fats))
        cell.configureSubstances(image: cell.images[1], substance: cell.protein, amount: String(dish.protein))
        cell.configureSubstances(image: cell.images[2], substance: cell.carbs, amount: String(dish.carbs))
        cell.configureName(name: dish.name)
        cell.configureKcal(amount: String(dish.kcal))
        cell.configureButton(isFavorive: dish.isSelected)
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func addDefaultDishes() {
        dishes.append(Dish(name: "Салат “Оливье”", protein: "30", fats: "30", carbs: "30", kcal: "47", isSelected: false))
        dishes.append(Dish(name: "Салат “Крабовый”", protein: "15", fats: "15", carbs: "45", kcal: "47", isSelected: false))
        dishes.append(Dish(name: "Салат Цезарь с курицей", protein: "50", fats: "10", carbs: "30", kcal: "47", isSelected: false))
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            buttonNewDish.heightAnchor.constraint(equalToConstant: 44),
            buttonNewDish.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonNewDish.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonNewDish.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonNewDish.topAnchor, constant: -7),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "Обед"
        
        addDefaultDishes()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        buttonNewDish.addAction(
            .init {[weak self] _ in
                guard let self else { return }
                let vc = NewItem()
                vc.view.backgroundColor = .white
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.navigationBar.tintColor = .black
                navigationItem.backButtonTitle = ""},
            for: .touchUpInside
        )
        
        view.addSubview(tableView)
        view.addSubview(buttonNewDish)
        
        [buttonNewDish, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        activateConstraints()
    }
}

extension ListOfDish: TableViewCellDelegate {
    func starButtonTapped(_ cell: TableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            dishes[indexPath.row].isSelected = !dishes[indexPath.row].isSelected
            tableView.reloadData()
        }
    }
}
