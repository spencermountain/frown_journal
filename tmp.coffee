CryptoJS = require("crypto-js")

# iv= CryptoJS.lib.WordArray.random(20).toString()
iv = "c7cce0d166262006761b014859b6189998e4277a"
salt = "s club.. there aint no party like an s-club party"
plainText = "fun times party"
password = "password"

#encrypt
key = CryptoJS.PBKDF2(password, CryptoJS.enc.Hex.parse(salt),
  keySize: @keySize
  iterations: @iterationCount
)
encrypted = CryptoJS.AES.encrypt(plainText, key,
  iv: CryptoJS.enc.Hex.parse(iv)
)
ciphertext = encrypted.ciphertext.toString(CryptoJS.enc.Base64)
console.log ciphertext


#decrypt
cipherParams = CryptoJS.lib.CipherParams.create(ciphertext: CryptoJS.enc.Base64.parse(ciphertext))
decrypted = CryptoJS.AES.decrypt(cipherParams, key,
  iv: CryptoJS.enc.Hex.parse(iv)
)
funya = decrypted.toString(CryptoJS.enc.Utf8)
console.log funya
