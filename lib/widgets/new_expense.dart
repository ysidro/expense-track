import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_track/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpense> {
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue){
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDataPicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() => _selectedDate = pickedDate);
  }

  void _showDialog(){
    if(Theme.of(context).platform == TargetPlatform.iOS){
      showCupertinoDialog(
        context: context, 
        builder: (ctx) => CupertinoAlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              }, 
              child: Text('Okay')
            )
          ],
        )
      );
    } else {
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              }, 
              child: Text('Okay')
            )
          ],
        )
      );
    }
  }
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
       _showDialog();
      return;
    }
    Navigator.pop(context);

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  60,
                  16,
                  keyBoardSpace + 16,
                ), //EdgeInsets.all(25),
                child: Column(
                  children: [
                    if (width >= 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _titleController,
                              maxLength: 50,
                              decoration: InputDecoration(label: Text('Title')),
                            )
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: '\$ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                        ],
                      )
                    else          
          
                      TextField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: InputDecoration(label: Text('Title')),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: '\$ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
          
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'Selected Date'
                                    : formatter.format(_selectedDate!).toString(),
                              ),
                              IconButton(
                                onPressed: _presentDataPicker,
                                icon: const Icon(Icons.calendar_today_outlined),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
          
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text('Save Expenses'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ),
        );
      },
    );
  }
}
