import 'package:dio/dio.dart';
import 'package:flutter_heart_animation/app/models/photo_model.dart';

class HomeRepository {

  // We don't handle exceptions here just for simplicity
  Future<List<PhotoModel>> getPhotos() async {
    final Dio httpClient = Dio();
    final Response response = await httpClient.get('https://jsonplaceholder.typicode.com/photos');
    return response.data.map<PhotoModel>((json) => PhotoModel.fromJson(json)).toList();
  }
}