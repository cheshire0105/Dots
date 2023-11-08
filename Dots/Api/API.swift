//
//  API.swift
//  Dots
//
//  Created by cheshire on 11/8/23.
//

import Foundation
import FirebaseFirestore
import RxSwift
import FirebaseStorage

class API {
    static let shared = API() // 싱글턴 인스턴스

    private init() {} // private 초기화 방지

    func fetchExhibitions() -> Observable<[ExhibitionModel]> {
        return Observable.create { observer in
            let collectionRef = Firestore.firestore().collection("전시")

            collectionRef.getDocuments { (snapshot, error) in
                if let error = error {
                    observer.onError(error)
                } else if let snapshot = snapshot {
                    let exhibitions = snapshot.documents.compactMap { doc -> ExhibitionModel? in
                        var data = doc.data()
                        data["서울_전시_1"] = doc.documentID
                        return ExhibitionModel(dictionary: data)
                    }
                    observer.onNext(exhibitions)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    func downloadImage(withPath imagePath: String, completion: @escaping (UIImage?) -> Void) {
        // Firebase Storage의 참조를 얻습니다.
        let storageRef = Storage.storage().reference(withPath: imagePath)

        // 이미지를 메모리로 직접 다운로드합니다.
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
