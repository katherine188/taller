// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, nombre, telefono];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(Insertable<Cliente> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono'])!,
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final int id;
  final String nombre;
  final String telefono;
  const Cliente(
      {required this.id, required this.nombre, required this.telefono});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['telefono'] = Variable<String>(telefono);
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      telefono: Value(telefono),
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String>(json['telefono']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String>(telefono),
    };
  }

  Cliente copyWith({int? id, String? nombre, String? telefono}) => Cliente(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        telefono: telefono ?? this.telefono,
      );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, telefono);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.telefono == this.telefono);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> telefono;
  const ClientesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String telefono,
  })  : nombre = Value(nombre),
        telefono = Value(telefono);
  static Insertable<Cliente> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? telefono,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (telefono != null) 'telefono': telefono,
    });
  }

  ClientesCompanion copyWith(
      {Value<int>? id, Value<String>? nombre, Value<String>? telefono}) {
    return ClientesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono')
          ..write(')'))
        .toString();
  }
}

class $EquiposTable extends Equipos with TableInfo<$EquiposTable, Equipo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquiposTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TipoEquipo, String> tipo =
      GeneratedColumn<String>('tipo', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TipoEquipo>($EquiposTable.$convertertipo);
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
      'marca', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
      'modelo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroSerieMeta =
      const VerificationMeta('numeroSerie');
  @override
  late final GeneratedColumn<String> numeroSerie = GeneratedColumn<String>(
      'numero_serie', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, clienteId, tipo, marca, modelo, numeroSerie];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipos';
  @override
  VerificationContext validateIntegrity(Insertable<Equipo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
          _marcaMeta, marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta));
    } else if (isInserting) {
      context.missing(_marcaMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(_modeloMeta,
          modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta));
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('numero_serie')) {
      context.handle(
          _numeroSerieMeta,
          numeroSerie.isAcceptableOrUnknown(
              data['numero_serie']!, _numeroSerieMeta));
    } else if (isInserting) {
      context.missing(_numeroSerieMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Equipo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Equipo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_id'])!,
      tipo: $EquiposTable.$convertertipo.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!),
      marca: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marca'])!,
      modelo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modelo'])!,
      numeroSerie: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero_serie'])!,
    );
  }

  @override
  $EquiposTable createAlias(String alias) {
    return $EquiposTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoEquipo, String, String> $convertertipo =
      const EnumNameConverter<TipoEquipo>(TipoEquipo.values);
}

class Equipo extends DataClass implements Insertable<Equipo> {
  final int id;
  final int clienteId;
  final TipoEquipo tipo;
  final String marca;
  final String modelo;
  final String numeroSerie;
  const Equipo(
      {required this.id,
      required this.clienteId,
      required this.tipo,
      required this.marca,
      required this.modelo,
      required this.numeroSerie});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente_id'] = Variable<int>(clienteId);
    {
      map['tipo'] = Variable<String>($EquiposTable.$convertertipo.toSql(tipo));
    }
    map['marca'] = Variable<String>(marca);
    map['modelo'] = Variable<String>(modelo);
    map['numero_serie'] = Variable<String>(numeroSerie);
    return map;
  }

  EquiposCompanion toCompanion(bool nullToAbsent) {
    return EquiposCompanion(
      id: Value(id),
      clienteId: Value(clienteId),
      tipo: Value(tipo),
      marca: Value(marca),
      modelo: Value(modelo),
      numeroSerie: Value(numeroSerie),
    );
  }

  factory Equipo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Equipo(
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<int>(json['clienteId']),
      tipo: $EquiposTable.$convertertipo
          .fromJson(serializer.fromJson<String>(json['tipo'])),
      marca: serializer.fromJson<String>(json['marca']),
      modelo: serializer.fromJson<String>(json['modelo']),
      numeroSerie: serializer.fromJson<String>(json['numeroSerie']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<int>(clienteId),
      'tipo':
          serializer.toJson<String>($EquiposTable.$convertertipo.toJson(tipo)),
      'marca': serializer.toJson<String>(marca),
      'modelo': serializer.toJson<String>(modelo),
      'numeroSerie': serializer.toJson<String>(numeroSerie),
    };
  }

  Equipo copyWith(
          {int? id,
          int? clienteId,
          TipoEquipo? tipo,
          String? marca,
          String? modelo,
          String? numeroSerie}) =>
      Equipo(
        id: id ?? this.id,
        clienteId: clienteId ?? this.clienteId,
        tipo: tipo ?? this.tipo,
        marca: marca ?? this.marca,
        modelo: modelo ?? this.modelo,
        numeroSerie: numeroSerie ?? this.numeroSerie,
      );
  Equipo copyWithCompanion(EquiposCompanion data) {
    return Equipo(
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      marca: data.marca.present ? data.marca.value : this.marca,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      numeroSerie:
          data.numeroSerie.present ? data.numeroSerie.value : this.numeroSerie,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Equipo(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clienteId, tipo, marca, modelo, numeroSerie);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Equipo &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.tipo == this.tipo &&
          other.marca == this.marca &&
          other.modelo == this.modelo &&
          other.numeroSerie == this.numeroSerie);
}

