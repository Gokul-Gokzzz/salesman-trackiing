import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:salesman/controller/expense_controlelr.dart';
import 'package:salesman/controller/expenses_type_controller.dart';
import 'package:salesman/model/add_expence_model.dart';
import 'package:salesman/model/order/expenses_type_model.dart';
import 'package:salesman/view/app_base_screen/view/expenses/expenses_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  // String? selectedValue = 'Option 1';
  Future<void> _fetchExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId = prefs.getString('id');

    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Salesman ID not found")));
      return;
    }

    log("✅ Salesman ID: $salesmanId");
    await context.read<ExpenseController>().loadExpenses(salesmanId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchExpenses(); // Load expenses on init
      context.read<ExpenseTypeController>().loadExpenseTypes();
    });
  }

  // final TextEditingController _expenseTypeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String? _receiptUrl;
  String? _selectedExpenseType;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _receiptUrl = result.files.single.name; // Get file name
      });
    } else {
      // User canceled the picker
      setState(() {
        _receiptUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseController = context.watch<ExpenseController>();
    final expenses = expenseController.expenses;
    final isLoading = expenseController.isLoading;
    final expenseTypeController = context.watch<ExpenseTypeController>();
    // final expenseTypes = expenseTypeController.expenseTypes;
    final expenseTypesLoading = expenseTypeController.isLoading;

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: RefreshIndicator(
        onRefresh: _fetchExpenses,
        child: Column(
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
                      "Expenses",
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
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                      const Text(
                        "Add Expense",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 3,
                        width: 66.02,
                        decoration: BoxDecoration(
                            color: const Color(0XFF094497),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 30.75,
                      ),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: const Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              // expenseTypesLoading
                              //     ? const CircularProgressIndicator()
                              Consumer<ExpenseTypeController>(
                                builder: (context, value, child) {
                                  if (expenseTypesLoading) {
                                    return const CircularProgressIndicator();
                                  }
                                  return DropdownButtonFormField<String>(
                                    value: _selectedExpenseType,
                                    hint: const Text("Select Expense Type"),
                                    items: value.expenseTypes
                                        .map((type) => DropdownMenuItem(
                                              value: type.name,
                                              child: Text(type.name.toString()),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      log("Dropdown onChanged called with value: $value");
                                      setState(() {
                                        _selectedExpenseType = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: "Expense Type:",
                                      border: OutlineInputBorder(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Amount:",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _noteController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  labelText: "Note",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Upload Receipt:",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: const Color(0XFF999999))),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 22,
                                      // width: 91,
                                      decoration: BoxDecoration(
                                          // color: const Color(0XFFD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          ElevatedButton(
                                            onPressed: _pickFile,
                                            child: Text(
                                              "Choose File",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Icon(
                                          //   Icons.file_upload_outlined,
                                          //   color: Colors.black,
                                          //   size: 12,
                                          // )
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   width: ,
                                    // ),
                                    Text(
                                      _receiptUrl ?? "No file chosen",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.14,
                                          color: Color(0XFF6D6D6D)),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_selectedExpenseType == null ||
                                        _amountController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please fill in all required fields")));
                                      return;
                                    }
                                    final amount =
                                        int.tryParse(_amountController.text) ??
                                            0;
                                    final notes = _noteController.text;
                                    final receiptUrl = _receiptUrl ?? "";
                                    await expenseController.submitExpense(
                                      expenseType: _selectedExpenseType ??
                                          '', // Use selected expense type
                                      amount: amount,
                                      notes: notes,
                                      receiptUrl: receiptUrl,
                                      status: "pending",
                                    );
                                    if (expenseController.errorMessage ==
                                        null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Expense submitted successfully!")));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(expenseController
                                                  .errorMessage!)));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF094497),
                                      elevation: 0),
                                  child: const Text(
                                    "Submit Expense",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.14),
                                  )),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      const Text(
                        "Expense History:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SearchBar(
                        elevation: WidgetStatePropertyAll(0),
                        hintText: "Search by amount or Type",
                        leading: Icon(Icons.search),
                        onChanged: (query) =>
                            expenseController.updateSearchQuery(query),
                      ),
                      // TextField(
                      //   onChanged: (query) => expenseController.updateSearchQuery(query),
                      //   decoration: InputDecoration(
                      //     labelText: "Search Expenses",
                      //     prefixIcon: Icon(Icons.search),
                      //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : expenses.isEmpty
                              ? const Center(
                                  child: Text('No expenses recorded.'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: expenses.length,
                                  itemBuilder: (context, index) {
                                    final expense = expenses[index];
                                    return GestureDetector(
                                        onTap: () async {
                                          bool? updated = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ExpenseDetailsScreen(
                                                      expense: expense),
                                            ),
                                          );

                                          if (updated == true) {
                                            await _fetchExpenses(); // Refresh UI
                                          }
                                        },
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Date: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    Text(
                                                      expense.createdAt != null
                                                          ? "${expense.createdAt!.day}-${expense.createdAt!.month}-${expense.createdAt!.year}"
                                                          : "N/A",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Amount: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    Text(
                                                      "₹${expense.amount ?? "N/A"}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Type: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    Text(
                                                      expense.expenseType ??
                                                          "N/A",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Notes: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        expense.notes ?? "N/A",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                        ),
                                                        maxLines: null,
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const Divider(),
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
