import os
import sys
from cryptography.fernet import Fernet

def decrypt_file(enc_file_path, key_path):
    with open(key_path, 'rb') as f:
        key = f.read()
    fernet = Fernet(key)

    with open(enc_file_path, 'r') as f:
        lines = f.readlines()

    in_block = False
    result = []
    for line in lines:
        if '//START ENCRYPTON' in line:
            in_block = True
            result.append(line)
            continue
        elif '//END ENCRYPTON' in line:
            in_block = False
            result.append(line)
            continue

        if in_block and line.strip().startswith('//ENC:'):
            enc_data = line.strip()[len('//ENC:'):].strip()
            decrypted = fernet.decrypt(enc_data.encode()).decode()
            result.append(decrypted)
        else:
            result.append(line)
    
    if enc_file_path.endswith('.enc'):
        temp_file = enc_file_path[:-4] + '.tmp'
    else:
        temp_file = enc_file_path + '.tmp'
    
    with open(temp_file, 'w') as f:
        f.writelines(result)

    return temp_file

def decrypt_from_encrypted_list(encrypted_list_file, key_path):
    tmp_files = []

    with open(encrypted_list_file, 'r') as f:
        enc_files = [line.strip() for line in f if line.strip()]

    for enc_file in enc_files:
        key_file = key_path
        if not os.path.isfile(enc_file):
            print(f"[!] Skipping invalid encrypted file: {enc_file}")
            continue
        if not os.path.isfile(key_file):
            print(f"[!] Skipping invalid key file: {key_file}")
            continue
        tmp_file = decrypt_file(enc_file, key_file)
        tmp_files.append(tmp_file)

    return tmp_files

if __name__ == "__main__":
    decrypt_from_encrypted_list(sys.argv[1], sys.argv[2])