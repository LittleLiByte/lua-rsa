local ffi = require('ffi')

local rsa = ffi.load('rsa')

ffi.cdef[[
int public_encrypt(unsigned char * data,int data_len,unsigned char * key, unsigned char *encrypted);
int private_decrypt(unsigned char * enc_data,int data_len,unsigned char * key, unsigned char *decrypted);
 
int private_encrypt(unsigned char * data,int data_len,unsigned char * key, unsigned char *encrypted);
int public_decrypt(unsigned char * enc_data,int data_len,unsigned char * key, unsigned char *decrypted);
]]

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

local text='liwanling'
local c_str = ffi.new("char[?]", 1024/8)
ffi.copy(c_str, text)

local pub = ffi.new("char[?]", #RSA_PUBLIC_KEY)
ffi.copy(pub, RSA_PUBLIC_KEY)
local pri = ffi.new("char[?]", #RSA_PRIV_KEY)
ffi.copy(pri, RSA_PRIV_KEY)

--存放加密结果
local encrypt=ffi.new("char[?]", 2048)
--存放解密结果
local decrypt=ffi.new("char[?]", 2048)

local ret = rsa.public_encrypt(c_str,#text,pub,encrypt)
if ret==-1 then
 ngx.log(ngx.ERR,'public key encrypt failed')
end
local deResult=rsa.private_decrypt(encrypt,ret,pri,decrypt)
if deResult==-1 then
ngx.log(ngx.ERR,"private key decrypt failed")
end
ngx.say("公钥加密私钥解密成功!\n"..ffi.string(decrypt))

ngx.say("--------分割線---------")
local text1='wanlingli'
local c_str1 = ffi.new("char[?]", 1024/8)
ffi.copy(c_str1, text1)
--存放加密结果
local encrypt1=ffi.new("char[?]", 2048)
--存放解密结果
local decrypt1=ffi.new("char[?]", 2048)
local result = rsa.private_encrypt(c_str1,#text1,pri,encrypt1)
if result==-1 then
 ngx.log(ngx.ERR,'private key encrypt failed')
end
local decryptResult=rsa.public_decrypt(encrypt1,result,pub,decrypt1)
if decryptResult==-1 then
ngx.log(ngx.ERR,"public key decrypt failed")
end
ngx.say("私钥加密公钥解密成功!\n"..ffi.string(decrypt1))




