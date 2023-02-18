import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/*
для работы с Hive его нужно сначала инициализировать
с помощью строчки Hive.initFlutter();
ее нужно поместить в main()

await Hive.initFlutter();
когда мы делаем main() async, то нужно использовать команду 
WidgetsFlutterBinding.ensureInitialized();

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();?
const app = MaterialApp(
    home: ExampleHiveWidget(),
  );
  runApp(app);  
}
*/
part 'ex_widget_model.g.dart';

class ExampleWidgetModel {
  Future<Box<User>>? userBox;

  void setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    userBox = Hive.openBox<User>('user_box');
    userBox?.then((box) {
      box.listenable().addListener(() {
        print(box.values);
      });
    });
  }

  void doSome() async {
    final box = await userBox;
    final user = User('ivan', 17);
    await box?.add(user);
  }

  void doSome3() async {
    //создаем специальное флаттер хранилище
    const secureStorage = FlutterSecureStorage();

    // if key not exists return null
    //смотрим есть ли у нас в сторидже ключ
    final containsEncriptionKey = await secureStorage.containsKey(key: 'key');

    //если ключа в хринилище нет, то создаем его
    if (!containsEncriptionKey) {
      final key = Hive.generateSecureKey();
//и переводим полученный ключ из байт в строку
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }

    final key = await secureStorage.read(key: 'key');
    final encryptionKey = base64Url.decode(key!);

    final encryptedBox = await Hive.openBox('vaultBox',
        encryptionCipher: HiveAesCipher(encryptionKey));
    encryptedBox.put('secret', 'Hive is cool');
    print(encryptedBox.get('secret'));
  }

  void doSome2() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PetAdapter());
    }
    // Hive.deleteBoxFromDisk('testBox');
    var box = await Hive.openBox<User>('testBox');
    var petBox = await Hive.openBox<Pet>('petBox');
    // final pet = Pet('pushok');
    // petBox.add(pet);
    // final pets = HiveList(petBox, objects: [pet]);
    // final user = User('Sergey', 115, pets);
    // await box.put('serg', user);
    //final user = box.get('ivan');
    // if (user != null) {
    //   user.age = 12;
    // }
    // user?.age = 12;
    // await user?.save();
    final user = box.get('serg');
    //final pet = user?.pets?[0];

    //print(pet);
  }
}

//можно поля удалять, старый ИД не использовать
//или добавлять, но тогда предыдущие объекты этого класса будут null, поэтому данное
//новое поле класса должно быть nullable (for ex. String?)
@HiveType(typeId: 0)
class User extends HiveObject {
// здесь раньше было поле с индексом 2, поле удалили
//попробуем использовать старый индекс - 2  @HiveField(2)String name;
/*
получили ошибку Exception: type 'Null' is not a subtype of type 'String' in type cast
можно в коментарии указать что определеный ид был удален, чтобы его потом не использовать
если удалить бокс Hive.deleteBoxFromDisk('testBox'), то такой ошибки не будет
 */
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  // @HiveField(3)
  // HiveList<Pet>? pets;

  User(this.name, this.age);

  @override
  String toString() => 'Name $name, age  $age '; // Just for print()
}

/*
final typeId = 0; похоже на ключ, идентификатор, чтобы Hive отличал классы (class User)
обязательно нужно соблюдать порядок записи 
writer.writeString(obj.name);
writer.writeInt(obj.age);     и чтения 
                                     reader.readString();
                                     reader.readInt();
то есть writeString --->readString();
        writeInt ---> readInt();
 */

@HiveType(typeId: 1)
class Pet extends HiveObject {
  @HiveField(0)
  String name;

  Pet(this.name);

  @override
  String toString() => 'Name $name'; // Just for print()
}
