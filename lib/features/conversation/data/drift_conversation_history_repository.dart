import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/local_user.dart';
import '../domain/conversation_history_repository.dart';
import '../domain/conversation_models.dart' as domain;

class DriftConversationHistoryRepository
    implements ConversationHistoryRepository {
  DriftConversationHistoryRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<domain.ConversationArchive>> watchAll() {
    final query = _database.select(_database.conversationArchives)
      ..where((row) => row.localUserId.equals(kLocalUserId))
      ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)]);
    return query.watch().map(
      (rows) => rows.map(_toDomain).toList(growable: false),
    );
  }

  @override
  Future<void> save(domain.ConversationArchive archive) {
    final messages = jsonEncode(
      archive.messages.map((message) => message.toJson()).toList(),
    );
    return _database
        .into(_database.conversationArchives)
        .insertOnConflictUpdate(
          ConversationArchivesCompanion.insert(
            id: archive.id,
            title: archive.title,
            messagesJson: messages,
            remoteConversationId: Value(archive.remoteConversationId),
            createdAt: archive.createdAt,
            updatedAt: archive.updatedAt,
          ),
        );
  }

  @override
  Future<void> delete(String id) {
    return (_database.delete(_database.conversationArchives)..where(
          (row) => row.localUserId.equals(kLocalUserId) & row.id.equals(id),
        ))
        .go();
  }

  domain.ConversationArchive _toDomain(ConversationArchive row) {
    final decoded = jsonDecode(row.messagesJson) as List<dynamic>;
    return domain.ConversationArchive(
      id: row.id,
      title: row.title,
      messages: decoded
          .whereType<Map<String, dynamic>>()
          .map(domain.ConversationMessage.fromJson)
          .toList(growable: false),
      remoteConversationId: row.remoteConversationId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
