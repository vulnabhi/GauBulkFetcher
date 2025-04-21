# GauBulkFetcher

**GauBulkFetcher** is a command-line tool designed to **fetch URLs from the Wayback Machine** for multiple domains. It utilizes the `gau` tool to extract URLs, with the flexibility to either append all URLs into one file or store them in separate files for each domain, depending on user preferences.

---

## Features

- **Bulk URL Fetching:** Retrieve URLs for multiple domains using the Wayback Machine.
- **Output File Options:** Save URLs in:
  - **One single file** (default behavior).
  - **Separate files** for each domain.
- **Automated URL Retrieval:** Ideal for bulk URL fetching across a large list of domains.

---

## Installation

1. **Install `gau` Tool:**
    Before using this tool, you need to install the `gau` tool. Run the following command:

    ```bash
    go install github.com/lc/gau/cmd/gau@latest
    ```

    Ensure `gau` is available in your system's `PATH`.

2. **Clone the Repository or Download the Script:**
    - Clone the repository or download the script to your local machine:

      ```bash
      git clone https://github.com/vulnabhi/GauBulkFetcher.git
      cd GauBulkFetcher
      chmod +x GauBulkFetcher.sh
      ```

---

## Usage

### Step 1: Command Syntax

```bash
./GauBulkFetcher.sh -f <domain_list_file> -o <output_directory> [-aO | -sO]
