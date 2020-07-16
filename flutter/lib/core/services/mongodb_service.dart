class MongoDbService {
  static MongoDbService _instance;
  static MongoDbService get instance {
    if (_instance == null) _instance = MongoDbService._init();
    return _instance;
  }

  MongoDbService._init();
  
}
