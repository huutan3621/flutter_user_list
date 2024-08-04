import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';
import 'package:flutter_user_list/domain/repositories/user/user_repository.dart';
import 'package:flutter_user_list/domain/usecases/user/user_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late UserUsecase userUsecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userUsecase = UserUsecase(mockUserRepository);
  });

  group('getAllUser', () {
    const int page = 1;
    final List<UserEntity> users = [
      UserEntity(
        id: 1,
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        avatar: 'https://example.com/avatar1.png',
      ),
      UserEntity(
        id: 2,
        email: 'test2@example.com',
        firstName: 'Jane',
        lastName: 'Doe',
        avatar: 'https://example.com/avatar2.png',
      ),
    ];

    test(
        'should return a list of users when the call to repository is successful',
        () async {
      // Arrange
      when(mockUserRepository.getAllUser(page)).thenAnswer((_) async => users);

      // Act
      final result = await userUsecase.getAllUser(page);

      // Assert
      print('Result: $result'); // Debugging print statement
      expect(result, users);
      verify(mockUserRepository.getAllUser(page));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should throw an exception when the call to repository fails', () {
      // Arrange
      when(mockUserRepository.getAllUser(page))
          .thenThrow(Exception('Failed to load users'));

      // Act
      final call = userUsecase.getAllUser(page);

      // Assert
      print('Expecting an exception to be thrown'); // Debugging print statement
      expect(() => call, throwsA(isA<Exception>()));
      verify(mockUserRepository.getAllUser(page));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
