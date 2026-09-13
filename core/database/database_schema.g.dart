// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_schema.dart';

// ignore_for_file: type=lint
class $WalletsTable extends Wallets with TableInfo<$WalletsTable, Wallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _walletAddressMeta = const VerificationMeta(
    'walletAddress',
  );
  @override
  late final GeneratedColumn<String> walletAddress = GeneratedColumn<String>(
    'wallet_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _offlineBalanceMeta = const VerificationMeta(
    'offlineBalance',
  );
  @override
  late final GeneratedColumn<int> offlineBalance = GeneratedColumn<int>(
    'offline_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monotonicCounterMeta = const VerificationMeta(
    'monotonicCounter',
  );
  @override
  late final GeneratedColumn<int> monotonicCounter = GeneratedColumn<int>(
    'monotonic_counter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    walletAddress,
    offlineBalance,
    monotonicCounter,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Wallet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wallet_address')) {
      context.handle(
        _walletAddressMeta,
        walletAddress.isAcceptableOrUnknown(
          data['wallet_address']!,
          _walletAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_walletAddressMeta);
    }
    if (data.containsKey('offline_balance')) {
      context.handle(
        _offlineBalanceMeta,
        offlineBalance.isAcceptableOrUnknown(
          data['offline_balance']!,
          _offlineBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_offlineBalanceMeta);
    }
    if (data.containsKey('monotonic_counter')) {
      context.handle(
        _monotonicCounterMeta,
        monotonicCounter.isAcceptableOrUnknown(
          data['monotonic_counter']!,
          _monotonicCounterMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wallet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      walletAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_address'],
      )!,
      offlineBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offline_balance'],
      )!,
      monotonicCounter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monotonic_counter'],
      )!,
    );
  }

  @override
  $WalletsTable createAlias(String alias) {
    return $WalletsTable(attachedDatabase, alias);
  }
}

