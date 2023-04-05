//
//  ViewController.swift
//  TodoRx
//
//  Created by 권승용 on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel = TodoViewModel.shared
 
    // MARK: - UI Components
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
  
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupLayout()
        bindUIWithRx()
    }
    
    func setupLayout() {
        view.addSubview(todoTableView)
        view.addSubview(addTodoButton)
        view.addSubview(todoTitleLabel)
        
        todoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        todoTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        todoTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        todoTableView.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor).isActive = true
        todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        addTodoButton.translatesAutoresizingMaskIntoConstraints = false
        addTodoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addTodoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func bindUIWithRx() {
        todoTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        todoTableView.dataSource = nil
        
        // 테이블뷰와 데이터 바인딩
        viewModel.todoRelay
            .catchErrorJustReturn(viewModel.todos)
            .observeOn(MainScheduler.instance)
            .bind(to: todoTableView.rx.items(cellIdentifier: TodoCell.identifier, cellType: TodoCell.self)) { index, item, cell in
                
                cell.selectionStyle = .none
                cell.whatToDo.text = item.todo
                cell.isCompleted = item.isCompleted
                
                // cell 버튼 탭 시 동작 바꾸기
                cell.completeButton.rx.tap.asDriver()
                    .debug()
                    .drive(onNext:  {
                        print(cell.isCompleted)
                        cell.isCompleted.toggle()
                        if cell.isCompleted {
                            cell.completeButton.setImage(UIImage(systemName: "circle.circle"), for: .normal)
                        } else {
                            cell.completeButton.setImage(UIImage(systemName: "circle"), for: .normal)
                        }
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
    }
   
    @objc func addTodoButtonTapped() {
        self.present(ModalViewController(), animated: true)
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

