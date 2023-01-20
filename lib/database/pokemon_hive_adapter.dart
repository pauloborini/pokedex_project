import 'package:hive/hive.dart';
import 'package:pokedex_inicie/models/pokemon.dart';

class PokemonHiveAdapter extends TypeAdapter<Pokemon> {
  @override
  final typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    return Pokemon(
        id: reader.readInt(),
        name: reader.readString(),
        height: reader.readDouble(),
        weight: reader.readDouble(),
        image: reader.readString(),
        type: reader.readString(),
        hp: reader.readDouble(),
        attack: reader.readDouble(),
        defense: reader.readDouble(),
        speed: reader.readDouble(),
        specialAttack: reader.readDouble(),
        specialDefense: reader.readDouble());
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeDouble(obj.height);
    writer.writeDouble(obj.weight);
    writer.writeString(obj.image);
    writer.writeString(obj.type);
    writer.writeDouble(obj.hp);
    writer.writeDouble(obj.attack);
    writer.writeDouble(obj.defense);
    writer.writeDouble(obj.speed);
    writer.writeDouble(obj.specialAttack);
    writer.writeDouble(obj.specialDefense);
  }
}
