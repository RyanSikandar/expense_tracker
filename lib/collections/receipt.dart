import 'package:isar/isar.dart';
import 'package:routine_app/collections/expense.dart';

part 'receipt.g.dart';
@collection
class Receipt {
  Id id = Isar.autoIncrement;

  late String name;

  Expense? expense;
}
