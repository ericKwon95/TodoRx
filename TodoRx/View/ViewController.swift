//
//  ViewController.swift
//  TodoRx
//
//  Created by 권승용 on 2023/03/19.
//

import UIKit
class ViewController: UIViewController {
    
    let todoTableView = UITableView()
    
    let todoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.tintColor = .black
        return label
    }()
    
    lazy var addTodoButton: UIButton = {
        let button = UIButton()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "plus", withConfiguration: symbolConfig), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(addTodoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(todoTableView)
        view.addSubview(addTodoButton)
        view.addSubview(todoTitleLabel)
        
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        todoTableView.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor).isActive = true
        todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        todoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        todoTableView.dataSource = self
        
        addTodoButton.translatesAutoresizingMaskIntoConstraints = false
        addTodoButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        addTodoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        todoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        todoTitleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        todoTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func addTodoButtonTapped() {
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
      }
}

// MARK: - 프리뷰 기능
#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable().previewDisplayName("iPhone 14")
    }
}
#endif

