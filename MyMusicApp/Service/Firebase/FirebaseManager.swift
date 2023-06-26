//
//  FirebaseManager.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 25.06.2023.
//

import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    var userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    private var userUid: String {
        get {
            if let uid = userDefaults.string(forKey: "UserUID") {
                return uid
            } else {
                return ""
            }
        }
        set {
            userDefaults.set(newValue, forKey: "UserUID")
        }
    }
    
    let db = Firestore.firestore()
    
    func createAccount(email: String, password: String, username: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error == nil {
                if let result = result {
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    let userRef = self?.db.collection("users").document(userID)
                    
                    let userData: [String: Any] = [
                        "name": username,
                        "email": email,
                        "password": password
                    ]
                    
                    userRef?.setData(userData)
                    self?.saveInUserDefaults(userInfo: UserInfo(name: username, email: email))
                    completion(nil)
                }
            } else {
                completion(error)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error == nil {
                if let result = result {
                    self?.userUid = result.user.uid
                    self?.fetchUserInfo(for: result.user.uid, complition: { info, error in
                        if error == nil {
                            self?.saveInUserDefaults(userInfo: info)
                            completion(nil)
                        } else {
                            completion(error)
                        }
                    })
                }
            } else {
                completion(error)
            }
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    func updatePassword(to password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if error == nil {
                guard let userID = Auth.auth().currentUser?.uid else { return }
                self.db.collection("users").document(userID).updateData(["password": password]) { (error) in
                    if let error = error {
                        print("Ошибка обновления поля пароля: \(error.localizedDescription)")
                    } else {
                        print("Поле пароля успешно обновлено")
                    }
                }
            } else {
                completion(error)
            }
        }
    }
    
    func signOut(completion: @escaping () -> ()) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func fetchUserInfo(for userId: String, complition: @escaping (UserInfo, Error?) -> ()) {
        var userInfo = UserInfo()
        
        let data = Database.database().reference(withPath: "users")
        data.child(userId).child("name").getData { error, data in
            if error == nil {
                if let data = data {
                    let name = data.value as? String
                    userInfo.name = name
                }
            } else {
                complition(userInfo, error)
            }
        }
        data.child(userId).child("email").getData { error, data in
            if error == nil {
                if let data = data {
                    let email = data.value as? String
                    userInfo.email = email
                }
            } else {
                complition(userInfo, error)
            }
        }
    }
    
    private func saveInUserDefaults(userInfo: UserInfo) {
        guard let encoded = try? encoder.encode(userInfo) else { return }
        userDefaults.set(encoded, forKey: "userInfo")
    }
    
    func saveDataToFirestore(name: String, email: String, gender: String, date: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = ["name": name, "email": email, "gender": gender, "date": date]
        db.collection("users").document(userID).updateData(data) { (error) in
            if let error = error {
                print("Ошибка обновления полей: \(error.localizedDescription)")
            } else {
                print("Поля успешно обновлено")
            }
        }
    }
    
    func uploadProfileImage(url: URL) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        // Create a reference to the file you want to upload
        let imageRef = Storage.storage().reference().child("images/\(userID).jpg")
        
        // Upload the file to the path
        let uploadTask = imageRef.putFile(from: url, metadata: nil) { metadata, error in
            if let error = error {
                print("Ошибка загрузки фото профиля: \(error.localizedDescription)")
            } else {
                print("Фото успешно обновлено")
            }
        }
    }
    
    func downloadProfileImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let imageRef = Storage.storage().reference().child("images/\(userID).jpg")
        imageRef.getData(maxSize: 10*1024*1024) { data, error in
            if let data = data, error == nil {
                completion(UIImage(data: data), nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