class EquiposCompanion extends UpdateCompanion<Equipo> {
  final Value<int> id;
  final Value<int> clienteId;
  final Value<TipoEquipo> tipo;
  final Value<String> marca;
  final Value<String> modelo;
  final Value<String> numeroSerie;
  const EquiposCompanion({
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.numeroSerie = const Value.absent(),
  });
  EquiposCompanion.insert({
    this.id = const Value.absent(),
    required int clienteId,
    required TipoEquipo tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
  })  : clienteId = Value(clienteId),
        tipo = Value(tipo),
        marca = Value(marca),
        modelo = Value(modelo),
        numeroSerie = Value(numeroSerie);
  static Insertable<Equipo> custom({
    Expression<int>? id,
    Expression<int>? clienteId,
    Expression<String>? tipo,
    Expression<String>? marca,
    Expression<String>? modelo,
    Expression<String>? numeroSerie,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (tipo != null) 'tipo': tipo,
      if (marca != null) 'marca': marca,
      if (modelo != null) 'modelo': modelo,
      if (numeroSerie != null) 'numero_serie': numeroSerie,
    });
  }

  EquiposCompanion copyWith(
      {Value<int>? id,
      Value<int>? clienteId,
      Value<TipoEquipo>? tipo,
      Value<String>? marca,
      Value<String>? modelo,
      Value<String>? numeroSerie}) {
    return EquiposCompanion(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      numeroSerie: numeroSerie ?? this.numeroSerie,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (tipo.present) {
      map['tipo'] =
          Variable<String>($EquiposTable.$convertertipo.toSql(tipo.value));
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (numeroSerie.present) {
      map['numero_serie'] = Variable<String>(numeroSerie.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquiposCompanion(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie')
          ..write(')'))
        .toString();
  }
}

class $TecnicosTable extends Tecnicos with TableInfo<$TecnicosTable, Tecnico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TecnicosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tecnicos';
  @override
  VerificationContext validateIntegrity(Insertable<Tecnico> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tecnico map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tecnico(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
    );
  }

  @override
  $TecnicosTable createAlias(String alias) {
    return $TecnicosTable(attachedDatabase, alias);
  }
}

class Tecnico extends DataClass implements Insertable<Tecnico> {
  final int id;
  final String nombre;
  const Tecnico({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  TecnicosCompanion toCompanion(bool nullToAbsent) {
    return TecnicosCompanion(
      id: Value(id),
      nombre: Value(nombre),
    );
  }

  factory Tecnico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tecnico(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Tecnico copyWith({int? id, String? nombre}) => Tecnico(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
  Tecnico copyWithCompanion(TecnicosCompanion data) {
    return Tecnico(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tecnico(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tecnico && other.id == this.id && other.nombre == this.nombre);
}

class TecnicosCompanion extends UpdateCompanion<Tecnico> {
  final Value<int> id;
  final Value<String> nombre;
  const TecnicosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  TecnicosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Tecnico> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  TecnicosCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return TecnicosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TecnicosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $RepuestosTable extends Repuestos
    with TableInfo<$RepuestosTable, Repuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
      'precio', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _existenciasMeta =
      const VerificationMeta('existencias');
  @override
  late final GeneratedColumn<int> existencias = GeneratedColumn<int>(
      'existencias', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stockMinimoMeta =
      const VerificationMeta('stockMinimo');
  @override
  late final GeneratedColumn<int> stockMinimo = GeneratedColumn<int>(
      'stock_minimo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, codigo, precio, existencias, stockMinimo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos';
  @override
  VerificationContext validateIntegrity(Insertable<Repuesto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(_precioMeta,
          precio.isAcceptableOrUnknown(data['precio']!, _precioMeta));
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('existencias')) {
      context.handle(
          _existenciasMeta,
          existencias.isAcceptableOrUnknown(
              data['existencias']!, _existenciasMeta));
    } else if (isInserting) {
      context.missing(_existenciasMeta);
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
          _stockMinimoMeta,
          stockMinimo.isAcceptableOrUnknown(
              data['stock_minimo']!, _stockMinimoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repuesto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      precio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio'])!,
      existencias: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}existencias'])!,
      stockMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_minimo'])!,
    );
  }

  @override
  $RepuestosTable createAlias(String alias) {
    return $RepuestosTable(attachedDatabase, alias);
  }
}

class Repuesto extends DataClass implements Insertable<Repuesto> {
  final int id;
  final String nombre;
  final String codigo;
  final double precio;
  final int existencias;
  final int stockMinimo;
  const Repuesto(
      {required this.id,
      required this.nombre,
      required this.codigo,
      required this.precio,
      required this.existencias,
      required this.stockMinimo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['codigo'] = Variable<String>(codigo);
    map['precio'] = Variable<double>(precio);
    map['existencias'] = Variable<int>(existencias);
    map['stock_minimo'] = Variable<int>(stockMinimo);
    return map;
  }

  RepuestosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      codigo: Value(codigo),
      precio: Value(precio),
      existencias: Value(existencias),
      stockMinimo: Value(stockMinimo),
    );
  }

  factory Repuesto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repuesto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      codigo: serializer.fromJson<String>(json['codigo']),
      precio: serializer.fromJson<double>(json['precio']),
      existencias: serializer.fromJson<int>(json['existencias']),
      stockMinimo: serializer.fromJson<int>(json['stockMinimo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'codigo': serializer.toJson<String>(codigo),
      'precio': serializer.toJson<double>(precio),
      'existencias': serializer.toJson<int>(existencias),
      'stockMinimo': serializer.toJson<int>(stockMinimo),
    };
  }

  Repuesto copyWith(
          {int? id,
          String? nombre,
          String? codigo,
          double? precio,
          int? existencias,
          int? stockMinimo}) =>
      Repuesto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        codigo: codigo ?? this.codigo,
        precio: precio ?? this.precio,
        existencias: existencias ?? this.existencias,
        stockMinimo: stockMinimo ?? this.stockMinimo,
      );
  Repuesto copyWithCompanion(RepuestosCompanion data) {
    return Repuesto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      precio: data.precio.present ? data.precio.value : this.precio,
      existencias:
          data.existencias.present ? data.existencias.value : this.existencias,
      stockMinimo:
          data.stockMinimo.present ? data.stockMinimo.value : this.stockMinimo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repuesto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias, ')
          ..write('stockMinimo: $stockMinimo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, codigo, precio, existencias, stockMinimo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repuesto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.codigo == this.codigo &&
          other.precio == this.precio &&
          other.existencias == this.existencias &&
          other.stockMinimo == this.stockMinimo);
}

class RepuestosCompanion extends UpdateCompanion<Repuesto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> codigo;
  final Value<double> precio;
  final Value<int> existencias;
  final Value<int> stockMinimo;
  const RepuestosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.codigo = const Value.absent(),
    this.precio = const Value.absent(),
    this.existencias = const Value.absent(),
    this.stockMinimo = const Value.absent(),
  });
  RepuestosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
    this.stockMinimo = const Value.absent(),
  })  : nombre = Value(nombre),
        codigo = Value(codigo),
        precio = Value(precio),
        existencias = Value(existencias);
  static Insertable<Repuesto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? codigo,
    Expression<double>? precio,
    Expression<int>? existencias,
    Expression<int>? stockMinimo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (codigo != null) 'codigo': codigo,
      if (precio != null) 'precio': precio,
      if (existencias != null) 'existencias': existencias,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
    });
  }

  RepuestosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String>? codigo,
      Value<double>? precio,
      Value<int>? existencias,
      Value<int>? stockMinimo}) {
    return RepuestosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      codigo: codigo ?? this.codigo,
      precio: precio ?? this.precio,
      existencias: existencias ?? this.existencias,
      stockMinimo: stockMinimo ?? this.stockMinimo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (existencias.present) {
      map['existencias'] = Variable<int>(existencias.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<int>(stockMinimo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias, ')
          ..write('stockMinimo: $stockMinimo')
          ..write(')'))
        .toString();
  }
}

class $OrdenesTable extends Ordenes with TableInfo<$OrdenesTable, Orden> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _equipoIdMeta =
      const VerificationMeta('equipoId');
  @override
  late final GeneratedColumn<int> equipoId = GeneratedColumn<int>(
      'equipo_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tecnicoIdMeta =
      const VerificationMeta('tecnicoId');
  @override
  late final GeneratedColumn<int> tecnicoId = GeneratedColumn<int>(
      'tecnico_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<EstadoOrden, String> estado =
      GeneratedColumn<String>('estado', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<EstadoOrden>($OrdenesTable.$converterestado);
  static const VerificationMeta _fallaMeta = const VerificationMeta('falla');
  @override
  late final GeneratedColumn<String> falla = GeneratedColumn<String>(
      'falla', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaRecepcionMeta =
      const VerificationMeta('fechaRecepcion');
  @override
  late final GeneratedColumn<DateTime> fechaRecepcion =
      GeneratedColumn<DateTime>('fecha_recepcion', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaActualizacionMeta =
      const VerificationMeta('fechaActualizacion');
  @override
  late final GeneratedColumn<DateTime> fechaActualizacion =
      GeneratedColumn<DateTime>('fecha_actualizacion', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        equipoId,
        tecnicoId,
        estado,
        falla,
        fechaRecepcion,
        fechaActualizacion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes';
  @override
  VerificationContext validateIntegrity(Insertable<Orden> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('equipo_id')) {
      context.handle(_equipoIdMeta,
          equipoId.isAcceptableOrUnknown(data['equipo_id']!, _equipoIdMeta));
    } else if (isInserting) {
      context.missing(_equipoIdMeta);
    }
    if (data.containsKey('tecnico_id')) {
      context.handle(_tecnicoIdMeta,
          tecnicoId.isAcceptableOrUnknown(data['tecnico_id']!, _tecnicoIdMeta));
    }
    if (data.containsKey('falla')) {
      context.handle(
          _fallaMeta, falla.isAcceptableOrUnknown(data['falla']!, _fallaMeta));
    } else if (isInserting) {
      context.missing(_fallaMeta);
    }
    if (data.containsKey('fecha_recepcion')) {
      context.handle(
          _fechaRecepcionMeta,
          fechaRecepcion.isAcceptableOrUnknown(
              data['fecha_recepcion']!, _fechaRecepcionMeta));
    } else if (isInserting) {
      context.missing(_fechaRecepcionMeta);
    }
    if (data.containsKey('fecha_actualizacion')) {
      context.handle(
          _fechaActualizacionMeta,
          fechaActualizacion.isAcceptableOrUnknown(
              data['fecha_actualizacion']!, _fechaActualizacionMeta));
    } else if (isInserting) {
      context.missing(_fechaActualizacionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Orden map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Orden(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      equipoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}equipo_id'])!,
      tecnicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tecnico_id']),
      estado: $OrdenesTable.$converterestado.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!),
      falla: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}falla'])!,
      fechaRecepcion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_recepcion'])!,
      fechaActualizacion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}fecha_actualizacion'])!,
    );
  }

  @override
  $OrdenesTable createAlias(String alias) {
    return $OrdenesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EstadoOrden, String, String> $converterestado =
      const EnumNameConverter<EstadoOrden>(EstadoOrden.values);
}

class Orden extends DataClass implements Insertable<Orden> {
  final int id;
  final int equipoId;

  /// Técnico responsable. Null = nadie la ha tomado.
  final int? tecnicoId;
  final EstadoOrden estado;
  final String falla;
  final DateTime fechaRecepcion;
  final DateTime fechaActualizacion;
  const Orden(
      {required this.id,
      required this.equipoId,
      this.tecnicoId,
      required this.estado,
      required this.falla,
      required this.fechaRecepcion,
      required this.fechaActualizacion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['equipo_id'] = Variable<int>(equipoId);
    if (!nullToAbsent || tecnicoId != null) {
      map['tecnico_id'] = Variable<int>(tecnicoId);
    }
    {
      map['estado'] =
          Variable<String>($OrdenesTable.$converterestado.toSql(estado));
    }
    map['falla'] = Variable<String>(falla);
    map['fecha_recepcion'] = Variable<DateTime>(fechaRecepcion);
    map['fecha_actualizacion'] = Variable<DateTime>(fechaActualizacion);
    return map;
  }

  OrdenesCompanion toCompanion(bool nullToAbsent) {
    return OrdenesCompanion(
      id: Value(id),
      equipoId: Value(equipoId),
      tecnicoId: tecnicoId == null && nullToAbsent
          ? const Value.absent()
          : Value(tecnicoId),
      estado: Value(estado),
      falla: Value(falla),
      fechaRecepcion: Value(fechaRecepcion),
      fechaActualizacion: Value(fechaActualizacion),
    );
  }

  factory Orden.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Orden(
      id: serializer.fromJson<int>(json['id']),
      equipoId: serializer.fromJson<int>(json['equipoId']),
      tecnicoId: serializer.fromJson<int?>(json['tecnicoId']),
      estado: $OrdenesTable.$converterestado
          .fromJson(serializer.fromJson<String>(json['estado'])),
      falla: serializer.fromJson<String>(json['falla']),
      fechaRecepcion: serializer.fromJson<DateTime>(json['fechaRecepcion']),
      fechaActualizacion:
          serializer.fromJson<DateTime>(json['fechaActualizacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'equipoId': serializer.toJson<int>(equipoId),
      'tecnicoId': serializer.toJson<int?>(tecnicoId),
      'estado': serializer
          .toJson<String>($OrdenesTable.$converterestado.toJson(estado)),
      'falla': serializer.toJson<String>(falla),
      'fechaRecepcion': serializer.toJson<DateTime>(fechaRecepcion),
      'fechaActualizacion': serializer.toJson<DateTime>(fechaActualizacion),
    };
  }

  Orden copyWith(
          {int? id,
          int? equipoId,
          Value<int?> tecnicoId = const Value.absent(),
          EstadoOrden? estado,
          String? falla,
          DateTime? fechaRecepcion,
          DateTime? fechaActualizacion}) =>
      Orden(
        id: id ?? this.id,
        equipoId: equipoId ?? this.equipoId,
        tecnicoId: tecnicoId.present ? tecnicoId.value : this.tecnicoId,
        estado: estado ?? this.estado,
        falla: falla ?? this.falla,
        fechaRecepcion: fechaRecepcion ?? this.fechaRecepcion,
        fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      );
  Orden copyWithCompanion(OrdenesCompanion data) {
    return Orden(
      id: data.id.present ? data.id.value : this.id,
      equipoId: data.equipoId.present ? data.equipoId.value : this.equipoId,
      tecnicoId: data.tecnicoId.present ? data.tecnicoId.value : this.tecnicoId,
      estado: data.estado.present ? data.estado.value : this.estado,
      falla: data.falla.present ? data.falla.value : this.falla,
      fechaRecepcion: data.fechaRecepcion.present
          ? data.fechaRecepcion.value
          : this.fechaRecepcion,
      fechaActualizacion: data.fechaActualizacion.present
          ? data.fechaActualizacion.value
          : this.fechaActualizacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Orden(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('estado: $estado, ')
          ..write('falla: $falla, ')
          ..write('fechaRecepcion: $fechaRecepcion, ')
          ..write('fechaActualizacion: $fechaActualizacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, equipoId, tecnicoId, estado, falla,
      fechaRecepcion, fechaActualizacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Orden &&
          other.id == this.id &&
          other.equipoId == this.equipoId &&
          other.tecnicoId == this.tecnicoId &&
          other.estado == this.estado &&
          other.falla == this.falla &&
          other.fechaRecepcion == this.fechaRecepcion &&
          other.fechaActualizacion == this.fechaActualizacion);
}

class OrdenesCompanion extends UpdateCompanion<Orden> {
  final Value<int> id;
  final Value<int> equipoId;
  final Value<int?> tecnicoId;
  final Value<EstadoOrden> estado;
  final Value<String> falla;
  final Value<DateTime> fechaRecepcion;
  final Value<DateTime> fechaActualizacion;
  const OrdenesCompanion({
    this.id = const Value.absent(),
    this.equipoId = const Value.absent(),
    this.tecnicoId = const Value.absent(),
    this.estado = const Value.absent(),
    this.falla = const Value.absent(),
    this.fechaRecepcion = const Value.absent(),
    this.fechaActualizacion = const Value.absent(),
  });
  OrdenesCompanion.insert({
    this.id = const Value.absent(),
    required int equipoId,
    this.tecnicoId = const Value.absent(),
    required EstadoOrden estado,
    required String falla,
    required DateTime fechaRecepcion,
    required DateTime fechaActualizacion,
  })  : equipoId = Value(equipoId),
        estado = Value(estado),
        falla = Value(falla),
        fechaRecepcion = Value(fechaRecepcion),
        fechaActualizacion = Value(fechaActualizacion);
  static Insertable<Orden> custom({
    Expression<int>? id,
    Expression<int>? equipoId,
    Expression<int>? tecnicoId,
    Expression<String>? estado,
    Expression<String>? falla,
    Expression<DateTime>? fechaRecepcion,
    Expression<DateTime>? fechaActualizacion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (equipoId != null) 'equipo_id': equipoId,
      if (tecnicoId != null) 'tecnico_id': tecnicoId,
      if (estado != null) 'estado': estado,
      if (falla != null) 'falla': falla,
      if (fechaRecepcion != null) 'fecha_recepcion': fechaRecepcion,
      if (fechaActualizacion != null) 'fecha_actualizacion': fechaActualizacion,
    });
  }

  OrdenesCompanion copyWith(
      {Value<int>? id,
      Value<int>? equipoId,
      Value<int?>? tecnicoId,
      Value<EstadoOrden>? estado,
      Value<String>? falla,
      Value<DateTime>? fechaRecepcion,
      Value<DateTime>? fechaActualizacion}) {
    return OrdenesCompanion(
      id: id ?? this.id,
      equipoId: equipoId ?? this.equipoId,
      tecnicoId: tecnicoId ?? this.tecnicoId,
      estado: estado ?? this.estado,
      falla: falla ?? this.falla,
      fechaRecepcion: fechaRecepcion ?? this.fechaRecepcion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (equipoId.present) {
      map['equipo_id'] = Variable<int>(equipoId.value);
    }
    if (tecnicoId.present) {
      map['tecnico_id'] = Variable<int>(tecnicoId.value);
    }
    if (estado.present) {
      map['estado'] =
          Variable<String>($OrdenesTable.$converterestado.toSql(estado.value));
    }
    if (falla.present) {
      map['falla'] = Variable<String>(falla.value);
    }
    if (fechaRecepcion.present) {
      map['fecha_recepcion'] = Variable<DateTime>(fechaRecepcion.value);
    }
    if (fechaActualizacion.present) {
      map['fecha_actualizacion'] = Variable<DateTime>(fechaActualizacion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesCompanion(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('estado: $estado, ')
          ..write('falla: $falla, ')
          ..write('fechaRecepcion: $fechaRecepcion, ')
          ..write('fechaActualizacion: $fechaActualizacion')
          ..write(')'))
        .toString();
  }
}

class $TrabajosTable extends Trabajos with TableInfo<$TrabajosTable, Trabajo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrabajosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _costoManoObraMeta =
      const VerificationMeta('costoManoObra');
  @override
  late final GeneratedColumn<double> costoManoObra = GeneratedColumn<double>(
      'costo_mano_obra', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ordenId, descripcion, costoManoObra, fecha];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trabajos';
  @override
  VerificationContext validateIntegrity(Insertable<Trabajo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('costo_mano_obra')) {
      context.handle(
          _costoManoObraMeta,
          costoManoObra.isAcceptableOrUnknown(
              data['costo_mano_obra']!, _costoManoObraMeta));
    } else if (isInserting) {
      context.missing(_costoManoObraMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trabajo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trabajo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      costoManoObra: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}costo_mano_obra'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
    );
  }

  @override
  $TrabajosTable createAlias(String alias) {
    return $TrabajosTable(attachedDatabase, alias);
  }
}

class Trabajo extends DataClass implements Insertable<Trabajo> {
  final int id;
  final int ordenId;
  final String descripcion;
  final double costoManoObra;
  final DateTime fecha;
  const Trabajo(
      {required this.id,
      required this.ordenId,
      required this.descripcion,
      required this.costoManoObra,
      required this.fecha});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['descripcion'] = Variable<String>(descripcion);
    map['costo_mano_obra'] = Variable<double>(costoManoObra);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  TrabajosCompanion toCompanion(bool nullToAbsent) {
    return TrabajosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      descripcion: Value(descripcion),
      costoManoObra: Value(costoManoObra),
      fecha: Value(fecha),
    );
  }

  factory Trabajo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trabajo(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      costoManoObra: serializer.fromJson<double>(json['costoManoObra']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'descripcion': serializer.toJson<String>(descripcion),
      'costoManoObra': serializer.toJson<double>(costoManoObra),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  Trabajo copyWith(
          {int? id,
          int? ordenId,
          String? descripcion,
          double? costoManoObra,
          DateTime? fecha}) =>
      Trabajo(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        descripcion: descripcion ?? this.descripcion,
        costoManoObra: costoManoObra ?? this.costoManoObra,
        fecha: fecha ?? this.fecha,
      );
  Trabajo copyWithCompanion(TrabajosCompanion data) {
    return Trabajo(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      costoManoObra: data.costoManoObra.present
          ? data.costoManoObra.value
          : this.costoManoObra,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trabajo(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoManoObra: $costoManoObra, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ordenId, descripcion, costoManoObra, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trabajo &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.descripcion == this.descripcion &&
          other.costoManoObra == this.costoManoObra &&
          other.fecha == this.fecha);
}

class TrabajosCompanion extends UpdateCompanion<Trabajo> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<String> descripcion;
  final Value<double> costoManoObra;
  final Value<DateTime> fecha;
  const TrabajosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.costoManoObra = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  TrabajosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required String descripcion,
    required double costoManoObra,
    required DateTime fecha,
  })  : ordenId = Value(ordenId),
        descripcion = Value(descripcion),
        costoManoObra = Value(costoManoObra),
        fecha = Value(fecha);
  static Insertable<Trabajo> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<String>? descripcion,
    Expression<double>? costoManoObra,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (descripcion != null) 'descripcion': descripcion,
      if (costoManoObra != null) 'costo_mano_obra': costoManoObra,
      if (fecha != null) 'fecha': fecha,
    });
  }

  TrabajosCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<String>? descripcion,
      Value<double>? costoManoObra,
      Value<DateTime>? fecha}) {
    return TrabajosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      descripcion: descripcion ?? this.descripcion,
      costoManoObra: costoManoObra ?? this.costoManoObra,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (costoManoObra.present) {
      map['costo_mano_obra'] = Variable<double>(costoManoObra.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoManoObra: $costoManoObra, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $UsosRepuestoTable extends UsosRepuesto
    with TableInfo<$UsosRepuestoTable, UsoRepuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsosRepuestoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repuestoIdMeta =
      const VerificationMeta('repuestoId');
  @override
  late final GeneratedColumn<int> repuestoId = GeneratedColumn<int>(
      'repuesto_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precioUnitarioMeta =
      const VerificationMeta('precioUnitario');
  @override
  late final GeneratedColumn<double> precioUnitario = GeneratedColumn<double>(
      'precio_unitario', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ordenId, repuestoId, cantidad, precioUnitario];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usos_repuesto';
  @override
  VerificationContext validateIntegrity(Insertable<UsoRepuesto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('repuesto_id')) {
      context.handle(
          _repuestoIdMeta,
          repuestoId.isAcceptableOrUnknown(
              data['repuesto_id']!, _repuestoIdMeta));
    } else if (isInserting) {
      context.missing(_repuestoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
          _precioUnitarioMeta,
          precioUnitario.isAcceptableOrUnknown(
              data['precio_unitario']!, _precioUnitarioMeta));
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {ordenId, repuestoId},
      ];
  @override
  UsoRepuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsoRepuesto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      repuestoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repuesto_id'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      precioUnitario: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}precio_unitario'])!,
    );
  }

  @override
  $UsosRepuestoTable createAlias(String alias) {
    return $UsosRepuestoTable(attachedDatabase, alias);
  }
}

class UsoRepuesto extends DataClass implements Insertable<UsoRepuesto> {
  final int id;
  final int ordenId;
  final int repuestoId;
  final int cantidad;

  /// Precio al momento de usarlo (si el precio cambia, el historial no).
  final double precioUnitario;
  const UsoRepuesto(
      {required this.id,
      required this.ordenId,
      required this.repuestoId,
      required this.cantidad,
      required this.precioUnitario});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['repuesto_id'] = Variable<int>(repuestoId);
    map['cantidad'] = Variable<int>(cantidad);
    map['precio_unitario'] = Variable<double>(precioUnitario);
    return map;
  }

  UsosRepuestoCompanion toCompanion(bool nullToAbsent) {
    return UsosRepuestoCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      repuestoId: Value(repuestoId),
      cantidad: Value(cantidad),
      precioUnitario: Value(precioUnitario),
    );
  }

  factory UsoRepuesto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsoRepuesto(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      repuestoId: serializer.fromJson<int>(json['repuestoId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      precioUnitario: serializer.fromJson<double>(json['precioUnitario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'repuestoId': serializer.toJson<int>(repuestoId),
      'cantidad': serializer.toJson<int>(cantidad),
      'precioUnitario': serializer.toJson<double>(precioUnitario),
    };
  }

  UsoRepuesto copyWith(
          {int? id,
          int? ordenId,
          int? repuestoId,
          int? cantidad,
          double? precioUnitario}) =>
      UsoRepuesto(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        repuestoId: repuestoId ?? this.repuestoId,
        cantidad: cantidad ?? this.cantidad,
        precioUnitario: precioUnitario ?? this.precioUnitario,
      );
  UsoRepuesto copyWithCompanion(UsosRepuestoCompanion data) {
    return UsoRepuesto(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      repuestoId:
          data.repuestoId.present ? data.repuestoId.value : this.repuestoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsoRepuesto(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ordenId, repuestoId, cantidad, precioUnitario);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsoRepuesto &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.repuestoId == this.repuestoId &&
          other.cantidad == this.cantidad &&
          other.precioUnitario == this.precioUnitario);
}

class UsosRepuestoCompanion extends UpdateCompanion<UsoRepuesto> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<int> repuestoId;
  final Value<int> cantidad;
  final Value<double> precioUnitario;
  const UsosRepuestoCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.repuestoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
  });
  UsosRepuestoCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required int repuestoId,
    required int cantidad,
    required double precioUnitario,
  })  : ordenId = Value(ordenId),
        repuestoId = Value(repuestoId),
        cantidad = Value(cantidad),
        precioUnitario = Value(precioUnitario);
  static Insertable<UsoRepuesto> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<int>? repuestoId,
    Expression<int>? cantidad,
    Expression<double>? precioUnitario,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (repuestoId != null) 'repuesto_id': repuestoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
    });
  }

  UsosRepuestoCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<int>? repuestoId,
      Value<int>? cantidad,
      Value<double>? precioUnitario}) {
    return UsosRepuestoCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      repuestoId: repuestoId ?? this.repuestoId,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (repuestoId.present) {
      map['repuesto_id'] = Variable<int>(repuestoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<double>(precioUnitario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsosRepuestoCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $EquiposTable equipos = $EquiposTable(this);
  late final $TecnicosTable tecnicos = $TecnicosTable(this);
  late final $RepuestosTable repuestos = $RepuestosTable(this);
  late final $OrdenesTable ordenes = $OrdenesTable(this);
  late final $TrabajosTable trabajos = $TrabajosTable(this);
  late final $UsosRepuestoTable usosRepuesto = $UsosRepuestoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [clientes, equipos, tecnicos, repuestos, ordenes, trabajos, usosRepuesto];
}

typedef $$ClientesTableCreateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  required String nombre,
  required String telefono,
});
typedef $$ClientesTableUpdateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> telefono,
});

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);
}

