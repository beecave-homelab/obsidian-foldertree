#!/bin/bash
set -euo pipefail

# Script Description: This script generates markdown files listing all .md files in each first-level directory within a specified directory.
# Author: elvee
# Version: 0.1.0
# License: MIT
# Creation Date: 23-08-2024
# Last Modified: 23-08-2024
# Usage: obsidian-foldertree.sh [OPTIONS]

# Constants
DEFAULT_DIRECTORY="."  # Default directory is the current working directory
DEFAULT_OUTPUT_FILE="" # Default output file will be set based on directory and appended with .md
VERBOSE=false          # Default is non-verbose mode

# Function to display help
show_help() {
  echo "
Usage: $0 [OPTIONS]

Options:
  -d, --directory DIRECTORY             Specify the directory to process (default: $DEFAULT_DIRECTORY)
  -o, --output OUTPUT_FILE              Specify the output file path (default: derived from directory name and placed in the directory)
  -v, --verbose                         Print the output content instead of saving it to a file
  -h, --help                            Show this help message

Examples:
  $0 -d '/path/to/directory' -o '/path/to/output.md'
  $0 -d '/path/to/directory' -v
"
}

# Function for error handling
error_exit() {
  echo "Error: $1" >&2
  exit 1
}

# Function for main logic (to be customized for specific script functionality)
main_logic() {
  local directory="$1"
  local output_file="$2"
  local verbose="$3"

  # Check if the directory exists
  if [[ ! -d "$directory" ]]; then
    error_exit "Directory does not exist: $directory"
  fi

  # Find all directories at the first level
  local directories
  IFS=$'\n' directories=($(find "$directory" -maxdepth 1 -type d))

  # Check if there are no subdirectories
  if [[ ${#directories[@]} -le 1 ]]; then
    echo "No subdirectories found in $directory. Skipping."
    return
  fi

  # Loop through each directory
  for dir in "${directories[@]}"; do
    if [[ "$dir" != "$directory" ]]; then
      # Get the base name of the directory (without the path)
      local base_name
      base_name=$(basename "$dir")

      # Set the default output file if not provided
      if [[ -z "$output_file" ]]; then
        output_file="${dir}/${base_name}.md"
      fi

      # Initialize content holder for verbose output
      local content=""

      # Find all .md files in the current directory
      local files
      IFS=$'\n' files=($(find "$dir" -type f -name "*.md" -print))

      # Check if no .md files are found
      if [[ ${#files[@]} -eq 0 ]]; then
        error_exit "No .md files found in directory: $dir"
      fi

      # Append relative file paths to the markdown content
      for file in "${files[@]}"; do
        relative_file="${file#"$directory"/}"
        content+="[[$relative_file]]"$'\n'
      done

      # Verbose mode: Print content instead of writing to file
      if [[ "$verbose" = true ]]; then
        echo "Content for $base_name:"
        echo "$content"
      else
        # Write content to the output file
        echo "$content" > "$output_file"
        echo "File list for $base_name saved to $output_file"
      fi
    fi
  done
}

# Main function to encapsulate script logic
main() {
  # Default values
  local directory="$DEFAULT_DIRECTORY"
  local output_file="$DEFAULT_OUTPUT_FILE"
  local verbose="$VERBOSE"

  # Parse command-line options
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d|--directory)
        directory="$2"
        shift 2
        ;;
      -o|--output)
        output_file="$2"
        shift 2
        ;;
      -v|--verbose)
        verbose=true
        shift
        ;;
      -h|--help)
        show_help
        exit 0
        ;;
      *)
        error_exit "Unknown parameter passed: $1"
        ;;
    esac
  done

  # Call the main logic function with the necessary arguments
  main_logic "$directory" "$output_file" "$verbose"
}

# Execute the main function
main "$@"
