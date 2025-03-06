CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(64),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE characters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    dob DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

CREATE TABLE anticheat_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(255),
    type VARCHAR(50),
    details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);