//
//  UserService.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import Foundation
import Combine
import FirebaseAuth
import CoreData

class UserService {
    
    // Enums del UserService
    enum UserServiceError: String, Error {
        
        case contextRequestError = "Error: falló la carga del contexto del UserEntity"
        case emailNotFoundError = "Error: el correo no se encuetra registrado en FireBase"
        case verifyEmailRequestError = "Error: solicitud de consulta invalida"
        case signUpRequestError = "Error: solicitud inválida al tratar de dar de alta correo y contraseña en FireBase"
        case signUpResponseError = "Error: no se pudo dar de alta el correo electrónico en FireBase, usuario regresó como nulo"
        case signUpUserProfileError = "Error: el perfil de usuario no se pudo guardar en el contexto del UserEntity"
        case loginWithEmailAndPasswordError = "Error: petición de login inválida"
        case loginWithEmailAndPasswordContextNilError = "Error: al recuperar el contexto del UserEntity, su valor es nulo"
        case loginWithEmailAndPasswordResultNilError = "Error: al loguear al usuario en FireBase, el resultado es nulo"
        case loginWithEmailAndPasswordProfileNilError = "Error: al cargar perfil de usuario, no existe en el dispositivo local"
        case userToggleRememberMeErrorUserNil = "Error al actualizar propiedad rememberMe, no existe perfil de usuario local para el correo electrónico verificado"
        case userToggleRememberMeErrorContext = "Error al actualizar propiedad rememberMe, no se pudo guardar el contexto de UserEntity"
        case userToggleTouchIdErrorActiveUserNil = "Error al actualizar propiedad touchId, el usuario activo es nil"
        case userToggleTouchIdErrorContext = "Error al actualizar propiedad touchId, no se pudo guardar el contexto de UserEntity"
        case isAUserRememberedError = "No hay usuario recordado localmente"
        case logoutActiveUserIsNilError = "Error: no se pudo cerrar la sesión, no existe usuario activo"
        case logoutFailedError = "Error: ocurrió un problema al cerrar la sesión actual"
    }
    
    // Propiedades del UserService
    private var users: [UserEntity]?
    private var activeUser: UserEntity?
    private var verifiedEmail: String?
    private var rememberedUser: UserEntity?
    
