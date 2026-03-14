// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final typeId = 3;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      name: fields[0] as String,
      price: (fields[1] as num).toDouble(),
      quantity: (fields[2] as num).toInt(),
      description: fields[3] as String,
      isFeatured: fields[5] as bool,
      code: fields[6] as String,
      imageUrl: fields[4] as String?,
      expirationMonths: (fields[7] as num).toInt(),
      numberOfCalories: (fields[9] as num).toInt(),
      unitAmount: (fields[10] as num).toInt(),
      isOrganic: fields[8] == null ? false : fields[8] as bool,
      avgRate: fields[11] == null ? 0 : fields[11] as num,
      countRate: fields[12] == null ? 0 : fields[12] as num,
      sellingCount: fields[13] == null ? 0 : (fields[13] as num).toInt(),
      reviews: (fields[14] as List).cast<ReviewModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.isFeatured)
      ..writeByte(6)
      ..write(obj.code)
      ..writeByte(7)
      ..write(obj.expirationMonths)
      ..writeByte(8)
      ..write(obj.isOrganic)
      ..writeByte(9)
      ..write(obj.numberOfCalories)
      ..writeByte(10)
      ..write(obj.unitAmount)
      ..writeByte(11)
      ..write(obj.avgRate)
      ..writeByte(12)
      ..write(obj.countRate)
      ..writeByte(13)
      ..write(obj.sellingCount)
      ..writeByte(14)
      ..write(obj.reviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
