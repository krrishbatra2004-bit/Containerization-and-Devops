def calculate_total(price, tax):
    # Bug: using a variable before it is assigned or wrong logic
    total = price + tax
    return total

def print_user(name):
    # Code smell: unused variable
    unused_var = "This is never used"
    print("Hello " + name)
    
# Vulnerability: Hardcoded password
def connect_to_db():
    password = "super_secret_password_123"
    print("Connecting to database...")

# Code smell: Duplicate code
def calculate_total_again(price, tax):
    total = price + tax
    return total
