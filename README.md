# ShellScriptProject
## 📂 File Search & Mail Notification Script (CentOS 7)
### 🧩 Project Description

  This Bash script automates the process of searching for a specific file or string within a given directory on a CentOS 7 system.
  If the file or content is found, the script:
  
  Displays the search results on the terminal 💻
  
  Sends the results via email ✉️
  
  If no match is found, a “not found” message is both printed and emailed.
  
  Additionally, configuration values such as the search path and email credentials are read from a config.properties file — if it doesn’t exist, the user is prompted to enter them manually.


### ⚙️ Features

  ✅ Search for any file name or string pattern in a directory
  ✅ Read settings dynamically from config.properties or ask via input
  ✅ Send results via email using Gmail SMTP
  ✅ Handles both found and not found cases
  ✅ Secure communication via STARTTLS



### 📁 Project Structure
  shell_script_project/
  │
  ├── search_file.sh         # Main Bash script
  ├── config.properties      # Configuration file (path, pattern, mail settings)
  └── README.md              # Project documentation



### How It Works
  
  The script first checks if a config.properties file exists.
  
  If yes → It reads path, pattern, and mail credentials from it.
  
  If no or empty → It prompts the user to input them manually.
  
  The script uses the find and grep commands to:
  
  Search for files containing the $pattern in their names or contents.
  
  Results are displayed in the terminal.
  
  The results (or “not found” message) are sent via email using mailx.



### ⚙️ Requirements

  Before running the script, make sure:
  You are on CentOS 7.
  
  You have mailx and postfix or sendmail installed.
  You have configured Gmail App Password for secure SMTP access.
  
  Install required packages:
  #sudo yum install mailx postfix -y
  
  Start and enable the mail service:
  #sudo systemctl start postfix
  #sudo systemctl enable postfix



### 📄 Configuration File (config.properties)

  Example:
  
  path=/home/azra/Documents
  pattern=rapor
  mail_to=receiver@gmail.com
  mail_from=sender@gmail.com
  mail_pass=your_app_password_here
  
  
  💡 If this file is missing or empty, the script will ask for these values interactively.

### ▶️ Usage
  Run the script
  chmod +x search_file.sh
  ./search_file.sh

### Example Input/Output

 #### Case 1 – File Found:
  
  [INFO] Arama başlatılıyor: path='/home/azra/Documents' pattern='rapor'
  ✅ Bulunan dosyalar:
    /home/azra/Documents/aylik_rapor.txt
    /home/azra/Documents/2025_rapor.docx
  [MAIL] Gönderildi: receiver@gmail.com
  
  
  #### Case 2 – File Not Found:
  
  [INFO] Arama başlatılıyor: path='/home/azra/Documents' pattern='rapor'
  ❌ 'rapor' içeren veya adında 'rapor' bulunan dosya bulunamadı.
  [MAIL] Bulunamadı bildirimi gönderildi: receiver@gmail.com
