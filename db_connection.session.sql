/*E pos_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(50),
    address TEXT,
    user_type ENUM('ADMIN', 'CUSTOMER') NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE brands (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact VARCHAR(50),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    category_id INT,
    brand_id INT,
    supplier_id INT,
    cost_price DECIMAL(10,2) NOT NULL,
    markup_percentage DECIMAL(5,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    description TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

CREATE TABLE sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    customer_name VARCHAR(100),
    status ENUM('PENDING', 'COMPLETED', 'CANCELLED') DEFAULT 'COMPLETED',
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE sale_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE inventory_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    change_type ENUM('IN', 'OUT', 'ADJUSTMENT') NOT NULL,
    quantity INT NOT NULL,
    previous_stock INT NOT NULL,
    new_stock INT NOT NULL,
    notes TEXT,
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Verification codes table for 2FA
CREATE TABLE verification_codes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    code VARCHAR(6) NOT NULL,
    type ENUM('LOGIN', 'REGISTRATION', 'PASSWORD_RESET') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    is_used BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_code (user_id, code),
    INDEX idx_expires (expires_at)
);

-- Shopping cart for customers
CREATE TABLE cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id)
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, password, full_name, email, user_type) VALUES
('admin', 'admin123', 'System Administrator', 'admin@inventory.com', 'ADMIN');

-- Insert sample customer (password: customer123)
INSERT INTO users (username, password, full_name, email, phone, address, user_type) VALUES
('customer1', 'customer123', 'John Doe', 'john@email.com', '555-1234', '123 Main St', 'CUSTOMER');

-- Insert sample data
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic devices and gadgets'),
('Clothing', 'Apparel and fashion items'),
('Food & Beverages', 'Food and drink products'),
('Books & Media', 'Books, magazines, and media'),
('Home & Garden', 'Home improvement and garden supplies'),
('Sports & Outdoors', 'Sports equipment and outdoor gear');

INSERT INTO brands (name, description) VALUES
('Samsung', 'Electronics manufacturer'),
('Nike', 'Sports and lifestyle brand'),
('Generic', 'Generic brand items'),
('Apple', 'Technology company'),
('Sony', 'Electronics and entertainment'),
('Adidas', 'Sports brand');

INSERT INTO suppliers (name, contact, email, address) VALUES
('Tech Suppliers Inc', '555-0101', 'contact@techsuppliers.com', '123 Tech Street, Silicon Valley'),
('Fashion Wholesale Co', '555-0102', 'info@fashionwholesale.com', '456 Fashion Ave, New York'),
('Food Distributors Ltd', '555-0103', 'sales@fooddist.com', '789 Market Road, Chicago');

-- Sample products with better descriptions
INSERT INTO products (name, category_id, brand_id, supplier_id, cost_price, markup_percentage, selling_price, stock_quantity, description) VALUES
('Smartphone Galaxy S24', 1, 1, 1, 800.00, 25.00, 1000.00, 50, 'Latest Samsung flagship smartphone with advanced features'),
('Running Shoes Air Max', 2, 2, 2, 120.00, 40.00, 168.00, 75, 'Premium running shoes with excellent cushioning'),
('Laptop MacBook Pro', 1, 4, 1, 1500.00, 20.00, 1800.00, 30, 'High-performance laptop for professionals'),
('Wireless Earbuds', 1, 1, 1, 80.00, 50.00, 120.00, 100, 'Bluetooth wireless earbuds with noise cancellation'),
('Cotton T-Shirt', 2, 2, 2, 15.00, 66.67, 25.00, 200, 'Comfortable cotton t-shirt, various colors available'),
('Smart Watch', 1, 4, 1, 250.00, 40.00, 350.00, 60, 'Fitness tracking smart watch with heart rate monitor'),
('Gaming Headset', 1, 5, 1, 60.00, 50.00, 90.00, 80, 'Professional gaming headset with surround sound'),
('Yoga Mat', 6, 2, 2, 20.00, 50.00, 30.00, 120, 'Non-slip yoga mat for exercise and meditation'),
('Backpack', 2, 6, 2, 35.00, 42.86, 50.00, 90, 'Durable backpack with multiple compartments'),
('Water Bottle', 6, 3, 3, 8.00, 62.50, 13.00, 150, 'Insulated stainless steel water bottle');