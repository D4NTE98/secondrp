# SecondRP

**SecondRP** is a roleplay gamemode for FiveM, designed to provide immersive and secure roleplay experiences. The gamemode comes with features such as account registration/login and built-in anticheat functionality to maintain fair gameplay.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
  - [Account System](#account-system)
  - [Anticheat System](#anticheat-system)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

- **Account Management:**  
  Players can register and log into their accounts. The system verifies email formats and securely stores hashed passwords before inserting them into the database.

- **Anticheat:**  
  The anticheat system monitors player behavior to ensure a fair gaming environment. It checks for unauthorized actions and takes preventive measures when suspicious activity is detected.

## Installation

1. **Download:**  
   Clone or download the **SecondRP** repository into your FiveM resources directory.
   ```bash
   cd resources
   git clone https://github.com/D4NTE98/SecondRP.git
   ```

2. **Database Setup:**  
   Ensure you have a MySQL database configured. Import the provided SQL file (if any) or create the necessary tables manually.  
   Example for accounts:
   ```sql
   CREATE TABLE `accounts` (
       `id` INT AUTO_INCREMENT PRIMARY KEY,
       `email` VARCHAR(255) NOT NULL,
       `password` VARCHAR(255) NOT NULL,
       `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

3. **Dependencies:**  
   Make sure you have [MySQL Async](https://github.com/brouznouf/fivem-mysql-async) or any equivalent dependency properly installed and configured.

4. **Configuration:**  
   Adjust configuration options (if available) in the configuration files provided or directly in the scripts.

5. **Start the Resource:**  
   Add the resource name `SecondRP` to your server configuration (`server.cfg`):
   ```
   start SecondRP
   ```

## Configuration

Edit the configuration files as needed to match your server setup. Key aspects include:
- **Database connection details**: Verify that your MySQL credentials and connection settings are correct.
- **Notification messages**: Customize success and error messages for account operations.
- **Anticheat thresholds**: Configure limits and parameters for anticheat behavior if applicable.

## Usage

### Account System

The **Account System** handles player registration and login. The system performs the following:

- **Registration (`srp:registerAccount`):**
  - **Email Validation:**  
    Uses a function `isValidEmail(email)` to verify that the provided email address is in the correct format.
  - **Password Hashing:**  
    The provided password is hashed using a secure hashing function `HashString(password)` before storage.
  - **Database Insertion:**  
    If validation passes, the script inserts the new account into the database and sends a notification to the player.
  - **Example Event Call:**
    ```lua
    TriggerEvent('srp:registerAccount', 'user@example.com', 'securePassword')
    ```

- **Login (`srp:loginAccount`):**
  - **Password Verification:**  
    The script hashes the entered password and compares it with the stored hash in the database.
  - **Successful Login:**  
    If the credentials match, the player is allowed to log in and receive a success notification.
  - **Example Event Call:**
    ```lua
    TriggerEvent('srp:loginAccount', 'user@example.com', 'securePassword')
    ```

### Anticheat System

The **Anticheat** script is designed to monitor and mitigate cheat attempts in real-time:

- **Monitoring:**  
  The script continuously checks for unauthorized or suspicious player behavior. If irregularities are detected, the anticheat system triggers preventative measures.
- **Preventive Actions:**  
  Actions may include warnings, temporary bans, or notifications to the server administrators.
- **Customization:**  
  The thresholds and specific checks performed can be modified in the script to suit your server’s needs.
- **Example Usage:**  
  The anticheat functionality is automatically integrated. Administrators can monitor logs and take manual actions if necessary.

## Customization

**SecondRP** is highly customizable:
- **Scripts:**  
  Modify the Lua files (`accounts.lua` and `anticheat.lua`) to add or adjust functionality.
- **UI/Notifications:**  
  Customize client-side notifications (see `srp:showNotification`) to match your server's style.
- **Database Schema:**  
  Adjust the SQL schema to include additional account fields or logs if needed.

## Troubleshooting

- **Account Registration Issues:**  
  Verify that your email validation logic in `isValidEmail(email)` is working as intended and that your database is properly connected.
- **Login Failures:**  
  Check that password hashing via `HashString(password)` is consistent between registration and login.
- **Anticheat Alerts:**  
  Review your server logs for details about anticheat triggers. Adjust thresholds in the script if false positives occur.
- **General Debugging:**  
  Use the built-in notification system (`srp:showNotification`) to diagnose issues. Confirm that dependencies (e.g., MySQL Async) are installed correctly.

## Contributing

We welcome contributions to improve **SecondRP**! To contribute:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a Pull Request.

Please follow the coding style and document your changes clearly.

## License

**SecondRP** is open-sourced software licensed under the [MIT License](LICENSE).

## Contact

For further inquiries or support, please contact:
- **Author:** D4NTE98
- **GitHub:** [Your GitHub Profile](https://github.com/D4NTE98)
