import UIKit

enum ValidationType: String{
    case email = "Email ex.someName@something.com"
    case password = "Password should have 8 numbers"
    case name = "Name Should contain letters only"
    case phone = "Phone Should contain 11 no."
    case address = "address not correct"
}

extension String {

    enum Regex :String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^[0-9]{8}$"
        case names = "^[a-zA-Z- ]*$"
        case phone = "^01[0-2]{1}[0-9]{8}"
        case address = "^[a-zA-Z][0-9]*$"
    }
    
    
    func isValid (_ ValidateType :ValidationType) -> (Bool,String?){
        
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch ValidateType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .name:
            regex = Regex.names.rawValue
        case .phone:
            regex = Regex.phone.rawValue
        case .address:
            regex = Regex.address.rawValue
        }
        
        if self.isEmpty {
            return (!self.isEmpty, "field is Empty")
        } else {
            if NSPredicate(format: format, regex).evaluate(with: self) {
                return(true,nil)
            } else  {
                return(false,ValidateType.rawValue)
            }
        }
    }
}


