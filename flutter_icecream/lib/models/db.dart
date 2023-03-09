import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Db { // Db isimli bir sınıf açıyoruz
  Database? db; // db isimli bir değişken oluşturuyoruz
  Future open() async { // 
    sqfliteFfiInit();
    var databasePath = await databaseFactoryFfi.getDatabasesPath();
    String path = join(databasePath, "iceCream.db");
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    print(path);

    db = await databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (Database db, int index) async {
              await db.execute(
                '''
                CREATE TABLE iceCreams(
                  id integer primary key autoIncrement,
                  flavour varchar(255) not null,
                  image varchar(255) not null,
                  price double not null,
                  count int not null,
                  lightColor int not null,
                  darkColor int not null
                )
                '''
              );
            }));
  }
}
