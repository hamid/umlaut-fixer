# umlaut-fixer
This script addresses(find and replace) a common but often overlooked issue in text processing: the distinction between combining umlauts and precomposed umlauts

## Overview
Combining umlauts consist of a base letter followed by a diacritic mark, representing characters like "ü". In contrast, precomposed umlauts, such as "ü", combine both elements into a single character. This subtle difference can lead to inconsistencies in text formatting and searching, particularly in environments that do not uniformly support combining characters.

![image](https://github.com/hamid/umlaut-fixer/assets/1645233/30b36e3a-c34b-4cb2-ab9e-326bc4a53372)


## Potential Problems
Inconsistent Formatting: Some systems may apply text styles (like bold or italic) only to the base character, leaving the diacritic mark unchanged.
Search and Match Issues: Searching for a specific character may yield incomplete results if the search query does not account for both umlaut types.
Encoding and Compatibility: Diverse encoding standards may treat these characters differently, leading to potential data loss or corruption when transferring text between systems.
```
1) ü = 1 character 

2) ü = 2 character -> u + ¨
```

### How to fix that? 
1. You can easily find the "ü" and replace it with "ü" and also for the other umlaut-based character.
2. Use this script to run it manually or run it automatically in your pipeline.

## Features
- *Dual Mode Operation*: Offers both 'find' and 'replace' modes to identify occurrences of combining umlauts and convert them into their precomposed counterparts.
- *Recursive Path Search*: Scans files recursively within the specified directory, ensuring comprehensive coverage.
- *Exclusion of Specific Directories*: Automatically ignores directories such as node_modules, preventing unnecessary processing of irrelevant files.
- *Cross-Platform Compatibility*: Designed to run on Linux, macOS, and Windows (via WSL), catering to a wide range of environments and use cases.

<img width="538" alt="image" src="https://github.com/hamid/umlaut-fixer/assets/1645233/9fdf2e2b-f2f0-48c5-b74c-fbec3cb994d2">


## Installation and Running
### Linux/macOS
Download the script file, umlaut_fixer.sh
Make the script executable:
```
chmod +x umlaut_fixer.sh
```
Run the script interactively:
```
./umlaut_fixer.sh
```
### Windows
For Windows users, running the script requires the Windows Subsystem for Linux (WSL). Install WSL, navigate to the directory containing the script, and follow the Linux/macOS instructions above.

## Non-Interactive Mode (CI/CD Mode)
The script supports a non-interactive mode for seamless integration into CI/CD pipelines or for automation purposes. To use this feature, you can pass command-line arguments to the script:

To perform a replacement operation without interactive prompts, use:
```
./umlaut_fixer.sh -r /path/to/directory
```
This mode is particularly useful for automated text processing tasks, where manual intervention is impractical or impossible.
