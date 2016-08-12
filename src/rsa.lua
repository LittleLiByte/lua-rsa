--
-- Created by IntelliJ IDEA.
-- User: LittleByte
-- Date: 2016/8/8
-- Time: 17:54
-- To change this template use File | Settings | File Templates.
--
module("rsa", package.seeall)
local ffi = require('ffi')

local rsa = ffi.load('rsa')

ffi.cdef [[
int public_encrypt(unsigned char * data,int data_len,unsigned char * key, unsigned char *encrypted);
int private_decrypt(unsigned char * enc_data,int data_len,unsigned char * key, unsigned char *decrypted);

int private_encrypt(unsigned char * data,int data_len,unsigned char * key, unsigned char *encrypted);
int public_decrypt(unsigned char * enc_data,int data_len,unsigned char * key, unsigned char *decrypted);
]]

local _M = { _VERSION = '1.0' }

--公钥加密
function _M.public_encrypt(msg, publicKey)
    local c_str = ffi.new("char[?]", 1024 / 8)
    ffi.copy(c_str, msg)
    local pub = ffi.new("char[?]", #publicKey)
    ffi.copy(pub, publicKey)
    --存放加密结果
    local encrypt = ffi.new("char[?]", 2048)
    local ret = rsa.public_encrypt(c_str, #msg, pub, encrypt)
    if ret == -1 then
        return nil
    end
    return ffi.string(encrypt,ret)
end

--私钥解密
function _M.private_decrypt(msg, privateKey)
    local c_str = ffi.new("char[?]", 1024 / 8)
    ffi.copy(c_str, msg)
    local pri = ffi.new("char[?]", #privateKey)
    ffi.copy(pri, privateKey)
    --存放解密结果
    local decrypt = ffi.new("char[?]", 2048)
    local ret = rsa.private_decrypt(c_str, #msg, pri, decrypt)
    if ret == -1 then
        return nil
    end
    return ffi.string(decrypt,ret)
end

--私钥加密
function _M.private_encrypt(msg, privateKey)
    local c_str = ffi.new("char[?]", 1024 / 8)
    ffi.copy(c_str, msg)
    local pri = ffi.new("char[?]", #privateKey)
    ffi.copy(pri, privateKey)
    --存放加密结果
    local encrypt = ffi.new("char[?]", 2048)
    local ret = rsa.private_encrypt(c_str, #msg, pri, encrypt)
    if ret == -1 then
        return nil
    end
    return ffi.string(encrypt,ret)
end

--公钥解密
function _M.public_decrypt(msg, publicKey)
    local c_str = ffi.new("char[?]", 1024 / 8)
    ffi.copy(c_str, msg)
    local pub = ffi.new("char[?]", #publicKey)
    ffi.copy(pub, publicKey)
    --存放解密结果
    local decrypt = ffi.new("char[?]", 2048)
    local ret = rsa.public_decrypt(c_str, #msg, pub, decrypt)
    if ret == -1 then
        return nil
    end
    return ffi.string(decrypt,ret)
end

return _M



