
arr= [
  "./libs/jquery.js",
  "./libs/sugar.js",
  "./libs/oj.js",
  "./libs/easings.js",
  "./libs/dirty.js",
  "./libs/cryptojs.min.js",
]
head.js.apply(this, arr);

head ->
  oj.useGlobally();

  #the seeds
  iv = "c7cce0d166262006761b014859b6189998e4277a" # iv= CryptoJS.lib.WordArray.random(20).toString()
  salt = "s club.. there aint no party like an s-club party"


  encrypt=(plainText)->
    password = $("#password").val()

    #encrypt
    key = CryptoJS.PBKDF2(password, CryptoJS.enc.Hex.parse(salt),
      keySize: @keySize
      iterations: @iterationCount
    )
    encrypted = CryptoJS.AES.encrypt(plainText, key,
      iv: CryptoJS.enc.Hex.parse(iv)
    )
    ciphertext = encrypted.ciphertext.toString(CryptoJS.enc.Base64)
    return ciphertext

  decrypt=(ciphertext)->
    password = $("#password").val()
    key = CryptoJS.PBKDF2(password, CryptoJS.enc.Hex.parse(salt),
      keySize: @keySize
      iterations: @iterationCount
    )
    #decrypt
    cipherParams = CryptoJS.lib.CipherParams.create(ciphertext: CryptoJS.enc.Base64.parse(ciphertext))
    decrypted = CryptoJS.AES.decrypt(cipherParams, key,
      iv: CryptoJS.enc.Hex.parse(iv)
    )
    funya = decrypted.toString(CryptoJS.enc.Utf8)


  change_text=()->
    plainText = $("#text").val()
    ciphertext= encrypt(plainText)
    $("#mixed").val(ciphertext)
    real= decrypt(ciphertext)
    $("#third").val(real)


  txt= "All the speeches and commentaries betray a gigantic abreaction to the event itself and to the fascination that it exerts. Moral condemnation and the sacred union against terrorism are equal to the prodigious jubilation engendered by witnessing this global superpower being destroyed; better, by seeing it more or less self-destroying, even suiciding spectacularly. Though it is (this superpower) that has, through its unbearable power, engendered all that violence brewing around the world, and therefore this terrorist imagination which -- unknowingly -- inhabits us all."

  $("#main").oj(
    div ->
      h= window.innerHeight - 80
      h2 ->
        "Frowwn"
      input {
        id:"password"
        type:"text"
        value:"password"
        style:"color:grey; font-size:22px; height:30px; border-radius:4px; border:1px solid steelblue;"
        keyup:->
         change_text()
      }
      table {
        style:"width:100%; height:#{h}px; "
      },->
        tr {
        style:"width:100%; height:100%; "
          },->
            td ->
              textarea {
                id:"text"
                style:"width:100%; height:#{h}px; font-size:22px;"
                keyup: ->
                  encrypt()
              },->
                txt
            td ->
              textarea {
                id:"mixed"
                style:"width:100%; height:#{h}px; font-size:22px;"
              }
            td ->
              textarea {
                id:"third"
                style:"width:100%; height:#{h}px; font-size:22px;"
              }
    )