class $$ClientesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
    Cliente,
    PrefetchHooks Function()> {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> telefono = const Value.absent(),
          }) =>
              ClientesCompanion(
            id: id,
            nombre: nombre,
            telefono: telefono,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required String telefono,
          }) =>
              ClientesCompanion.insert(
            id: id,
            nombre: nombre,
            telefono: telefono,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClientesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
    Cliente,
    PrefetchHooks Function()>;
typedef $$EquiposTableCreateCompanionBuilder = EquiposCompanion Function({
  Value<int> id,
  required int clienteId,
  required TipoEquipo tipo,
  required String marca,
  required String modelo,
  required String numeroSerie,
});
typedef $$EquiposTableUpdateCompanionBuilder = EquiposCompanion Function({
  Value<int> id,
  Value<int> clienteId,
  Value<TipoEquipo> tipo,
  Value<String> marca,
  Value<String> modelo,
  Value<String> numeroSerie,
});

class $$EquiposTableFilterComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoEquipo, TipoEquipo, String> get tipo =>
      $composableBuilder(
          column: $table.tipo,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => ColumnFilters(column));
}

class $$EquiposTableOrderingComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => ColumnOrderings(column));
}

class $$EquiposTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoEquipo, String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => column);
}

class $$EquiposTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EquiposTable,
    Equipo,
    $$EquiposTableFilterComposer,
    $$EquiposTableOrderingComposer,
    $$EquiposTableAnnotationComposer,
    $$EquiposTableCreateCompanionBuilder,
    $$EquiposTableUpdateCompanionBuilder,
    (Equipo, BaseReferences<_$AppDatabase, $EquiposTable, Equipo>),
    Equipo,
    PrefetchHooks Function()> {
  $$EquiposTableTableManager(_$AppDatabase db, $EquiposTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquiposTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquiposTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquiposTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> clienteId = const Value.absent(),
            Value<TipoEquipo> tipo = const Value.absent(),
            Value<String> marca = const Value.absent(),
            Value<String> modelo = const Value.absent(),
            Value<String> numeroSerie = const Value.absent(),
          }) =>
              EquiposCompanion(
            id: id,
            clienteId: clienteId,
            tipo: tipo,
            marca: marca,
            modelo: modelo,
            numeroSerie: numeroSerie,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int clienteId,
            required TipoEquipo tipo,
            required String marca,
            required String modelo,
            required String numeroSerie,
          }) =>
              EquiposCompanion.insert(
            id: id,
            clienteId: clienteId,
            tipo: tipo,
            marca: marca,
            modelo: modelo,
            numeroSerie: numeroSerie,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EquiposTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EquiposTable,
    Equipo,
    $$EquiposTableFilterComposer,
    $$EquiposTableOrderingComposer,
    $$EquiposTableAnnotationComposer,
    $$EquiposTableCreateCompanionBuilder,
    $$EquiposTableUpdateCompanionBuilder,
    (Equipo, BaseReferences<_$AppDatabase, $EquiposTable, Equipo>),
    Equipo,
    PrefetchHooks Function()>;
typedef $$TecnicosTableCreateCompanionBuilder = TecnicosCompanion Function({
  Value<int> id,
  required String nombre,
});
typedef $$TecnicosTableUpdateCompanionBuilder = TecnicosCompanion Function({
  Value<int> id,
  Value<String> nombre,
});

class $$TecnicosTableFilterComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));
}

