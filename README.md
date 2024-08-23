# obsidian-foldertree

A Bash script that generates markdown files listing all `.md` files in each first-level directory within a specified directory. This is particularly useful for organizing and navigating large Obsidian vaults by creating an index of markdown files.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Options](#options)
- [Examples](#examples)
- [License](#license)
- [Contributing](#contributing)

## Installation

### Clone the Repository

To get started, clone this repository to your local machine:

```bash
git clone https://github.com/beecave-homelab/obsidian-foldertree.git
cd obsidian-foldertree
```

### Make the Script Executable

Ensure the script is executable:

```bash
chmod +x obsidian-foldertree.sh
```

## Usage

The script can be used to create markdown files that list all `.md` files in each first-level directory within a specified directory.

```bash
./obsidian-foldertree.sh [OPTIONS]
```

## Options

- `-d, --directory DIRECTORY`: Specify the directory to process (default: current working directory).
- `-o, --output OUTPUT_FILE`: Specify the output file path (default: derived from directory name and placed in the directory).
- `-v, --verbose`: Print the output content instead of saving it to a file.
- `-b, --bypass-confirm`: Bypass the confirmation step before saving the file.
- `-h, --help`: Show the help message with usage instructions.

## Examples

### Generate Markdown Files

To generate markdown files in the specified directory and confirm before saving:

```bash
./obsidian-foldertree.sh -d '/path/to/your/obsidian/vault'
```

### Verbose Mode

To print the content that would be written to the markdown files instead of saving them:

```bash
./obsidian-foldertree.sh -d '/path/to/your/obsidian/vault' -v
```

### Specify Output File

To specify a custom output file and bypass the confirmation step:

```bash
./obsidian-foldertree.sh -d '/path/to/your/obsidian/vault' -o '/path/to/output.md' -b
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue to discuss what you would like to change.

For major changes, please open an issue first to discuss what you would like to change.

---

Created by [elvee](https://github.com/beecave-homelab).