class Wallet extends DataClass implements Insertable<Wallet> {
  final int id;
  final String walletAddress;
  final int offlineBalance;
  final int monotonicCounter;
  const Wallet({
    required this.id,
    required this.walletAddress,
    required this.offlineBalance,
    required this.monotonicCounter,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wallet_address'] = Variable<String>(walletAddress);
    map['offline_balance'] = Variable<int>(offlineBalance);
    map['monotonic_counter'] = Variable<int>(monotonicCounter);
    return map;
  }

  WalletsCompanion toCompanion(bool nullToAbsent) {
    return WalletsCompanion(
      id: Value(id),
      walletAddress: Value(walletAddress),
      offlineBalance: Value(offlineBalance),
      monotonicCounter: Value(monotonicCounter),
    );
  }

  factory Wallet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wallet(
      id: serializer.fromJson<int>(json['id']),
      walletAddress: serializer.fromJson<String>(json['walletAddress']),
      offlineBalance: serializer.fromJson<int>(json['offlineBalance']),
      monotonicCounter: serializer.fromJson<int>(json['monotonicCounter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'walletAddress': serializer.toJson<String>(walletAddress),
      'offlineBalance': serializer.toJson<int>(offlineBalance),
      'monotonicCounter': serializer.toJson<int>(monotonicCounter),
    };
  }

  Wallet copyWith({
    int? id,
    String? walletAddress,
    int? offlineBalance,
    int? monotonicCounter,
  }) => Wallet(
    id: id ?? this.id,
    walletAddress: walletAddress ?? this.walletAddress,
    offlineBalance: offlineBalance ?? this.offlineBalance,
    monotonicCounter: monotonicCounter ?? this.monotonicCounter,
  );
  Wallet copyWithCompanion(WalletsCompanion data) {
    return Wallet(
      id: data.id.present ? data.id.value : this.id,
      walletAddress: data.walletAddress.present
          ? data.walletAddress.value
          : this.walletAddress,
      offlineBalance: data.offlineBalance.present
          ? data.offlineBalance.value
          : this.offlineBalance,
      monotonicCounter: data.monotonicCounter.present
          ? data.monotonicCounter.value
          : this.monotonicCounter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Wallet(')
          ..write('id: $id, ')
          ..write('walletAddress: $walletAddress, ')
          ..write('offlineBalance: $offlineBalance, ')
          ..write('monotonicCounter: $monotonicCounter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, walletAddress, offlineBalance, monotonicCounter);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wallet &&
          other.id == this.id &&
          other.walletAddress == this.walletAddress &&
          other.offlineBalance == this.offlineBalance &&
          other.monotonicCounter == this.monotonicCounter);
}

class WalletsCompanion extends UpdateCompanion<Wallet> {
  final Value<int> id;
  final Value<String> walletAddress;
  final Value<int> offlineBalance;
  final Value<int> monotonicCounter;
  const WalletsCompanion({
    this.id = const Value.absent(),
    this.walletAddress = const Value.absent(),
    this.offlineBalance = const Value.absent(),
    this.monotonicCounter = const Value.absent(),
  });
  WalletsCompanion.insert({
    this.id = const Value.absent(),
    required String walletAddress,
    required int offlineBalance,
    this.monotonicCounter = const Value.absent(),
  }) : walletAddress = Value(walletAddress),
       offlineBalance = Value(offlineBalance);
  static Insertable<Wallet> custom({
    Expression<int>? id,
    Expression<String>? walletAddress,
    Expression<int>? offlineBalance,
    Expression<int>? monotonicCounter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walletAddress != null) 'wallet_address': walletAddress,
      if (offlineBalance != null) 'offline_balance': offlineBalance,
      if (monotonicCounter != null) 'monotonic_counter': monotonicCounter,
    });
  }

  WalletsCompanion copyWith({
    Value<int>? id,
    Value<String>? walletAddress,
    Value<int>? offlineBalance,
    Value<int>? monotonicCounter,
  }) {
    return WalletsCompanion(
      id: id ?? this.id,
      walletAddress: walletAddress ?? this.walletAddress,
      offlineBalance: offlineBalance ?? this.offlineBalance,
      monotonicCounter: monotonicCounter ?? this.monotonicCounter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (walletAddress.present) {
      map['wallet_address'] = Variable<String>(walletAddress.value);
    }
    if (offlineBalance.present) {
      map['offline_balance'] = Variable<int>(offlineBalance.value);
    }
    if (monotonicCounter.present) {
      map['monotonic_counter'] = Variable<int>(monotonicCounter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletsCompanion(')
          ..write('id: $id, ')
          ..write('walletAddress: $walletAddress, ')
          ..write('offlineBalance: $offlineBalance, ')
          ..write('monotonicCounter: $monotonicCounter')
          ..write(')'))
        .toString();
  }
}

class $PendingLedgerTable extends PendingLedger
    with TableInfo<$PendingLedgerTable, PendingLedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingLedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<int> walletId = GeneratedColumn<int>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _cborPayloadMeta = const VerificationMeta(
    'cborPayload',
  );
  @override
  late final GeneratedColumn<Uint8List> cborPayload =
      GeneratedColumn<Uint8List>(
        'cbor_payload',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _signatureMeta = const VerificationMeta(
    'signature',
  );
  @override
  late final GeneratedColumn<Uint8List> signature = GeneratedColumn<Uint8List>(
    'signature',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _encryptedJournalMeta = const VerificationMeta(
    'encryptedJournal',
  );
  @override
  late final GeneratedColumn<Uint8List> encryptedJournal =
      GeneratedColumn<Uint8List>(
        'encrypted_journal',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    walletId,
    transactionId,
    cborPayload,
    signature,
    encryptedJournal,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_ledger';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingLedgerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('cbor_payload')) {
      context.handle(
        _cborPayloadMeta,
        cborPayload.isAcceptableOrUnknown(
          data['cbor_payload']!,
          _cborPayloadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cborPayloadMeta);
    }
    if (data.containsKey('signature')) {
      context.handle(
        _signatureMeta,
        signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta),
      );
    } else if (isInserting) {
      context.missing(_signatureMeta);
    }
    if (data.containsKey('encrypted_journal')) {
      context.handle(
        _encryptedJournalMeta,
        encryptedJournal.isAcceptableOrUnknown(
          data['encrypted_journal']!,
          _encryptedJournalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_encryptedJournalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingLedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingLedgerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wallet_id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      cborPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}cbor_payload'],
      )!,
      signature: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}signature'],
      )!,
      encryptedJournal: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}encrypted_journal'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PendingLedgerTable createAlias(String alias) {
    return $PendingLedgerTable(attachedDatabase, alias);
  }
}

class PendingLedgerData extends DataClass
    implements Insertable<PendingLedgerData> {
  final int id;
  final int walletId;
  final String transactionId;
  final Uint8List cborPayload;
  final Uint8List signature;
  final Uint8List encryptedJournal;
  final DateTime createdAt;
  const PendingLedgerData({
    required this.id,
    required this.walletId,
    required this.transactionId,
    required this.cborPayload,
    required this.signature,
    required this.encryptedJournal,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wallet_id'] = Variable<int>(walletId);
    map['transaction_id'] = Variable<String>(transactionId);
    map['cbor_payload'] = Variable<Uint8List>(cborPayload);
    map['signature'] = Variable<Uint8List>(signature);
    map['encrypted_journal'] = Variable<Uint8List>(encryptedJournal);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PendingLedgerCompanion toCompanion(bool nullToAbsent) {
    return PendingLedgerCompanion(
      id: Value(id),
      walletId: Value(walletId),
      transactionId: Value(transactionId),
      cborPayload: Value(cborPayload),
      signature: Value(signature),
      encryptedJournal: Value(encryptedJournal),
      createdAt: Value(createdAt),
    );
  }

  factory PendingLedgerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingLedgerData(
      id: serializer.fromJson<int>(json['id']),
      walletId: serializer.fromJson<int>(json['walletId']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      cborPayload: serializer.fromJson<Uint8List>(json['cborPayload']),
      signature: serializer.fromJson<Uint8List>(json['signature']),
      encryptedJournal: serializer.fromJson<Uint8List>(
        json['encryptedJournal'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'walletId': serializer.toJson<int>(walletId),
      'transactionId': serializer.toJson<String>(transactionId),
      'cborPayload': serializer.toJson<Uint8List>(cborPayload),
      'signature': serializer.toJson<Uint8List>(signature),
      'encryptedJournal': serializer.toJson<Uint8List>(encryptedJournal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PendingLedgerData copyWith({
    int? id,
    int? walletId,
    String? transactionId,
    Uint8List? cborPayload,
    Uint8List? signature,
    Uint8List? encryptedJournal,
    DateTime? createdAt,
  }) => PendingLedgerData(
    id: id ?? this.id,
    walletId: walletId ?? this.walletId,
    transactionId: transactionId ?? this.transactionId,
    cborPayload: cborPayload ?? this.cborPayload,
    signature: signature ?? this.signature,
    encryptedJournal: encryptedJournal ?? this.encryptedJournal,
    createdAt: createdAt ?? this.createdAt,
  );
  PendingLedgerData copyWithCompanion(PendingLedgerCompanion data) {
    return PendingLedgerData(
      id: data.id.present ? data.id.value : this.id,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      cborPayload: data.cborPayload.present
          ? data.cborPayload.value
          : this.cborPayload,
      signature: data.signature.present ? data.signature.value : this.signature,
      encryptedJournal: data.encryptedJournal.present
          ? data.encryptedJournal.value
          : this.encryptedJournal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingLedgerData(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('transactionId: $transactionId, ')
          ..write('cborPayload: $cborPayload, ')
          ..write('signature: $signature, ')
          ..write('encryptedJournal: $encryptedJournal, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    walletId,
    transactionId,
    $driftBlobEquality.hash(cborPayload),
    $driftBlobEquality.hash(signature),
    $driftBlobEquality.hash(encryptedJournal),
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingLedgerData &&
          other.id == this.id &&
          other.walletId == this.walletId &&
          other.transactionId == this.transactionId &&
          $driftBlobEquality.equals(other.cborPayload, this.cborPayload) &&
          $driftBlobEquality.equals(other.signature, this.signature) &&
          $driftBlobEquality.equals(
            other.encryptedJournal,
            this.encryptedJournal,
          ) &&
          other.createdAt == this.createdAt);
}

class PendingLedgerCompanion extends UpdateCompanion<PendingLedgerData> {
  final Value<int> id;
  final Value<int> walletId;
  final Value<String> transactionId;
  final Value<Uint8List> cborPayload;
  final Value<Uint8List> signature;
  final Value<Uint8List> encryptedJournal;
  final Value<DateTime> createdAt;
  const PendingLedgerCompanion({
    this.id = const Value.absent(),
    this.walletId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.cborPayload = const Value.absent(),
    this.signature = const Value.absent(),
    this.encryptedJournal = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PendingLedgerCompanion.insert({
    this.id = const Value.absent(),
    required int walletId,
    required String transactionId,
    required Uint8List cborPayload,
    required Uint8List signature,
    required Uint8List encryptedJournal,
    this.createdAt = const Value.absent(),
  }) : walletId = Value(walletId),
       transactionId = Value(transactionId),
       cborPayload = Value(cborPayload),
       signature = Value(signature),
       encryptedJournal = Value(encryptedJournal);
  static Insertable<PendingLedgerData> custom({
    Expression<int>? id,
    Expression<int>? walletId,
    Expression<String>? transactionId,
    Expression<Uint8List>? cborPayload,
    Expression<Uint8List>? signature,
    Expression<Uint8List>? encryptedJournal,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walletId != null) 'wallet_id': walletId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (cborPayload != null) 'cbor_payload': cborPayload,
      if (signature != null) 'signature': signature,
      if (encryptedJournal != null) 'encrypted_journal': encryptedJournal,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PendingLedgerCompanion copyWith({
    Value<int>? id,
    Value<int>? walletId,
    Value<String>? transactionId,
    Value<Uint8List>? cborPayload,
    Value<Uint8List>? signature,
    Value<Uint8List>? encryptedJournal,
    Value<DateTime>? createdAt,
  }) {
    return PendingLedgerCompanion(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      transactionId: transactionId ?? this.transactionId,
      cborPayload: cborPayload ?? this.cborPayload,
      signature: signature ?? this.signature,
      encryptedJournal: encryptedJournal ?? this.encryptedJournal,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (walletId.present) {
      map['wallet_id'] = Variable<int>(walletId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (cborPayload.present) {
      map['cbor_payload'] = Variable<Uint8List>(cborPayload.value);
    }
    if (signature.present) {
      map['signature'] = Variable<Uint8List>(signature.value);
    }
    if (encryptedJournal.present) {
      map['encrypted_journal'] = Variable<Uint8List>(encryptedJournal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingLedgerCompanion(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('transactionId: $transactionId, ')
          ..write('cborPayload: $cborPayload, ')
          ..write('signature: $signature, ')
          ..write('encryptedJournal: $encryptedJournal, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WalletsTable wallets = $WalletsTable(this);
  late final $PendingLedgerTable pendingLedger = $PendingLedgerTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [wallets, pendingLedger];
}

typedef $$WalletsTableCreateCompanionBuilder =
    WalletsCompanion Function({
      Value<int> id,
      required String walletAddress,
      required int offlineBalance,
      Value<int> monotonicCounter,
    });
typedef $$WalletsTableUpdateCompanionBuilder =
    WalletsCompanion Function({
      Value<int> id,
      Value<String> walletAddress,
      Value<int> offlineBalance,
      Value<int> monotonicCounter,
    });

class $$WalletsTableFilterComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walletAddress => $composableBuilder(
    column: $table.walletAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get offlineBalance => $composableBuilder(
    column: $table.offlineBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monotonicCounter => $composableBuilder(
    column: $table.monotonicCounter,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalletsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walletAddress => $composableBuilder(
    column: $table.walletAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get offlineBalance => $composableBuilder(
    column: $table.offlineBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monotonicCounter => $composableBuilder(
    column: $table.monotonicCounter,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get walletAddress => $composableBuilder(
    column: $table.walletAddress,
    builder: (column) => column,
  );

  GeneratedColumn<int> get offlineBalance => $composableBuilder(
    column: $table.offlineBalance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monotonicCounter => $composableBuilder(
    column: $table.monotonicCounter,
    builder: (column) => column,
  );
}

class $$WalletsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletsTable,
          Wallet,
          $$WalletsTableFilterComposer,
          $$WalletsTableOrderingComposer,
          $$WalletsTableAnnotationComposer,
          $$WalletsTableCreateCompanionBuilder,
          $$WalletsTableUpdateCompanionBuilder,
          (Wallet, BaseReferences<_$AppDatabase, $WalletsTable, Wallet>),
          Wallet,
          PrefetchHooks Function()
        > {
  $$WalletsTableTableManager(_$AppDatabase db, $WalletsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> walletAddress = const Value.absent(),
                Value<int> offlineBalance = const Value.absent(),
                Value<int> monotonicCounter = const Value.absent(),
              }) => WalletsCompanion(
                id: id,
                walletAddress: walletAddress,
                offlineBalance: offlineBalance,
                monotonicCounter: monotonicCounter,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String walletAddress,
                required int offlineBalance,
                Value<int> monotonicCounter = const Value.absent(),
              }) => WalletsCompanion.insert(
                id: id,
                walletAddress: walletAddress,
                offlineBalance: offlineBalance,
                monotonicCounter: monotonicCounter,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalletsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletsTable,
      Wallet,
      $$WalletsTableFilterComposer,
      $$WalletsTableOrderingComposer,
      $$WalletsTableAnnotationComposer,
      $$WalletsTableCreateCompanionBuilder,
      $$WalletsTableUpdateCompanionBuilder,
      (Wallet, BaseReferences<_$AppDatabase, $WalletsTable, Wallet>),
      Wallet,
      PrefetchHooks Function()
    >;
typedef $$PendingLedgerTableCreateCompanionBuilder =
    PendingLedgerCompanion Function({
      Value<int> id,
      required int walletId,
      required String transactionId,
      required Uint8List cborPayload,
      required Uint8List signature,
      required Uint8List encryptedJournal,
      Value<DateTime> createdAt,
    });
typedef $$PendingLedgerTableUpdateCompanionBuilder =
    PendingLedgerCompanion Function({
      Value<int> id,
      Value<int> walletId,
      Value<String> transactionId,
      Value<Uint8List> cborPayload,
      Value<Uint8List> signature,
      Value<Uint8List> encryptedJournal,
      Value<DateTime> createdAt,
    });

class $$PendingLedgerTableFilterComposer
    extends Composer<_$AppDatabase, $PendingLedgerTable> {
  $$PendingLedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get walletId => $composableBuilder(
    column: $table.walletId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get cborPayload => $composableBuilder(
    column: $table.cborPayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get signature => $composableBuilder(
    column: $table.signature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get encryptedJournal => $composableBuilder(
    column: $table.encryptedJournal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingLedgerTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingLedgerTable> {
  $$PendingLedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get walletId => $composableBuilder(
    column: $table.walletId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get cborPayload => $composableBuilder(
    column: $table.cborPayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get signature => $composableBuilder(
    column: $table.signature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get encryptedJournal => $composableBuilder(
    column: $table.encryptedJournal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingLedgerTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingLedgerTable> {
  $$PendingLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get walletId =>
      $composableBuilder(column: $table.walletId, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get cborPayload => $composableBuilder(
    column: $table.cborPayload,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get signature =>
      $composableBuilder(column: $table.signature, builder: (column) => column);

  GeneratedColumn<Uint8List> get encryptedJournal => $composableBuilder(
    column: $table.encryptedJournal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingLedgerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingLedgerTable,
          PendingLedgerData,
          $$PendingLedgerTableFilterComposer,
          $$PendingLedgerTableOrderingComposer,
          $$PendingLedgerTableAnnotationComposer,
          $$PendingLedgerTableCreateCompanionBuilder,
          $$PendingLedgerTableUpdateCompanionBuilder,
          (
            PendingLedgerData,
            BaseReferences<
              _$AppDatabase,
              $PendingLedgerTable,
              PendingLedgerData
            >,
          ),
          PendingLedgerData,
          PrefetchHooks Function()
        > {
  $$PendingLedgerTableTableManager(_$AppDatabase db, $PendingLedgerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> walletId = const Value.absent(),
                Value<String> transactionId = const Value.absent(),
                Value<Uint8List> cborPayload = const Value.absent(),
                Value<Uint8List> signature = const Value.absent(),
                Value<Uint8List> encryptedJournal = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PendingLedgerCompanion(
                id: id,
                walletId: walletId,
                transactionId: transactionId,
                cborPayload: cborPayload,
                signature: signature,
                encryptedJournal: encryptedJournal,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int walletId,
                required String transactionId,
                required Uint8List cborPayload,
                required Uint8List signature,
                required Uint8List encryptedJournal,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PendingLedgerCompanion.insert(
                id: id,
                walletId: walletId,
                transactionId: transactionId,
                cborPayload: cborPayload,
                signature: signature,
                encryptedJournal: encryptedJournal,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingLedgerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingLedgerTable,
      PendingLedgerData,
      $$PendingLedgerTableFilterComposer,
      $$PendingLedgerTableOrderingComposer,
      $$PendingLedgerTableAnnotationComposer,
      $$PendingLedgerTableCreateCompanionBuilder,
      $$PendingLedgerTableUpdateCompanionBuilder,
      (
        PendingLedgerData,
        BaseReferences<_$AppDatabase, $PendingLedgerTable, PendingLedgerData>,
      ),
      PendingLedgerData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WalletsTableTableManager get wallets =>
      $$WalletsTableTableManager(_db, _db.wallets);
  $$PendingLedgerTableTableManager get pendingLedger =>
      $$PendingLedgerTableTableManager(_db, _db.pendingLedger);
}