class $$TecnicosTableOrderingComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));
}

class $$TecnicosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);
}

class $$TecnicosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TecnicosTable,
    Tecnico,
    $$TecnicosTableFilterComposer,
    $$TecnicosTableOrderingComposer,
    $$TecnicosTableAnnotationComposer,
    $$TecnicosTableCreateCompanionBuilder,
    $$TecnicosTableUpdateCompanionBuilder,
    (Tecnico, BaseReferences<_$AppDatabase, $TecnicosTable, Tecnico>),
    Tecnico,
    PrefetchHooks Function()> {
  $$TecnicosTableTableManager(_$AppDatabase db, $TecnicosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TecnicosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TecnicosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TecnicosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
          }) =>
              TecnicosCompanion(
            id: id,
            nombre: nombre,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
          }) =>
              TecnicosCompanion.insert(
            id: id,
            nombre: nombre,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TecnicosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TecnicosTable,
    Tecnico,
    $$TecnicosTableFilterComposer,
    $$TecnicosTableOrderingComposer,
    $$TecnicosTableAnnotationComposer,
    $$TecnicosTableCreateCompanionBuilder,
    $$TecnicosTableUpdateCompanionBuilder,
    (Tecnico, BaseReferences<_$AppDatabase, $TecnicosTable, Tecnico>),
    Tecnico,
    PrefetchHooks Function()>;
typedef $$RepuestosTableCreateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  required String nombre,
  required String codigo,
  required double precio,
  required int existencias,
  Value<int> stockMinimo,
});
typedef $$RepuestosTableUpdateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> codigo,
  Value<double> precio,
  Value<int> existencias,
  Value<int> stockMinimo,
});

