import 'package:app/components/expense_list.dart';
import 'package:app/components/new_expense.dart';
import 'package:app/models/expense_model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _dummyExpenses = [
    Expense(
      title: 'Burger',
      amount: 11.99,
      date: DateTime(2024, 4, 18, 19),
      category: Category.food,
    ),
    Expense(
      title: 'Flight Ticket',
      amount: 1100.99,
      date: DateTime(2024, 4, 17, 00),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => NewExpense(_addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _dummyExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Chart'),
          Expanded(
            child: ExpensesList(_dummyExpenses),
          ),
        ],
      ),
    );
  }
}
