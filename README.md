## 前言说明
基于openresty下的一个RSA加解密库.由于之前使用的lua-resty-rsa项目只支持**公钥加密私钥解密**,对**私钥加密公钥解密**不支持(因为项目需要).因此在寻找多方资料后,找到了一个C语言版本实现的代码(详见rsa.c文件，基于openssl.rsa).之后将其编译成动态链接库(src目录下的librsa.so),再通过ffi调用。src目录下的rsa.lua封装了ffi调用,在加解密的时候直接传入待加解密的string和对应的公私钥即可.


## 使用说明
* ubuntu系统下,将librsa.so放到usr/lib目录中,你也可以放置到你想要的目录,不过那就需要做相应的设置,这里不做叙述.

* 因为只在ubuntu系统下测试使用过，在其他系统可能会出一些问题，所以如果有问题最好重新编译生成自己系统下的so库，然后再引用。这里也感谢各位的问题反馈。

* 将rsa.lua放到openresty工作目录的lualib/resty目录下

* 在需要使用的地方通过 **require "resty.rsa"** 导入

* rsa.lua目前提供了4个API,分别是:  

　　**公钥加密**：public_encrypt(msg, publicKey)  
　　**私钥解密**：private_decrypt(msg, privateKey)  
　　**私钥加密**：private_encrypt(msg, privateKey)  
　　**公钥解密**：public_decrypt(msg, publicKey)  

## 测试说明
test目录下有两个测试文件，分别是**rsatest.lua**和**rsatest1.lua**。
其中，**rsatest.lua**是直接通过ffi调用C的api进行加解密，
**rsatest1.lua**则是使用封装好的rsa.lua。

写了一篇这个库制作到使用的一篇说明文章，如果有兴趣可以查看：[传送门](http://little-byte.com/2016/08/20/openresty-rsa%E5%8A%A0%E8%A7%A3%E5%AF%86%E5%BA%93/)
