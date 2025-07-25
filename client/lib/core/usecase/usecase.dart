abstract class Usecase<Type, Param> {

  Future<Type> call({required Param param});

}