class SingletonDataStore {
  SingletonDataStore._privateConstructor();

  static final SingletonDataStore _instance = SingletonDataStore._privateConstructor();

  static SingletonDataStore get instance => _instance;

  int? myData;

  void updateData(int? newData) {
    myData = newData;
  }
}