    // Contenedor persistente del UserService
    private lazy var userEntityContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyCaloriAPP")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                
                fatalError("[UserService - userEntityContainer] El contenedor persistente no pudo ser creado")
            } else {
                
                print("[UserService - userEntityContainer] El contenedor persistente se creó correctamente")
            }
        }
        
        return container
    }()
    
    // Publicadores del UserService
    var loadCoreDataUsersSubject = PassthroughSubject<(users: [UserEntity]?, error: UserServiceError?), Never>()
    var verifyEmailAlredySignedUpSubject = PassthroughSubject<(email: String?, error: UserServiceError?), Never>()
    var signUpEmailAndPasswordSubject = PassthroughSubject<(user: (email: String, password: String, uid: String)?, error: UserServiceError?), Never>()
    var signUpUserProfileSubject = PassthroughSubject<(user: UserEntity?, error: UserServiceError?), Never>()
    var loginWithEmailAndPasswordSubject = PassthroughSubject<(activeUser: UserEntity?, error: UserServiceError?), Never>()
    var userToggleRememberMeSubject = PassthroughSubject<UserEntity, UserServiceError>()
    var userToggleTouchIdSubject = PassthroughSubject<UserEntity, UserServiceError>()
    var isAUserRememberedSubject = PassthroughSubject<UserEntity, UserServiceError>()
    var isUserTouchIdActiveSubject = PassthroughSubject<Bool, UserServiceError>()
    var logoutActiveUserSubject = PassthroughSubject<(success: Bool?, error: UserServiceError?), Never>()
    
    // FUNCIONALIDADES DEL USER SERVICE
    
    // Recupera el contexto de UserEntity
    func loadCoreDataUsers() {
        
        let userEntityContext = self.userEntityContainer.viewContext
        
        let requestUserEntity = UserEntity.fetchRequest()
        
        if let users = try? userEntityContext.fetch(requestUserEntity) {
            
            print("[UserService - loadCoreDataUsers] Se cargó el contexto del UserEntity exitosamente")
            self.users = users
            self.loadCoreDataUsersSubject.send((users: users, error: nil))
        } else {
            
            print("[UserService - loadCoreDataUsers] Falló la carga del contexto del UserEntity")
            self.loadCoreDataUsersSubject.send((users: nil, error: UserServiceError.contextRequestError))
        }
    }
    
    // Verifica si el correo ya se encuentra registrado a través de un método proporcionado
    // por FireBase que consulta las maneras en las que un usuario (ya registrado) puede ser
    // logueado en la plataforma. Si lo encuentra, actualiza verifiedEmail
    func verifyEmailAlredySignedUp(_ email: String) {
        
        Auth.auth().fetchSignInMethods(forEmail: email) {
            
            [weak self] signInMethods, error in
            
            if let error = error {
                
                print("[UserService - verifyEmailAlredySignedUp] Error al tratar de verificar si el correo electrónico ya se encuentra registrado en FireBase: \(error.localizedDescription)")
                self?.verifyEmailAlredySignedUpSubject.send((email: nil, error: .verifyEmailRequestError))
            } else {
                
                if let _ = signInMethods {
                    
                    print("[UserService - verifyEmailAlredySignedUp] El correo ya se encuentra registrado en FireBase")
                    self?.verifyEmailAlredySignedUpSubject.send((email: email, error: nil))
                } else {
                    
                    print("[UserService - verifyEmailAlredySignedUp] El correo no se encuentra registrado en FireBase")
                    self?.verifyEmailAlredySignedUpSubject.send((email: nil, error: .emailNotFoundError))
                }
            }
        }
    }
    
    // Realiza el registro del correo electrónico y el password en la plataforma
    // de FireBase
    func signUpEmailAndPassword(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            
            [weak self] result, error in
            
            if let error = error {
                
                print("[UserService - signUpEmailAndPassword] Error al tratar de dar de alta correo y contraseña en FireBase \(error.localizedDescription)")
                self?.signUpEmailAndPasswordSubject.send((user: nil, error: .signUpRequestError))
            } else {
                
                if let user = result?.user {
                    
                    print("[UserService - signUpEmailAndPassword] Se dio de alta el correo \(user.email!) y se le asignó el userID \(user.uid)")
                    self?.signUpEmailAndPasswordSubject.send((user: (email, password, user.uid), error: nil))
                } else {
                    
                    print("[UserService - signUpEmailAndPassword] No se pudo dar de alta correo \(email) en FireBase")
                    self?.signUpEmailAndPasswordSubject.send((user: nil, error: .signUpResponseError))
                }
            }
        }
    }
    
    // Recupera el contexto del UserEntity, agrega el nuevo perfil y guarda el contexto
    func signUpUserProfile(userId: String, name: String, lastName: String, userEmail: String, userPassword: String, userName: String, gender: Bool, height: Double, weight: Double, birthDate: Date, phoneNumber: String) {
        
        let userEntityContext = self.userEntityContainer.viewContext
            
        let user = UserEntity(context: userEntityContext)
        
        user.userId = userId
        user.name = name
        user.lastName = lastName
        user.userEmail = userEmail
        user.userPassword = userPassword
        user.userName = userName
        user.gender = gender
        user.height = height
        user.weight = weight
        user.birthDate = birthDate
        user.phoneNumber = phoneNumber
        user.rememberMe = false
        user.touchId = false
        
        do {
            
            try userEntityContext.save()
            print("[UserService - signUpUserProfile] Se creó el perfil de usuario \(userName)")
            self.signUpUserProfileSubject.send((user: user, error: nil))
        } catch {
            
            userEntityContext.rollback()
            print("[UserService - signUpUserProfile] No se pudo crear el perfil de usuario \(userName)")
            self.signUpUserProfileSubject.send((user: nil, error: .signUpUserProfileError))
        }
    }
    
    // Realiza el logueo del usuario por medio de un correo electrónico y un password,
    // posteriormente actualiza el activeUser
    func loginWithEmailAndPassword(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            
            [weak self] result, error in
            
            if let _ = error {
                
                print("[UserService - loginWithEmailAndPassword] No se pudo loguear al usuario \(email)")
                self?.loginWithEmailAndPasswordSubject.send((activeUser: nil, error: .loginWithEmailAndPasswordError))
            } else {
                
                if let result = result {
                    
                    guard let userEntityContext = self?.userEntityContainer.viewContext else {
                        
                        print("[UserService - loginWithEmailAndPassword] No se pudo recuperar el contexto de UserEntity")
                        self?.loginWithEmailAndPasswordSubject.send((activeUser: nil, error: .loginWithEmailAndPasswordContextNilError))
                        return }
                    
                    let requestUserEntity = UserEntity.fetchRequest()
                    
                    if let activeUser = try? userEntityContext.fetch(requestUserEntity).filter( { $0.userId == result.user.uid } ).first {
                        
                        print("[UserService - loginWithEmailAndPassword] Iniciando sesión con el correo \(email)")
                        self?.activeUser = activeUser
                        self?.loginWithEmailAndPasswordSubject.send((activeUser, error: nil))
                    } else {
                        
                        // TODO: SI EL USUARIO ESTÁ REGISTRADO, PERO NO TIENE PERFIL EN EL DISPOSITIVO ACTUAL, CREARLE UNO POR DEFECTO.
                        
                        print("[UserService - loginWithEmailAndPassword] No existe perfil de usuario para el correo \(email)")
                        self?.loginWithEmailAndPasswordSubject.send((activeUser: nil, error: .loginWithEmailAndPasswordProfileNilError))
                    }
                } else {
                    
                    print("[UserService - loginWithEmailAndPassword] No hay resultados al tratar de loguear al usuario \(email)")
                    self?.loginWithEmailAndPasswordSubject.send((activeUser: nil, error: .loginWithEmailAndPasswordResultNilError))
                }
            }
        }
    }
    
    // Recupera el contexto del UserEntity, actualiza la propiedad rememberMe del user
    // correspondiente al verifiedEmail, guarda el contexto
    func userToggleRememberMe(verifiedEmail: String) {
        
        let userEntityContext = self.userEntityContainer.viewContext
        
        let requestUserEntity = UserEntity.fetchRequest()
        
        if let user = try? userEntityContext.fetch(requestUserEntity).filter( { $0.userEmail == verifiedEmail } ).first {
            
            print("[UserService - userToggleRememberMe] se actualizó la propiedad rememberMe para el usuario \(user)")
            user.rememberMe = !user.rememberMe
            self.userToggleRememberMeSubject.send(user)
        } else {
            
            print("[UserService - userToggleRememberMe] No existe perfil de usuario en el dispositivo local con el correo electrónico verificado")
            self.userToggleRememberMeSubject.send(completion: .failure(.userToggleRememberMeErrorUserNil))
        }
        do {
            
            try userEntityContext.save()
            print("[UserService - userToggleRememberMe] Se guardó correctamente el contexto")
        } catch {
            
            print("[UserService - userToggleRememberMe] No se pudo guardar el contexto")
            userEntityContext.rollback()
            self.userToggleRememberMeSubject.send(completion: .failure(.userToggleRememberMeErrorContext))
        }
    }
    
    // Recupera el contexto del UserEntity, actualiza la propiedad touchId del activeIUser y
    // guarda el contexto
    func userToggleTouchId() {
        
        if let _ = self.activeUser {
            
            self.activeUser!.touchId = !self.activeUser!.touchId
            print("[UserService - userToggleTouchId] se actualizó la propiedad touchId para el usuario \(self.activeUser!)")
            self.userToggleTouchIdSubject.send(self.activeUser!)
        } else {
            
            print("[UserService - userToggleTouchId] No hay usuario activo")
            self.userToggleTouchIdSubject.send(completion: .failure(.userToggleTouchIdErrorActiveUserNil))
        }
        
        let userEntityContext = self.userEntityContainer.viewContext
        
        do {
            
            try userEntityContext.save()
            print("[UserService - userToggleTouchId] Se guardó correctamente el contexto")
        } catch {
            
            print("[UserService - userToggleTouchId] No se pudo guardar el contexto")
            userEntityContext.rollback()
            self.userToggleTouchIdSubject.send(completion: .failure(.userToggleTouchIdErrorContext))
        }
    }
    
    // Recupera el contexto del UserEntity, filtra los perfiles en función de la
    // propiedad rememberMe
    func isAUserRemembered() {
        
        let userEntityContext = self.userEntityContainer.viewContext
        
        let requestUserEntity = UserEntity.fetchRequest()
        
        if let user = try? userEntityContext.fetch(requestUserEntity).filter( { $0.rememberMe == true } ).first {
            
            self.rememberedUser = user
            print("[UserService - isAUserRemembered] existe un usuario recordado")
            self.isAUserRememberedSubject.send(user)
        } else {
            
            print("[UserService - isAUserRemembered] no existe usuario recordado")
            self.isAUserRememberedSubject.send(completion: .failure(.isAUserRememberedError))
        }
            
    }
    
    // Verifica si un usuario recordado desea ingresar por medio de su Touch ID
    func isUserTouchIdActive() {
        
        if let _ = self.rememberedUser {
            
            if self.rememberedUser!.touchId == true {
                
                print("[UserService - isUserTouchIdActive] el usuario recordado desea ingresar con TouchID")
                self.isUserTouchIdActiveSubject.send(true)
            } else {
                
                print("[UserService - isUserTouchIdActive] el usuario recordado no desea ingresar con TouchID")
                self.isUserTouchIdActiveSubject.send(false)
            }
        } else {
            
            print("[UserService - isUserTouchIdActive] no existe usuario recordado")
            self.isUserTouchIdActiveSubject.send(completion: .failure(.isAUserRememberedError))
        }
    }
    
    // Realiza el logueo del usuario por medio de su touchID, posteriormente actualiza
    // el activeUser
    func loginWithTouchId() {
        
        
    }
    
    // Termina la sesión del usuario activo con un Logout e iguala el activeUser a nil
    func logoutActiveUser() {
                
        guard let _ = self.activeUser else {
            
            print("[UserService - logoutActiveUser] no existe usuario activo")
            self.logoutActiveUserSubject.send((success: nil, error: .logoutActiveUserIsNilError))
            return
        }
        
        do {
            
            try Auth.auth().signOut()
            self.activeUser = nil
            self.logoutActiveUserSubject.send((success: true, error: nil))
            print("[UserService - logoutActiveUser] se cerró la sesión")
        } catch {
            
            print("[UserService - logoutActiveUser] error al cerrar sesión")
            self.logoutActiveUserSubject.send((success: nil, error: .logoutFailedError))
        }
    }
    
}
