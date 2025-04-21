#!/bin/bash

# Default values
input_file=""
output_dir=""
output_file=""
append_output=true  # Default behavior is to append to a single file
separate_output=false

# Help function
usage() {
  echo ""
  echo "Usage: $0 -f <input_file> -o <output_directory> [-aO | -sO]"
  echo ""
  echo "Options:"
  echo "  -f <file>         Path to input file containing domain list"
  echo "  -o <directory>    Output directory to save fetched URLs"
  echo "  -aO               Append all URLs to a single file (default)"
  echo "  -sO               Save URLs to separate files"
  echo "  -h                Show this help message and exit"
  echo ""
  echo "Example:"
  echo "  $0 -f active_domains/Active_Domains.txt -o waybackurl/ -sO"
  echo ""
  exit 1
}

# Parse arguments
while getopts ":f:o:aOs:h" opt; do
  case ${opt} in
    f )
      input_file="$OPTARG"
      ;;
    o )
      output_dir="$OPTARG"
      ;;
    aO )
      append_output=true
      separate_output=false
      ;;
    sO )
      separate_output=true
      append_output=false
      ;;
    h )
      usage
      ;;
    \? )
      echo "❌ Invalid option: -$OPTARG"
      usage
      ;;
    : )
      echo "❌ Option -$OPTARG requires an argument."
      usage
      ;;
  esac
done

# If required arguments are missing
if [[ -z "$input_file" || -z "$output_dir" ]]; then
  echo "❌ Missing required arguments."
  usage
fi

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Determine output file for appending (if -aO is selected)
if $append_output; then
  output_file="$output_dir/all_urls.txt"
fi

# Process domains
while read -r domain; do
  if [ -n "$domain" ]; then
    # Sanitize the domain name to remove http://, https://, and any slashes
    safe_domain=$(echo "$domain" | sed 's~http[s]*://~~g' | tr -d '/')
    
    echo "[+] Fetching URLs for: $domain"
    
    # Fetch URLs using gau
    if $append_output; then
      # Append to a single file if -aO is used (default)
      gau "$domain" >> "$output_file"
    elif $separate_output; then
      # Save to separate files if -sO is used
      gau "$domain" > "$output_dir/${safe_domain}_urls.txt"
    fi
  fi
done < "$input_file"

echo "[✓] URLs fetching complete."
if $append_output; then
  echo "[✓] All URLs saved to: $output_file"
else
  echo "[✓] URLs saved to respective files in: $output_dir/"
fi
