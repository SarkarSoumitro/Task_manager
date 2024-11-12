import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

String DefaultProfilePic =
    "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAkACQAAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCABkAGQDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9/KKKKACiiigAppmVZVjLL5jAkLnkgdTj8RXif7Zv7Uz/ALP3hq2s9JEM3iDVAxi34YWkY/5aFe5JOFB44YnOMH4rh/ac8bQvrEv9uXTXWuIsVzcsQ04jGTsSQjciknopA+UdhigD9ENM/aD8Fav4nuNGh8SaX/aVrO1s8Mknl5kBwVUtgOQQR8pPSuyr8gvPkEvmbm3/AN4Hmvrf9gv9riSC5k8J+LdWiW02BtNu7yUL5bZA8ksf4Tn5c4wRgdQAAfY1FIjiRQykMrDII70tABRRRQAUUUUAFFFFABXAftMfGdfgT8Jb/WlEb3zEW1ij/deZgSCR3CqGbHfbjjNd/Xyr/wAFS7+aLwd4VtlB8ia4uJH9AyiIL+jtQB8d+KPFOpeOvEM+oalc3F/qF7IWd3Jd3Y9h+gAHsK6zQf2Y/G3iC2WZdH+yRyDK/bJ0gYj/AHSdw/EV6N+xv8MLVtLm8VXkKy3LTNb2G8ZEIXh5AP7xJ2g9gDjrXvGaAPlMfse+NT/yy0kf9vw/wqj8W/gjN8GvCmjTXd1HcanqVzL5hgz5cCoqlVUnBJySScDoMV9dV5p+1d4Il8YfCmS4to2kudFmF6FAyWjwVkx9FO7/AIDQBp/8E5P2ir3Vr6TwPq9w1xGsJm0t5GyybeWiHqNuWA7bD6jH15X5o/sW3Ult+0r4WeH7zXOwkf3WBVv/AB0mv0uoAKKKKACiiigAooooAK+cP+Cmmix3/wAE9PvNwWbT9QU4xyY3BU/+P+V+dfR9eRftjeDZPHHwt1DT44/Mae0lMfHSRdrIPxbbQB5N+zzYrp/wR8Nqox5lp5ze5d2Y/wA67KsH4VaPceHvhl4fsbqMw3VrYRRzRnrG23lT7jpW9QAUf5wR1oooA8T/AGYfBdnY/t3XlvbItvY6PPczJEB8qAptUD0AeRQBX3hXyv8As7fC270z4/8AizXLiPYdS1CH7Ic/fgBR2Yf8CIH/AAA19UUAFFFFABRRRQAUUUUAFZ3ifw7F4n0treT5ecq2M7T0/r/I9q0aKAPBdb0xtH1Sa3JZvKcqCRjOCR/Sqtd38Y/DTQXa6hH9yU7W56HHT9M/ix7VwlABRRWh4Y0Zte1u3tl2/vG6Hv3x+QP4AntQB6B8KvBUenWkepSHdNICFUr/AKsglev5/nXaVFY2i2FnFCm4rEoUE9TjufepaACiiigAooooAKKKbNMlvE0kjLHGgyzMcBR6k0AOpssqwRNJIyoiAszMcBQOpJrzfx3+1j4N8D74/wC0Dqlwv/LOyAkHp98kKfwJPtXg/wAcP2yb34leH5tH0yy/suynbEsnnF5J0/ungYB7jHOBzjIIB6V4z/aE034peJ7vw5pKs9rYRmc3wOC8g+T5B/dG48nr7Dry9z4tk0CXydTt5B/cuIRmOX8Ox9q8T+F3jpfAPif7ZNC09vPGYZgp+dQSDuHqQR0717xouu6b4y0rzrOaG9tX4cYztPoynkH60AZt18S7CKP9zHcTN2G3YPzNZOmfG668D+J7bXpoFuIbN9otgxVQrAocH1w3Xn6dq3L7wBpUgaQq9sqgsxWXaqj1OeAK8p+KPifQ3tm03R/NvG3gy3TP+7GP4UHG769PTNA9D7X+G/xK0r4p+Go9T0mfzIm+WSNuJIG7qw9f0Pat+vgP4JfGrUfgr4n+3Wi/aLeZdlxbMxCTL2/EHkHsfYkH6V8E/tv+FPEjJHqMd1o8zYBLDzosnsCo3f8AjuKBHs9FUdA8Taf4psftOm31rfQdN8EgcA+hx0PsavUAFFFFAHB/HH4+aX8FNIVrj/StSuFJt7VWwT/tMey5BHqcHsCR8h/FD9oLxJ8Vbxmvr6SO1zlLWE7IU6fw+vHU5PvVz9qjWptZ+N2uNNI7CGdoUUnIUJ8gx6cKPxrzugAZizZPJPUnvRRRQAVo+FfFV54M1qO+s5GV4z86Z+WZO6sO4P6dazqKAPQPjb8TG8S3UWnWMjLpqxJLKAf9c7KGAPsoIGPXPtXn9BOTRQAUUUUAa3hXxzq3gnUUutLvrizmj4DRuVyPT6e3evpH4G/ttR61cw6Z4sWO3mfCJfoNqsf+mg6D6jAHpgE18sUA7TkcEcgjtQB+l6OsiKykMrDIIPBFFeYfsfeKp/FPwTs/tEjSyafK9oGbqVAVgPoA+B6ACigD5h/angW3+OuvKowvnbvxb5j+pNee0UUAFFFFABRRRQAUUUUAFFFFABRRRQB9n/sPwrF8Esr/AMtL6Rj9dkY/pRRRQB//2Q==";
Future<void> WriteUserData(Map<String, dynamic> UserData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', UserData['token'] ?? '');
  await prefs.setString('email', UserData['data']['email'] ?? '');
  await prefs.setString('firstName', UserData['data']['firstName'] ?? '');
  await prefs.setString('lastName', UserData['data']['lastName'] ?? '');
  await prefs.setString('mobile', UserData['data']['mobile'] ?? '');
  await prefs.setString(
      'photo', UserData['data']['photo'] ?? DefaultProfilePic);
}

Future<String?> ReadUserData(String Key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(Key);
}

Future<void> WriteEmailVerification(String Email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('EmailVerification', Email);
}

Future<void> WriteOTPVerification(String OTP) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('OTPVerification', OTP);
}

Future<bool> RemoveToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  return true;
}

ShowBase64Image(String Base64String) {
  try {
    // Remove the Base64 prefix if it exists (e.g., "data:image/jpeg;base64,")
    if (Base64String.contains("base64,")) {
      Base64String = Base64String.split("base64,").last;
    }

    // Decode the Base64 string
    Uint8List decodedBytes = base64Decode(Base64String);

    // If the decoded bytes are empty, return the default profile picture
    if (decodedBytes.isEmpty) {
      return ShowBase64Image(DefaultProfilePic); // Return default profile pic
    }

    return decodedBytes; // Return the decoded bytes as Uint8List
  } catch (e) {
    // Handle errors and return default profile picture on error
    print("Error parsing Base64 image: $e");
    return ShowBase64Image(DefaultProfilePic); // Return default profile pic
  }
}
