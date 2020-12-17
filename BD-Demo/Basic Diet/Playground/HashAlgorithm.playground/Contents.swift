import Cocoa
import CryptoKit

func stringSHA256(_ stringInput: String) -> Int{
    let data = Data(stringInput.utf8)
    let hashed = SHA256.hash(data: data)
    return hashed.hashValue
}

print(stringSHA256("test"))
