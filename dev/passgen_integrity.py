#!/usr/bin/env python3
import hashlib
import os
import re
from pathlib import Path

def compute_hash(file_path):
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def update_checksums_in_markdown():
    """Update checksums in the password generator markdown file."""
    files = {
        'password-generator.js': 'docs/assets/javascripts/password-generator.js',
        'foi_words_en.txt': 'docs/tools/password-generator/foi_words_en.txt',
        'foi_words_ka.txt': 'docs/tools/password-generator/foi_words_ka.txt',
        'foi_syllables_en.txt': 'docs/tools/password-generator/foi_syllables_en.txt',
        'foi_syllables_ka.txt': 'docs/tools/password-generator/foi_syllables_ka.txt'
    }
    
    new_checksums = {}
    for name, path in files.items():
        try:
            new_checksums[name] = compute_hash(path)
            print(f"Computed hash for {name}: {new_checksums[name]}")
        except Exception as e:
            print(f"Error processing {name}: {e}")
            return

    md_path = 'docs/tools/password-generator/index.md'
    with open(md_path, 'r', encoding='utf-8') as f:
        content = f.read()
    checksum_pattern = r'const INTEGRITY_CHECKSUMS = \{[^}]+\};'
    
    new_checksums_str = "const INTEGRITY_CHECKSUMS = {\n"
    for name, hash_value in new_checksums.items():
        new_checksums_str += f"  '{name}': '{hash_value}',\n"
    new_checksums_str += "};"

    if re.search(checksum_pattern, content):
        updated_content = re.sub(checksum_pattern, new_checksums_str, content)
        
        with open(md_path, 'w', encoding='utf-8') as f:
            f.write(updated_content)
        print("\nChecksums updated successfully!")
    else:
        print("\nError: Could not find INTEGRITY_CHECKSUMS in the markdown file")

if __name__ == "__main__":
    project_root = Path(__file__).parent.parent
    os.chdir(project_root)
    
    update_checksums_in_markdown()