local rsa = require "resty.rsa"
local RSA_PUBLIC_KEY = [[-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3bTBJNQJjY6u7Y5b2eOWws0yW
CGuWPm6MGOSVan65wCrJa5p3q3sodQUDVPotjsknjLlje9E1F7Bx94ZuqTwkvAr6
ieLkgbbeqTCzeJ0AryUXiF3auxFSPdpBoD6nxtEeN8bZwfa/IYzdKyKlbhiQbUMN
qWgmxiPVwupwAML7RQIDAQAB
-----END PUBLIC KEY-----]]
local RSA_PRIV_KEY = [[-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQC3bTBJNQJjY6u7Y5b2eOWws0yWCGuWPm6MGOSVan65wCrJa5p3
q3sodQUDVPotjsknjLlje9E1F7Bx94ZuqTwkvAr6ieLkgbbeqTCzeJ0AryUXiF3a
uxFSPdpBoD6nxtEeN8bZwfa/IYzdKyKlbhiQbUMNqWgmxiPVwupwAML7RQIDAQAB
AoGAc4NXvUKc1mqWY9Q75cwNGlJQEMwMtPlsNN4YVeBTHjdeuqoBBQwA62GGXqrN
QpOBKl79ASGghob8n0j6aAY70PQqHSU4c06c7UlkeEvxJKlyUTO2UgnjjIHb2flR
uW8y3xmjpXAfwe50eAVMNhCon7DBc+XMF/paSVwiG8V+GAECQQDvosVLImUkIXGf
I2AJ2iSOUF8W1UZ5Ru68E8hJoVkNehk14RUFzTkwhoPHYDseZyEhSunFQbXCotlL
Ar5+O+lBAkEAw/PJXvi3S557ihDjYjKnj/2XtIa1GwBJxOliVM4eVjfRX15OXPR2
6shID4ZNWfkWN3fjVm4CnUS41+bzHNctBQJAGCeiF3a6FzA/0bixH40bjjTPwO9y
kRrzSYX89F8NKOybyfCMO+95ykhk1B4BF4lxr3drpPSAq8Paf1MhfHvxgQJBAJUB
0WNy5o+OWItJBGAr/Ne2E6KnvRhnQ7GFd8zdYJxXndNTt2tgSv2Gh6WmjzOYApjz
heC3jy1gkN89NCn+RrECQBTvoqFHfyAlwOGC9ulcAcQDqj/EgCRVkVe1IsQZenAe
rKCWlUaeIKeVkRz/wzb1zy9AVsPC7Zbnf4nrOxJ23mI=
-----END RSA PRIVATE KEY-----]]

ngx.say('-----公钥加密私钥解密 start------')
local str='i love lwl'

local encryptPubStr = rsa.public_encrypt(str, RSA_PUBLIC_KEY)
if not encryptPubStr then 
 ngx.say('pub encrypt failed')
end
local decryptPriStr=rsa.private_decrypt(encryptPubStr,RSA_PRIV_KEY)
if not decryptPriStr then 
 ngx.say('pri decrypt failed')
end
ngx.say('公钥加密私钥解密成功\n'..decryptPriStr)
ngx.say('-----公钥加密私钥解密 end------')

ngx.say('================================')

ngx.say('-----私钥加密公钥解密 start------')
local str='i like lwl'

local encryptPriStr = rsa.private_encrypt(str, RSA_PRIV_KEY)
if not encryptPriStr then 
 ngx.say('pri encrypt failed')
end
local decryptPubStr=rsa.public_decrypt(encryptPriStr,RSA_PUBLIC_KEY)
if not decryptPubStr then 
 ngx.say('pub decrypt failed')
end
ngx.say('公钥加密私钥解密成功\n'..decryptPubStr)
ngx.say('-----私钥加密公钥解密 end------')

