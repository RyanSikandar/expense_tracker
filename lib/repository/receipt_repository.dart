import 'package:isar/isar.dart';
import 'package:routine_app/collections/receipt.dart';
import 'package:routine_app/repository/adapter.dart';

import '../main.dart';

class ReceiptRepository extends Adapter<Receipt> {
  @override
  Future<void> createMultipleObjects(List<Receipt> collections) async {
    await isar.writeTxn(() async {
      await isar.receipts.putAll(collections);
    });
  }

  @override
  Future<void> createObject(Receipt collection) async {
    await isar.writeTxn(() async {
      await isar.receipts.put(collection);
    });
  }

  @override
  Future<void> deleteObject(Receipt collection) async {
    await isar.writeTxn(() async {
      await isar.receipts.delete(collection.id);
    });
  }

  @override
  Future<void> deleteMultipleObjects(List<int> ids) async {
    await isar.receipts.deleteAll(ids);
  }

  @override
  Future<List<Receipt>> getAllObjects() async {
    return await isar.receipts.where().findAll();
  }

  @override
  Future<Receipt?> getObjectById(int id) async {
    return await isar.receipts.get(id);
  }

  @override
  Future<List<Receipt?>> getObjectsById(List<int> ids) async {
    return await isar.receipts.getAll(ids);
  }

  @override
  Future<void> updateObject(Receipt collection) async {
    await isar.writeTxn(() async {
      final budget = await isar.receipts.get(collection.id);

      if (budget != null) {
        await isar.receipts.put(collection);
      }
    });
  }}