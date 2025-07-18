// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchlistEntryAdapter extends TypeAdapter<WatchlistEntry> {
  @override
  final int typeId = 1;

  @override
  WatchlistEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchlistEntry(
      movie: fields[0] as Movie,
      status: fields[1] as WatchStatus,
      score: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, WatchlistEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.movie)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchlistEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WatchStatusAdapter extends TypeAdapter<WatchStatus> {
  @override
  final int typeId = 2;

  @override
  WatchStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WatchStatus.planToWatch;
      case 1:
        return WatchStatus.watched;
      case 2:
        return WatchStatus.rewatched;
      case 3:
        return WatchStatus.dropped;
      default:
        return WatchStatus.planToWatch;
    }
  }

  @override
  void write(BinaryWriter writer, WatchStatus obj) {
    switch (obj) {
      case WatchStatus.planToWatch:
        writer.writeByte(0);
        break;
      case WatchStatus.watched:
        writer.writeByte(1);
        break;
      case WatchStatus.rewatched:
        writer.writeByte(2);
        break;
      case WatchStatus.dropped:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
