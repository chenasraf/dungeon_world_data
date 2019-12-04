import 'package:dungeon_world_data/_base.dart';
import 'package:dungeon_world_data/mappers.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class Equipment extends DWEntity {
  /// Equipment key
  String key;

  /// Equipment name
  String name;

  /// Equipment name, in plural
  String pluralName;

  /// Item description
  String description;

  /// Equipment tags
  List<Tag> tags;

  Equipment({
    String key,
    @required this.name,
    @required this.pluralName,
    @required this.description,
    @required this.tags,
  }) : key = key ?? Uuid().v4();

  @override
  toString() => '$name: $description (tags: $tags)';

  factory Equipment.fromJSON(Map map) => Equipment(
        key: map['key'],
        name: map['name'],
        pluralName: map['plural_name'],
        description: map['description'],
        tags: listMapper(map['tags'], (i) => Tag.fromJSON(i)),
      );

  @override
  Map toJSON() {
    return {
      'name': name,
      'tags': listMapper<Tag, dynamic>(tags, (t) => t.toJSON()),
      'description': description,
      'plural_name': pluralName,
      'key': key,
    };
  }

  @override
  Equipment copy() {
    return Equipment.fromJSON(toJSON());
  }
}
