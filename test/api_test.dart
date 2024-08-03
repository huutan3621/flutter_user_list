import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_list/data/repositories/user_repository_impl.dart';
import 'package:flutter_user_list/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_user_list/data/models/response/app/response_model.dart';
import 'package:flutter_user_list/data/models/response/user/user_model.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';
import 'package:flutter_user_list/domain/repositories/user/user_repository.dart';
import 'package:flutter_user_list/core/services/dio_services.dart';
import 'package:flutter_user_list/core/utils/url_constant.dart';

import 'api_test.mocks.dart';

@GenerateMocks([DioClientService])
void main() async {
  late UserRepository userRepository;
  late MockDioClientService mockDioClientService;
  const int page = 1;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    mockDioClientService = MockDioClientService();
    userRepository = UserRepositoryImpl();

    await dotenv.load(fileName: ".env");

    await init();
  });

  group('getAllUser', () {
    test('returns a list of UserEntities on success', () async {
      // Mock response data
      final Map<String, dynamic> mockData = {
        "page": 1,
        "per_page": 6,
        "total": 12,
        "total_pages": 2,
        "data": [
          {
            "id": 1,
            "email": "user1@example.com",
            "first_name": "John",
            "last_name": "Doe",
            "avatar": "https://example.com/avatar1.jpg"
          },
          {
            "id": 2,
            "email": "janet.weaver@reqres.in",
            "first_name": "Janet",
            "last_name": "Weaver",
            "avatar": "https://reqres.in/img/faces/2-image.jpg"
          },
        ],
        "support": {
          "url": "https://reqres.in/#support-heading",
          "text":
              "To keep ReqRes free, contributions towards server costs are appreciated!"
        }
      };
      final responseModel = ResponseModel.fromJson(mockData);

      // Mock successful API call
      when(mockDioClientService.get(UrlConstant.getUserByPage(page)))
          .thenAnswer((_) => Future.value());

      // Call the method
      final userList = await userRepository.getAllUser(page);

      // Verify expectations
      expect(userList.length, 2);
      expect(userList[0].id, 1);
      expect(userList[0].email, 'user1@example.com');
      expect(userList[0].firstName, 'John');
      expect(userList[0].lastName, 'Doe');
      expect(userList[0].avatar, 'https://example.com/avatar1.jpg');
    });

    test('throws an exception on network error', () async {
      // Mock network error
      when(mockDioClientService.get(UrlConstant.getUserByPage(page)))
          .thenThrow(Exception('Network error'));

      // Expect an exception
      expect(() => userRepository.getAllUser(page), throwsException);
    });
  });
}
