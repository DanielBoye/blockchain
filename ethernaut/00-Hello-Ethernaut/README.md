# Hello Ethernaut

I start of with calling 
```javascript
await contract.info() 
```
to get some info on the challenge.


```javascript
'You will find what you need in info1().'
```

Hmh, okay. So I then call `info1()`
```javascript
await contract.info1()
```
```javascript
'Try info2(), but with "hello" as a parameter.'
```

Then I call `info2m` with `"hello"` as a parameter
```javascript
await contract.info2("hello")
```
```javascript
'The property infoNum holds the number of the next info method to call.'
```

Calling `infoNum` then
```javascript
await contract.infoNum()
```
```javascript
i {negative: 0, words: Array(2), length: 1, red: null}
    length: 1
    negative: 0
    red: null
    words: Array(2)
        0: 42
        length: 2
```

From here I see that we have the number `42` stored. So from there I want to get the info on this number. I call `info42()`
```javascript
await contract.info42()
```
```javascript
'theMethodName is the name of the next method.'
```

Call `theMethodName()`
```javascript
await contract.theMethodName()
```
```javascript
'The method name is method7123949.'
```

Call `method7123949()`
```javascript
await contract.method7123949()
```
```javascript
'If you know the password, submit it to authenticate().'
```

We need to authenticate a password. Lets try and find it then!

My first instinct was to try and see if the contract had any public password, and yes it does!
```solidity 
string public password;
```
So lets try to call it
```javascript
await contract.password()
```
```javascript
'ethernaut0'
```

That looks promising. Now lets authenticate with `authenticate()`
```javascript
await contract.authenticate("ethernaut0")
```
Now confirm the Metamask transaction and wait until the tx is sent and mined

You should now see something like this: 
```
^⨀ᴥ⨀^ Submitting level instance... <  < <<PLEASE WAIT>> >  >
 ⛏️ Sent transaction ⛏ https://sepolia.etherscan.io/tx/
⛏️ Mined transaction ⛏ https://sepolia.etherscan.io/tx/
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
ˁ(⦿ᴥ⦿)ˀ Well done, You have completed this level!!!
```

gg
