import 'package:jwt_decode/jwt_decode.dart';

Future<Map<String, dynamic>> verifyToken({
  required String token,
  required String secretOrPublicKey,
}) async {
  try {
    final decoded = Jwt.parseJwt(token);
    return decoded;
  } catch (e) {
    throw Exception('Invalid token');
  }
}
