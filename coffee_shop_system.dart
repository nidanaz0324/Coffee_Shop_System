import 'dart:io';

List<Map<String, dynamic>> customers = [];
List<Map<String, dynamic>> admin = [
  {'username': 'admin', 'password': 'admin123'},
];
Map<String, double> menu = {
  'Coffee': 2.5,
  'Tea': 2.0,
  'Muffin': 1.75,
  'Croissant': 2.0,
  'Cappuccino': 3.0,
  'Latte': 3.5,
  'Expresso': 2.75,
  'Americano': 4.0,
  'Mocha': 3.25
};
void main() {
  print("========= Welcome to the Coffee Shop Management System =========");
  bool isContinue = true;
  while (isContinue) {
    print("Are you an admin or a customer?");
    print("1. Admin");
    print("2. Customer");
    print("3. Exit");
    int choice = getUserChoice();
    if (choice == 1) {
      if (adminSignIn()) {
        adminMenu();
      }
    } else if (choice == 2) {
      if (customerSignIn()) {
        customerMenu();
      } else {
        stdout.write("Do you want to sign up? (y/n): ");
        String signUpChoice = stdin.readLineSync()!.toLowerCase();
        if (signUpChoice == 'y') {
          customerSignUp();
          customerMenu();
        }
      }
    } else if (choice == 3) {
      isContinue = false;
    } else {
      print("Invalid option! please try again");
    }
  }
}

int getUserChoice() {
  stdout.write("Enter your choice: ");
  int input = int.parse(stdin.readLineSync()!);
  return input;
}

void customerMenu() {
  print("Welcome to coffee shop");
  bool isContinue = true;
  while (isContinue) {
    print("1. Display Menu");
    print("2. Place Order");
    print("3. Sign Out");
    print("4. Exit");
    int choice = getUserChoice();
    if (choice == 1) {
      displayMenu(menu);
    } else if (choice == 2) {
      placeOrder(menu);
    } else if (choice == 3) {
      signOut();
      isContinue = false;
    } else if (choice == 4) {
      isContinue = false;
    } else {
      print("Invalid option! Please try again.");
      customerMenu();
    }
  }
}

void adminMenu() {
  print("Welcome Admin");
  bool isContinue = true;
  while (isContinue) {
    print("1. Add Item");
    print("2. Display Menu");
    print("3. Remove Item");
    print("4. Sign Out");
    print("5. Exit");
    int choice = getUserChoice();
    if (choice == 1) {
      addItem(menu);
    } else if (choice == 2) {
      displayMenu(menu);
    } else if (choice == 3) {
      removeItem(menu);
    } else if (choice == 4) {
      signOut();
      isContinue = false;
    } else if (choice == 5) {
      isContinue = false;
    } else {
      print("Invalid option! Please try again.");
      adminMenu();
    }
  }
}

void addItem(Map<String, double> menu) {
  stdout.write("Enter the item name: ");
  String item = stdin.readLineSync() ?? '';
  stdout.write("Enter the item price: ");
  double price = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  menu[item] = price;
  print("Item '$item' added to the menu.");
}

void displayMenu(Map<String, double> menu) {
  print("Menu Items:");
  for (var entry in menu.entries) {
    print("${entry.key}: \$${entry.value}");
  }
}

void placeOrder(Map<String, double> menu) {
  Map<String, int> order = {};
  double total = 0.0;
  stdout.write("Enter your name: ");
  String customerName = stdin.readLineSync()!;
  bool isContinue = true;
  while (isContinue) {
    stdout.write("Enter the item name (or 'done' to finish): ");
    String item = stdin.readLineSync() ?? '';
    if (item.toLowerCase() == 'done') {
      break;
    } else if (!menu.containsKey(item)) {
      print("Item not found in the menu. Please try again.");
      continue;
    }

    stdout.write("Enter the quantity: ");
    int quantity = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    if (quantity <= 0) {
      print("Invalid quantity. Please try again.");
      continue;
    }

    order[item] = quantity;
    total += menu[item]! * quantity;
  }

  print("Order Summary:");
  print("Customer Name:  $customerName");
  for (var entry in order.entries) {
    print(
        "${entry.key}: ${entry.value} x \$${menu[entry.key]!} = \$${menu[entry.key]! * entry.value}");
  }
  print("Total: \$${total}");
  print("Thank you, $customerName! Your order has been placed.");
}

bool customerSignIn() {
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;
  stdout.write("Password: ");
  String password = stdin.readLineSync()!;
  for (var customer in customers) {
    if (customer['name'] == name && customer['password'] == password) {
      print("Welcome back, $name!");
      return true;
    }
  }
  print("You are not registered! Please sign up first.");
  return false;
}

void customerSignUp() {
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;
  stdout.write("Password: ");
  String password = stdin.readLineSync()!;
  for (var customer in customers) {
    if (customer['name'] == name) {
      print("Customer already exists! Please sign in.");
      return;
    }
  }
  customers.add({'name': name, 'password': password});
  print("Welcome, $name! You are now registered.");
}

bool adminSignIn() {
  stdout.write("Enter admin username: ");
  String username = stdin.readLineSync()!;
  stdout.write("Enter admin password: ");
  String password = stdin.readLineSync()!;
  for (var admin in admin) {
    if (admin['username'] == username && admin['password'] == password) {
      print("Welcome, Admin!");
      return true;
    }
  }
  print("Invalid Admin! Please try again.");
  return false;
}

bool signOut() {
  print("Signing out.");
  return false;
}

void removeItem(Map<String, double> menu) {
  stdout.write("Enter the item name to remove: ");
  String item = stdin.readLineSync() ?? '';

  if (menu.containsKey(item)) {
    menu.remove(item);
    print("Item '$item' removed from the menu.");
  } else {
    print("Item '$item' not found in the menu.");
  }
}
