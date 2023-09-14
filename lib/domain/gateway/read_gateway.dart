abstract class ReadGateWay<T, H>{
  Future<T> read(H key);
}
