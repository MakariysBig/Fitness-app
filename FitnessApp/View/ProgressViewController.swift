import UIKit

final class ProgressViewController: UIViewController {
    
    //MARK: - Private propertie
    
    private let userDefaults = UserDefaults.standard
    private let tableView = UITableView()
    
    private lazy var dates = userDefaults.value(forKey: "date") as? [Date] ?? []
    private lazy var countDate = dates.count

    //MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpTableViewLayout()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    //MARK: - Private methode
    
    private func updateData() {
        dates = userDefaults.value(forKey: "date") as? [Date] ?? []
        countDate = dates.count
        tableView.reloadData()
    }
    
    private func setup() {
        view.backgroundColor = .greenCustomColor
        navigationController?.navigationBar.barTintColor = .greenCustomColor
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Training log"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.yellowCustomColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.yellowCustomColor]
    }
    
    private func configureTableView() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(EmptyCustomCell.self, forCellReuseIdentifier: "EmptyCustomCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Extension: UITableViewDelegate, UITableViewDataSource

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countDate == 0 {
            return 1
        } else {
            return countDate
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dates.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCustomCell",
                                                           for: indexPath) as? EmptyCustomCell else { return UITableViewCell() }
            tableView.rowHeight = 200
            cell.backgroundColor = .lightGreenCustomColor
            cell.selectionStyle = .none
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell",
                                                           for: indexPath) as? CustomCell else { return UITableViewCell() }
            
            let fullFormatter = DateFormatter()
            fullFormatter.dateFormat = "MMM d, yyyy"
            fullFormatter.locale = Locale(identifier: "en")
            
            let date = fullFormatter.string(from: dates[indexPath.row])
            cell.dateLabel.text = date
            cell.selectionStyle = .none
            cell.backgroundColor = .lightGreenCustomColor
            tableView.rowHeight = 40
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions = UISwipeActionsConfiguration(actions: [])
        
        if !dates.isEmpty {
            let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
                guard let self = self else { return }
                self.dates.remove(at: indexPath.row)
                self.userDefaults.set(self.dates, forKey: "date")
                self.countDate = self.dates.count
                self.tableView.reloadData()
            }
            let actionDel = UISwipeActionsConfiguration(actions: [actionDelete])
            actions = actionDel
        }
        return actions
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius = 20
        var corners: UIRectCorner = []
        
        if indexPath.row == 0 {
            corners.update(with: .topLeft)
            corners.update(with: .topRight)
        }
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            corners.update(with: .bottomLeft)
            corners.update(with: .bottomRight)
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: cell.bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        cell.layer.mask = maskLayer
    }
}
