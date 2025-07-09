# Wealcoder Coding Standard

A Wealcoder PHP_CodeSniffer standard that extends the official WordPress Coding Standards—customized for modern, secure, and consistent PHP development across all Wealcoder projects. Designed to enforce best practices and maintain high code quality in line with Wealcoder's engineering guidelines.

## Installation

Install via Composer:

```bash
composer require Wealcoder/wealcoder-coding-standard
```
For Global 
```bash
composer global require Wealcoder/wealcoder-coding-standard
```

The package will automatically:
- Install PHP_CodeSniffer and required dependencies
- Register the `Wealcoder-Coding-Standard` standard
- Set it as the default standard for your project

## Usage

### Command Line

#### Quick Check
```bash
vendor/bin/phpcs .
```

#### Using Composer Script
```bash
composer run phpcs
```

#### Custom Configuration
```bash
vendor/bin/phpcs --standard=Wealcoder-Coding-Standard path/to/files
```

### IDE Integration

For better IDE integration, create a `.phpcs.xml.dist` file in your project root:

```xml
<?xml version="1.0"?>
<ruleset name="Project Standards">
    <description>A customized PHP_CodeSniffer ruleset that extends the official WordPress Coding Standards, tailored for modern, secure, and consistent PHP development practices.</description>

    <!-- Scan these directories -->
    <file>src/</file>
    <file>inc/</file>
    
    <!-- Exclude these paths -->
    <exclude-pattern>vendor/</exclude-pattern>
    <exclude-pattern>node_modules/</exclude-pattern>
    <exclude-pattern>*.min.js</exclude-pattern>

    <!-- Configuration -->
    <config name="minimum_supported_wp_version" value="6.2" />
    <config name="testVersion" value="7.4-8.5" />

    <!-- Use WordPress Code standards -->
    <rule ref="Wealcoder-Coding-Standard" />

    <!-- Project-specific customizations -->
    <rule ref="WordPress.WP.I18n">
        <properties>
            <property name="text_domain" type="array">
                <element value="replace-with-your-current-text-domain"/>
            </property>
        </properties>
    </rule>
</ruleset>
```

### Continuous Integration

Add to your CI workflow:

```yaml
# GitHub Actions example
- name: PHP CodeSniffer
  run: composer run phpcs
```

## Configuration Details

### PHP Version Support
- **Minimum**: PHP 7.4
- **Maximum**: PHP 8.4
- **Compatibility**: Uses PHPCompatibilityWP for WordPress-specific compatibility checks

### Key Rules Applied
- WordPress Coding Standards (with sensible exclusions)
- Tab indentation (1 tab per indent level)
- Space inside parentheses for readability
- Superfluous whitespace detection
- PHP compatibility checking for WordPress

### Excluded Rules
The following rules are excluded for practical development:
- File naming conventions (WordPress.Files.FileName)
- Nonce verification requirements
- Direct database query restrictions
- Global variable override prohibitions
- Some documentation capitalization requirements

## Customization

### Project-Level Overrides

Create a `phpcs.xml.dist` file to override or add rules:

```xml
<rule ref="Wealcoder-Coding-Standard">
    <!-- Enable a rule that's disabled by default -->
    <exclude name="WordPress.Files.FileName" />
</rule>

<!-- Add custom exclusions -->
<rule ref="WordPress.Security.NonceVerification.Missing">
    <exclude-pattern>admin/ajax-handlers/*</exclude-pattern>
</rule>
```

### Inline Annotations

Disable rules for specific code blocks:

```php
// phpcs:disable WordPress.Security.NonceVerification.Missing
if ( isset( $_POST['data'] ) ) {
    // Process data without nonce check
}
// phpcs:enable WordPress.Security.NonceVerification.Missing
```

## Requirements

- PHP 7.4 or higher ( Upto 8.4 )
- Composer
- PHP_CodeSniffer 3.9.0 or higher

## Dependencies

- `dealerdirect/phpcodesniffer-composer-installer`: ^1.0
- `phpcompatibility/phpcompatibility-wp`: ^2.1
- `wp-coding-standards/wpcs`: ^3.1.0

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `composer run phpcs`
5. Submit a pull request

## License

GPL-3.0-or-later

---
## Author

**Wealcoder**  
Email: habib41juwel@gmail.com  
Organization: [Wealcoder](https://www.wealcoder.com/)
