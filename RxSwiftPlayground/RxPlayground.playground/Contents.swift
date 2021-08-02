import UIKit
import RxSwift

let firstSequence = Observable.just("Heloo")
let secondSequence = Observable.of(1, 2, 3, 4)
let thirdSequence = Observable.from([4, 5, 6])

let firstObserver = firstSequence.subscribe{Event in
    switch Event{
    case .next(let value):
        print(value)
    case .error(let error):
        print(error)
    case .completed:
        print("Completed")
    }
}

firstSequence.subscribe(onNext: { Element in
    print(Element)
})

let secondObserver = secondSequence.subscribe { Event in
    print(Event)
}

let thirdObserver = thirdSequence.subscribe{ Event in
    print(Event)
}


enum Event<Element> {
    case next(Element)
    //case error(Swift.Erorr)
    case completed
}


firstObserver.dispose()

let bag = DisposeBag()

let fourSequence = Observable.just("Observable FourSequence")

let fourObserver = fourSequence.subscribe(onNext: {element in
    print(element)
})

fourObserver.disposed(by: bag)


let subject = ReplaySubject<Int>.create(bufferSize: 2)
//let disposeBag = DisposeBag()

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.subscribe{
    print($0)
}

subject.subscribe{
    print($0)
}


let numberSubject = PublishSubject<Int>()
let disposeBag = DisposeBag()

numberSubject
    .ignoreElements()
    .subscribe{_ in
        print("completed Event")
    }.disposed(by: disposeBag)


numberSubject.onNext(1)
numberSubject.onNext(2)
numberSubject.onCompleted()

Observable.of(5,6,7,8,9,10)
    .filter { integer in
        integer > 8
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


Observable.of(5,6,7,8)
    .map{ integer in
        return integer * 10
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

let tenSequence = Observable<Int>.of(1,2)
let elevenSequence = Observable<Int>.of(3,4)

let sequences = Observable.of(tenSequence, elevenSequence)

sequences
    .flatMap{
        return $0
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

Observable.of(2,3)
    .startWith(1)
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)


let first = Observable.of("A", "B")
let second = Observable.of("C", "D")
 
let observable = Observable.concat([first, second])
        
observable.subscribe(onNext: { value in
    print(value)
}).disposed(by: disposeBag)
