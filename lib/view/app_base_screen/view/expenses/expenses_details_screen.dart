import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/expense_controlelr.dart';
import 'package:salesman/model/expense_model.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final expenseController =
        Provider.of<ExpenseController>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 318,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/expense_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Expense Details",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 15,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset("assets/images/backbutton.svg"),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30.75),
                    const Text(
                      "Expense Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 3,
                      width: 66.02,
                      decoration: BoxDecoration(
                        color: const Color(0XFF094497),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 30.75),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: const Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow("Date:",
                                "${expense.createdAt!.day}-${expense.createdAt!.month}-${expense.createdAt!.year}"),
                            _buildDetailRow("Amount:", "₹${expense.amount}"),
                            _buildDetailRow(
                                "Type:", expense.expenseType.toString()),
                            _buildDetailRow("Notes:", expense.notes.toString()),
                            _buildDetailRow(
                                "Status:", expense.status.toString()),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () =>
                      _showEditBottomSheet(context, expenseController, expense),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label:
                      const Text("Edit", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton.icon(
                  onPressed: () => _confirmDelete(
                      context, expenseController, expense.id.toString()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                  ),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text("Delete",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0XFF094497))),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  void _showEditBottomSheet(
      BuildContext context, ExpenseController controller, Expense expense) {
    TextEditingController amountController =
        TextEditingController(text: expense.amount.toString());
    TextEditingController notesController =
        TextEditingController(text: expense.notes);
    TextEditingController expensesTypeController =
        TextEditingController(text: expense.expenseType);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: expensesTypeController,
                  decoration: const InputDecoration(labelText: "Expense Type"),
                ),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: "Notes"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> updatedData = {
                      "expenseType": expensesTypeController.text,
                      "amount": int.tryParse(amountController.text) ?? 0,
                      "notes": notesController.text,
                    };

                    bool success = await controller.updateExpense(
                        context, expense.id.toString(), updatedData);

                    if (success) {
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Failed to update expense")),
                      );
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, ExpenseController expenseController,
      String expenseId) async {
    bool deleted = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this expense?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              await expenseController.deleteExpense(context, expenseId);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