class $$RepuestosTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnFilters(column));
}

class $$RepuestosTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnOrderings(column));
}

class $$RepuestosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => column);

  GeneratedColumn<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => column);
}

class $$RepuestosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto>),
    Repuesto,
    PrefetchHooks Function()> {
  $$RepuestosTableTableManager(_$AppDatabase db, $RepuestosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<double> precio = const Value.absent(),
            Value<int> existencias = const Value.absent(),
            Value<int> stockMinimo = const Value.absent(),
          }) =>
              RepuestosCompanion(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precio: precio,
            existencias: existencias,
            stockMinimo: stockMinimo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required String codigo,
            required double precio,
            required int existencias,
            Value<int> stockMinimo = const Value.absent(),
          }) =>
              RepuestosCompanion.insert(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precio: precio,
            existencias: existencias,
            stockMinimo: stockMinimo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RepuestosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto>),
    Repuesto,
    PrefetchHooks Function()>;
typedef $$OrdenesTableCreateCompanionBuilder = OrdenesCompanion Function({
  Value<int> id,
  required int equipoId,
  Value<int?> tecnicoId,
  required EstadoOrden estado,
  required String falla,
  required DateTime fechaRecepcion,
  required DateTime fechaActualizacion,
});
typedef $$OrdenesTableUpdateCompanionBuilder = OrdenesCompanion Function({
  Value<int> id,
  Value<int> equipoId,
  Value<int?> tecnicoId,
  Value<EstadoOrden> estado,
  Value<String> falla,
  Value<DateTime> fechaRecepcion,
  Value<DateTime> fechaActualizacion,
});

