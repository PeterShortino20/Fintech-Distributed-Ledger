rm(list=ls())
library(openssl)
x <- 0 
hashed = sha256("Cesare sends one bitcoin to Shimon")
previous = "85738f8f9a7f1b04b5329c590ebcb9e425925c6d0984089c43a022de4f19c281"
time = "2018-01-07 21:05:34"
bits = "3"

nonce = 0

addedHash =paste(previous, hashed, time, bits, nonce, sep = '')
hashednew = sha256(addedHash)
hashednew


while(substring(hashednew, 1, 3) != "000")
{
  nonce = nonce + 1
  addedHash =paste(previous, hashed, time, bits, nonce, sep = '')
  hashednew = sha256(addedHash)
}

substring(hashednew, 1, 3) 

##Hash
print(hashednew) ##"0002e45348cfda08a013a5e8638c32a09a1b465feac10b8ca9f79f3412f9cfb9"
##Nonce
print(nonce) #4692
print("The nonce is 4692 & the Hash is 0002e45348cfda08a013a5e8638c32a09a1b465feac10b8ca9f79f3412f9cfb9")





