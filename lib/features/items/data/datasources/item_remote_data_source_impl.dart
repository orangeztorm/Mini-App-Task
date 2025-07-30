import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/item_model.dart';
import 'item_remote_data_source.dart';
import 'mock_data_service.dart';

/// Implementation of [ItemRemoteDataSource] using Dio HTTP client
@Injectable(as: ItemRemoteDataSource)
class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  const ItemRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ItemModel>> getItems() async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}${AppConstants.itemsEndpoint}',
        options: Options(
          receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
          sendTimeout: Duration(milliseconds: AppConstants.connectionTimeout),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData
            .map(
              (json) => ItemModel.fromApiResponse(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerException('Failed to fetch items: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        // Return mock data when network fails
        return MockDataService.getMockItems();
      } else {
        throw ServerException('Server error: ${e.message}');
      }
    } catch (e) {
      // Return mock data for any other errors
      return MockDataService.getMockItems();
    }
  }
}
