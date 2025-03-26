<h1>📱 Phone Validator</h1>

<p>A <strong>Dart package</strong> for validating Bangladeshi phone numbers.</p>

<h2>🚀 Features</h2>
<ul>
  <li>Supports <strong>+88</strong>, <strong>88</strong>, or no prefix (e.g., <code>+8801712345678</code>, <code>8801912345678</code>, <code>01712345678</code>).</li>
  <li>Ensures proper Bangladeshi mobile number format <code>01[3-9]XXXXXXXX</code> (11 digits).</li>
  <li>Simple and lightweight.</li>
</ul>

<h2>📌 Installation</h2>

<p>Add this package to your <code>pubspec.yaml</code>:</p>

<pre><code>
dependencies:
  phone_validator: ^1.0.0
</code></pre>

<p>Then, run:</p>

<pre><code>dart pub get</code></pre>

<h2>🎯 Usage</h2>

<p>Import the package and validate numbers:</p>

<pre><code>
import 'package:phone_validator/phone_validator.dart';

void main() {
  print(PhoneValidator.validate("+8801712345678")); // true
  print(PhoneValidator.validate("01712345678"));    // true
  print(PhoneValidator.validate("8801912345678"));  // true
  print(PhoneValidator.validate("0123456789"));     // false
}
</code></pre>

<h2>🛠️ Running Tests</h2>

<p>To run tests, execute:</p>

<pre><code>dart test</code></pre>

<h2>🔗 Repository</h2>

<p>Find this package on <strong>GitHub</strong>: <a href="https://github.com/jihanurrahman33/bd_phone_validator">Your Repository Link Here</a></p>

<h2>📜 License</h2>

<p>This project is licensed under the MIT License - see the <a href="LICENSE">LICENSE</a> file for details.</p>

<hr>

<p>Happy coding! 🚀</p>