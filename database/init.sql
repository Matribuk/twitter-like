CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    nickname VARCHAR(255) NOT NULL UNIQUE,
    url_image VARCHAR(255) DEFAULT 'https://avatarfiles.alphacoders.com/370/370782.jpg',
    password VARCHAR(255) NOT NULL
);

CREATE TABLE chats (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (email, nickname, password)
VALUES ('admin@example.com', 'administrator', 'admin123');

INSERT INTO chats (user_id, message)
VALUES (1, 'Hello, world!');
