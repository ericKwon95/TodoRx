//
//  TodoViewModel.swift
//  TodoRx
//
//  Created by 권승용 on 2023/03/20.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

final class TodoViewModel {
    // 싱글턴 패턴 
    static let shared = TodoViewModel()
   
    // BehaviorRelay 선언
    let todoRelay = BehaviorRelay<[TodoModel]>(value: [])
    lazy var unCompletedTodos = todoRelay.map { $0.filter { $0.isCompleted == false }}
    lazy var completedTodos = todoRelay.map { $0.filter { $0.isCompleted == true }}
    
    let todoTextObservable = BehaviorSubject<String>(value: "")
    
    let disposeBag = DisposeBag()
   
    // 더미 데이터
    var todos: [TodoModel] = []
       
    init() {
        // relay에 값 방출
        todoRelay.accept(todos)
    }
   
    // 새로운 todo 추가
    func addTodo() {
        _ = todoTextObservable
            .take(1)
            .subscribe(onNext: { lastText in
                self.todos.append(TodoModel(todo: lastText, isCompleted: false))
                self.todoRelay.accept(self.todos)
            })
    }
}
