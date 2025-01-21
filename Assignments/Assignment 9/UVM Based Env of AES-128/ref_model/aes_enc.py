from Crypto.Cipher import AES

# Open the file containing the key and data
with open('ref_model/key.txt', 'r') as file:
    data_hex = file.readline().strip()  # Read the data hex string
    key_hex = file.readline().strip()  # Read the key hex string
    
# Convert hex strings to bytes
data = bytes.fromhex(data_hex)
key = bytes.fromhex(key_hex)

# Create a new AES cipher object with the provided key and ECB mode
cipher = AES.new(key, AES.MODE_ECB)

# Encrypt the data
ciphertext = cipher.encrypt(data)

# Write the encrypted data to 'output.txt' as a hex string
with open('ref_model/output.txt', 'w') as file:
    file.write(ciphertext.hex())
