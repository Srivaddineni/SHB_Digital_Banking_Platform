CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    email VARCHAR2(150) UNIQUE NOT NULL,
    mobile_number VARCHAR2(20) UNIQUE NOT NULL,

    status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'LOCKED')),

    failed_login_attempts NUMBER DEFAULT 0 NOT NULL
        CHECK (failed_login_attempts >= 0),

    locked_until TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE SEQUENCE users_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE TABLE roles (
    role_id NUMBER PRIMARY KEY,
    role_name VARCHAR2(30) UNIQUE NOT NULL
);

CREATE SEQUENCE roles_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE TABLE user_roles (
    user_id NUMBER NOT NULL,
    role_id NUMBER NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);
