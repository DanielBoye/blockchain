#!/bin/bash

# Define the directory containing the folders
parent_dir="/mnt/c/Users/danie/Github/blockchain/ethernaut"

# Iterate through the folders
for dir in "$parent_dir"/*-*/; do
  # Extract the folder name without the path
  folder_name=$(basename "$dir")
  
  # Extract the name part after the hyphen
  name="${folder_name#*-}"

  # Create the README.md file with the desired content
  echo "# $name" > "$dir/README.md"
done
