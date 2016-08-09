## 前言说明
基于openresty下的一个RSA加解密库.由于之前使用的lua-resty-rsa项目只支持公钥加密私钥解密,对私钥加密公钥解密不支持(因为项目需要).因此在寻找多方　　资料后,找到了一个C语言版本实现的代码(详见rsa.c文件).之后将其编译成动态链接库(src目录下的librsa.so),再通过ffi调用.src目录下的rsa.lua封装了ffi　　调用,在加解密的时候直接传入待加解密的string和对应的公私钥即可.


## 使用说明
* ubuntu系统下,将librsa.so放到usr/lib目录中,你也可以放置到你想要的目录,不过那就需要做相应的设置,这里不做叙述.

* 将rsa.lua放到openresty工作目录的lualib/resty目录下

* 在需要使用的地方通过 **require "resty.rsa"** 导入

* rsa.lua目前提供了4个API,分别是:
　　**公钥加密**：public_encrypt(msg, publicKey)
　　**私钥解密**：private_decrypt(msg, privateKey)

　　**私钥加密**：private_encrypt(msg, privateKey)
　　**公钥解密**：public_decrypt(msg, publicKey)

## 测试说明
test目录下有两个测试文件，分别是**rsatest.lua**和**rsatest1.lua**。
其中，**rsatest.lua**是直接通过ffi调用C的api进行加解密，完全不会有问题。
**rsatest1.lua**则是使用封装好的rsa.lua。而在rsatest1.lua中，RSA加密完成后返回的是cdata转换而来的字符串，解密的时候再将字符串转为cdata，这其中就会有一些转换导致的问题，可能会导致解密失败。在实际项目中，接口只需要将接收的字符串使用私钥解密就行了，这时候使用rsa.lua这个库是完全没问题的(实际项目中测试通过)。
