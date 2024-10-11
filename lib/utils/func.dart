import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routine_app/collections/budget.dart';
import 'package:routine_app/collections/expense.dart';
import 'package:routine_app/collections/receipt.dart';
import 'package:routine_app/repository/budget_repository.dart';
import 'package:routine_app/repository/expense_repository.dart';
import 'package:routine_app/repository/receipt_repository.dart';

mixin Func {
  Future<Budget?> createBudget(double amount) async {
    final budget = Budget()
      ..month = DateTime.now().month
      ..year = DateTime.now().year
      ..amount = amount;

    return await BudgetRepository().createObject(budget);
  }

  Future<Budget?> getBudget({required int month, required int year}) async {
    return await BudgetRepository().getObjectByDate(month: month, year: year);
  }

  Future<void> updateBudget(Budget budget) async {
    await BudgetRepository().updateObject(budget);
  }

  Future<void> createExpense(
      double amount,
      DateTime date,
      CategoryEnum cenum,
      String subcat,
      Set<Receipt> receipts,
      List<String> description,
      String paymentMethod) async {
    final subcategory = SubCatgory()..name = subcat;

    final formattedDate = date.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

    for (Receipt receipt in receipts) {
      await ReceiptRepository().createObject(receipt);
    }

    Expense expense = Expense()
      ..amount = amount
      ..date = formattedDate
      ..category = cenum
      ..subCategory = subcategory
      ..description = description
      ..paymentMethod = paymentMethod
      ..receipts.addAll(receipts);

    return await ExpenseRepository().createObject(expense);
  }

  Future<List<Expense>> getTodaysExpenses() async {
    return await ExpenseRepository().getObjectsByToday();
  }

  Future<List<Expense>> getAllExpenses() async {
    return await ExpenseRepository().getAllObjects();
  }

  Future<String> getPath() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }

  Future<List<Receipt>> getAllReceipts() async {
    return await ReceiptRepository().getAllObjects();
  }

  clearData() async {
    ExpenseRepository().clearData();
  }

  Future<double> getTotalExpenses() async {
    return await ExpenseRepository().totalExpenses();
  }

  Future<List<double>> sumByCategory() async {
    List<double> total = [];
    for (var value in CategoryEnum.values) {
      double sum = (await ExpenseRepository().getSumByCategory(value));
      total.add(sum);
    }
    return total;
  }

  Future<List<Expense>> expensesByCategory(CategoryEnum value) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsByCategory(value).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByAmountRange(double low, double high) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsByAmountRange(low, high).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByAmountGreaterThan(double amount) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsWithAmountGreaterThan(amount)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByAmountLessThan(double amount) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsWithAmountLessThan(amount)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByCategoryAndAmount(
      CategoryEnum value, double amountHighValue) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsByOptions(value, amountHighValue)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByNotOthersCategory() async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsNotOthersCategory().then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByGroupFilter(
      String searchText, DateTime dateTime) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsByGroupFilter(searchText, dateTime)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByPaymentMethod(String searchText) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsBySearchText(searchText).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByUsingAny(
      List<CategoryEnum> categories) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsUsingAnyOf(categories).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByUsingAll(
      List<CategoryEnum> categories) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsUsingAllOf(categories).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByTags(int tags) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsWithTags(tags).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByTagName(String tagName) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsWithTagName(tagName).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesBySubCategory(String subCategory) async {
    List<Expense> expenses = [];

    await ExpenseRepository()
        .getObjectsBySubCategory(subCategory)
        .then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByReceipts(String receiptName) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsByReceipts(receiptName).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByPagination(int offset) async {
    List<Expense> expenses = [];

    await ExpenseRepository().getObjectsAndPaginate(offset).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByFindFirst() async {
    List<Expense> expenses = [];

    await ExpenseRepository().getOnlyFirstObject().then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> expensesByDeleteFirst() async {
    List<Expense> expenses = [];

    await ExpenseRepository().deleteOnlyFirstObject().then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<int> expensesByCount() async {
    return await ExpenseRepository().getTotalObjects();
  }

  Future<List<Expense>> expensesByFullTextSearch(String searchText) async {
    List<Expense> expenses = [];

    await ExpenseRepository().fullTextSearch(searchText).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<List<Expense>> deleteItem(Expense collection) async {
    List<Expense> expenses = [];

    await ExpenseRepository().deleteObject(collection).then((value) {
      expenses = value;
    });

    return expenses;
  }

  Future<void> clearGallery(List<Receipt> receipts) async {
    await ReceiptRepository().clearGallery(receipts);
  }
}