class $$OrdenesTableFilterComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get equipoId => $composableBuilder(
      column: $table.equipoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tecnicoId => $composableBuilder(
      column: $table.tecnicoId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<EstadoOrden, EstadoOrden, String> get estado =>
      $composableBuilder(
          column: $table.estado,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get falla => $composableBuilder(
      column: $table.falla, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaRecepcion => $composableBuilder(
      column: $table.fechaRecepcion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaActualizacion => $composableBuilder(
      column: $table.fechaActualizacion,
      builder: (column) => ColumnFilters(column));
}

class $$OrdenesTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get equipoId => $composableBuilder(
      column: $table.equipoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tecnicoId => $composableBuilder(
      column: $table.tecnicoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get falla => $composableBuilder(
      column: $table.falla, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaRecepcion => $composableBuilder(
      column: $table.fechaRecepcion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaActualizacion => $composableBuilder(
      column: $table.fechaActualizacion,
      builder: (column) => ColumnOrderings(column));
}

class $$OrdenesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get equipoId =>
      $composableBuilder(column: $table.equipoId, builder: (column) => column);

  GeneratedColumn<int> get tecnicoId =>
      $composableBuilder(column: $table.tecnicoId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EstadoOrden, String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get falla =>
      $composableBuilder(column: $table.falla, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaRecepcion => $composableBuilder(
      column: $table.fechaRecepcion, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaActualizacion => $composableBuilder(
      column: $table.fechaActualizacion, builder: (column) => column);
}

class $$OrdenesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdenesTable,
    Orden,
    $$OrdenesTableFilterComposer,
    $$OrdenesTableOrderingComposer,
    $$OrdenesTableAnnotationComposer,
    $$OrdenesTableCreateCompanionBuilder,
    $$OrdenesTableUpdateCompanionBuilder,
    (Orden, BaseReferences<_$AppDatabase, $OrdenesTable, Orden>),
    Orden,
    PrefetchHooks Function()> {
  $$OrdenesTableTableManager(_$AppDatabase db, $OrdenesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> equipoId = const Value.absent(),
            Value<int?> tecnicoId = const Value.absent(),
            Value<EstadoOrden> estado = const Value.absent(),
            Value<String> falla = const Value.absent(),
            Value<DateTime> fechaRecepcion = const Value.absent(),
            Value<DateTime> fechaActualizacion = const Value.absent(),
          }) =>
              OrdenesCompanion(
            id: id,
            equipoId: equipoId,
            tecnicoId: tecnicoId,
            estado: estado,
            falla: falla,
            fechaRecepcion: fechaRecepcion,
            fechaActualizacion: fechaActualizacion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int equipoId,
            Value<int?> tecnicoId = const Value.absent(),
            required EstadoOrden estado,
            required String falla,
            required DateTime fechaRecepcion,
            required DateTime fechaActualizacion,
          }) =>
              OrdenesCompanion.insert(
            id: id,
            equipoId: equipoId,
            tecnicoId: tecnicoId,
            estado: estado,
            falla: falla,
            fechaRecepcion: fechaRecepcion,
            fechaActualizacion: fechaActualizacion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdenesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdenesTable,
    Orden,
    $$OrdenesTableFilterComposer,
    $$OrdenesTableOrderingComposer,
    $$OrdenesTableAnnotationComposer,
    $$OrdenesTableCreateCompanionBuilder,
    $$OrdenesTableUpdateCompanionBuilder,
    (Orden, BaseReferences<_$AppDatabase, $OrdenesTable, Orden>),
    Orden,
    PrefetchHooks Function()>;
typedef $$TrabajosTableCreateCompanionBuilder = TrabajosCompanion Function({
  Value<int> id,
  required int ordenId,
  required String descripcion,
  required double costoManoObra,
  required DateTime fecha,
});
typedef $$TrabajosTableUpdateCompanionBuilder = TrabajosCompanion Function({
  Value<int> id,
  Value<int> ordenId,
  Value<String> descripcion,
  Value<double> costoManoObra,
  Value<DateTime> fecha,
});

class $$TrabajosTableFilterComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));
}

class $$TrabajosTableOrderingComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));
}

class $$TrabajosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordenId =>
      $composableBuilder(column: $table.ordenId, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$TrabajosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrabajosTable,
    Trabajo,
    $$TrabajosTableFilterComposer,
    $$TrabajosTableOrderingComposer,
    $$TrabajosTableAnnotationComposer,
    $$TrabajosTableCreateCompanionBuilder,
    $$TrabajosTableUpdateCompanionBuilder,
    (Trabajo, BaseReferences<_$AppDatabase, $TrabajosTable, Trabajo>),
    Trabajo,
    PrefetchHooks Function()> {
  $$TrabajosTableTableManager(_$AppDatabase db, $TrabajosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrabajosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrabajosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrabajosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<double> costoManoObra = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
          }) =>
              TrabajosCompanion(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            costoManoObra: costoManoObra,
            fecha: fecha,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required String descripcion,
            required double costoManoObra,
            required DateTime fecha,
          }) =>
              TrabajosCompanion.insert(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            costoManoObra: costoManoObra,
            fecha: fecha,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TrabajosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrabajosTable,
    Trabajo,
    $$TrabajosTableFilterComposer,
    $$TrabajosTableOrderingComposer,
    $$TrabajosTableAnnotationComposer,
    $$TrabajosTableCreateCompanionBuilder,
    $$TrabajosTableUpdateCompanionBuilder,
    (Trabajo, BaseReferences<_$AppDatabase, $TrabajosTable, Trabajo>),
    Trabajo,
    PrefetchHooks Function()>;
typedef $$UsosRepuestoTableCreateCompanionBuilder = UsosRepuestoCompanion
    Function({
  Value<int> id,
  required int ordenId,
  required int repuestoId,
  required int cantidad,
  required double precioUnitario,
});
typedef $$UsosRepuestoTableUpdateCompanionBuilder = UsosRepuestoCompanion
    Function({
  Value<int> id,
  Value<int> ordenId,
  Value<int> repuestoId,
  Value<int> cantidad,
  Value<double> precioUnitario,
});

class $$UsosRepuestoTableFilterComposer
    extends Composer<_$AppDatabase, $UsosRepuestoTable> {
  $$UsosRepuestoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario,
      builder: (column) => ColumnFilters(column));
}

class $$UsosRepuestoTableOrderingComposer
    extends Composer<_$AppDatabase, $UsosRepuestoTable> {
  $$UsosRepuestoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario,
      builder: (column) => ColumnOrderings(column));
}

class $$UsosRepuestoTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsosRepuestoTable> {
  $$UsosRepuestoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordenId =>
      $composableBuilder(column: $table.ordenId, builder: (column) => column);

  GeneratedColumn<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario, builder: (column) => column);
}

class $$UsosRepuestoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsosRepuestoTable,
    UsoRepuesto,
    $$UsosRepuestoTableFilterComposer,
    $$UsosRepuestoTableOrderingComposer,
    $$UsosRepuestoTableAnnotationComposer,
    $$UsosRepuestoTableCreateCompanionBuilder,
    $$UsosRepuestoTableUpdateCompanionBuilder,
    (
      UsoRepuesto,
      BaseReferences<_$AppDatabase, $UsosRepuestoTable, UsoRepuesto>
    ),
    UsoRepuesto,
    PrefetchHooks Function()> {
  $$UsosRepuestoTableTableManager(_$AppDatabase db, $UsosRepuestoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsosRepuestoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsosRepuestoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsosRepuestoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<int> repuestoId = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<double> precioUnitario = const Value.absent(),
          }) =>
              UsosRepuestoCompanion(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
            precioUnitario: precioUnitario,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required int repuestoId,
            required int cantidad,
            required double precioUnitario,
          }) =>
              UsosRepuestoCompanion.insert(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
            precioUnitario: precioUnitario,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsosRepuestoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsosRepuestoTable,
    UsoRepuesto,
    $$UsosRepuestoTableFilterComposer,
    $$UsosRepuestoTableOrderingComposer,
    $$UsosRepuestoTableAnnotationComposer,
    $$UsosRepuestoTableCreateCompanionBuilder,
    $$UsosRepuestoTableUpdateCompanionBuilder,
    (
      UsoRepuesto,
      BaseReferences<_$AppDatabase, $UsosRepuestoTable, UsoRepuesto>
    ),
    UsoRepuesto,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$EquiposTableTableManager get equipos =>
      $$EquiposTableTableManager(_db, _db.equipos);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db, _db.tecnicos);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db, _db.repuestos);
  $$OrdenesTableTableManager get ordenes =>
      $$OrdenesTableTableManager(_db, _db.ordenes);
  $$TrabajosTableTableManager get trabajos =>
      $$TrabajosTableTableManager(_db, _db.trabajos);
  $$UsosRepuestoTableTableManager get usosRepuesto =>
      $$UsosRepuestoTableTableManager(_db, _db.usosRepuesto);
}
