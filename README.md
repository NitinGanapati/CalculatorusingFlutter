# Calci

A Flutter-based calculator application that evaluates mathematical expressions using the Shunting-yard algorithm logic.

## Features

- **Basic Arithmetic**: Perform addition, subtraction, multiplication, and division.
- **Parentheses Support**: Handles complex expressions with brackets for correct order of operations.
- **Postfix Evaluation**: Uses a custom-built expression parser and evaluator that converts infix notation to postfix (Reverse Polish Notation) for reliable results.
- **Clean UI**: A simple grid-based interface with responsive buttons and expression displays.
- **Floating Point Support**: Performs calculations with decimal precision.

## How it Works

The application logic is split into two main parts:

1.  **UI (`lib/main.dart`)**: Built with a `GridView` to display buttons for digits and operators. It maintains the current expression as a string and updates the display in real-time.
2.  **Engine (`lib/Calculator.dart`)**:
    - `splitter`: Tokenizes the input string into numbers and operators.
    - `Calculation`: Converts the tokens into Postfix notation using operator precedence and then evaluates the stack to produce the final result.

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio / VS Code with Flutter extension

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/calci.git
   ```
2. Navigate to the project directory:
   ```bash
   cd calci
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Screenshots

*(Add screenshots of your app here)*

## Project Structure

- `lib/main.dart`: Contains the `MyHomePage` widget and UI layout.
- `lib/Calculator.dart`: Contains the core mathematical logic for expression parsing and evaluation.
