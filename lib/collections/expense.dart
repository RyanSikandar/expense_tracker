import 'package:isar/isar.dart';
import 'package:routine_app/collections/receipt.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  late double amount;
  late DateTime date;

  @Enumerated(EnumType.name)
  late CategoryEnum category;

  SubCatgory? subCategory;

  //receipts

  Receipt? receipt;

  String? paymentMethod;

  List<String>? description;
}

enum CategoryEnum { bills, food, clothes, transport, fun, others }

@embedded
class SubCatgory {
  String? name;
}
