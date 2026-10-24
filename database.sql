-- Optional MySQL database setup. Run this in MySQL Workbench as an administrator.
CREATE DATABASE IF NOT EXISTS govnexus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- Recommended: create a dedicated user and grant access rather than using root.
-- CREATE USER 'govnexus_user'@'localhost' IDENTIFIED BY 'replace-with-a-strong-password';
-- GRANT ALL PRIVILEGES ON govnexus.* TO 'govnexus_user'@'localhost';
-- FLUSH PRIVILEGES;
-- SQLAlchemy creates tables automatically when you start the Flask application.
