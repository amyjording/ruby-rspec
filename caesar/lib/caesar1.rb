def caesar_cipher (text, shift) #define method and params

az = Array('a'..'z') #create lower case array of alphabet
lcase = Hash[az.zip(az.rotate(shift))] #zip array and rotate by the shift amount into hash

aZ = Array('A'..'Z')
ucase = Hash[aZ.zip(aZ.rotate(shift))] #same as above but with capital letters

cipher = lcase.merge(ucase) #creating new variable to house the merged hashes

text.chars.map { |l| cipher.fetch(l, l) } #funnel text into this block and return shifted characters.

end

p caesar_cipher("Hello, Amy.", 5).join #join brings back to string
p caesar_cipher("I like coffee.", 3).join
p caesar_cipher("I'm Amy!", 2).join
