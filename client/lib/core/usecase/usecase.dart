abstract class Usecase<Type, Param> {

  Future<Type> call({required Param param});

}

class NoParams {
  const NoParams();
}