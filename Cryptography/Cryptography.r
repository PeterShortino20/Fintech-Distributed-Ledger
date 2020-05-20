rm(list = ls())
library("openssl")

## We are going to create a public key (n and e) and a private key(d) ####
## Assign Prime Numbers ###

p = bignum("112481050639317229656723018120659623829736571015511322021617837187076258724819")
q = bignum("89185111938335771293328323333111422985697062149139368049232365065924632677343")

##Public Keys###

n = p*q
print(n)

e = bignum("65537")

###Private Keys###

d = bignum_mod_inv(e, (p-1)*(q-1))

### GRADER ATTENTION: Following command has been commented out because "Private Key Info" Please uncomment if needed ###
#print(d)

m=bignum(charToRaw("Bitcoin is a vehicle of freedom")) 
print(m)

c = bignum_mod_exp(m,e,n)
### GRADER ATTENTION: Following command has been commented out because "Private Message Payload" Please uncomment if needed ###
#print(c)

c_encoded = base64_encode(c)
### GRADER ATTENTION: Following command has been commented out because "Private Message Payload" Please uncomment if needed ###
#print(c_encoded)

### This section of the code will decode the information into a readable form ###
c_decoded = bignum(base64_decode("rGhkBLUmPQStyYGrhIcNxnhZw6GeGoFGswZuUihd+kPx21VtPSMmdBRQOkKw8uLPhsh0NV4qk27G/EFuVT2iAw=="))
m3 = bignum_mod_exp(c_decoded,d,n)
m3_char = rawToChar(m3)
print(m3_char)

m_hash = sha256(m3_char)
print(m_hash)

hashed_num = bignum(charToRaw(m_hash))
print (hashed_num)

s = bignum_mod_exp(hashed_num,d,n)

### Verify ###
m_verif = bignum_mod_exp(s,e,n)
print(m_verif)


## Simple logic test if the signature was the same and valid ###
if (m_verif == hashed_num)
  print("Success: The Signature Is Valid!") 


