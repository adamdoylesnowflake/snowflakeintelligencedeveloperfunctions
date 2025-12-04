# snowflakeintelligencedeveloperfunctions
Creates Snowflake Intelligence Developer functions

# `document_code_udf` Function Documentation

## Description

The `document_code_udf` function is an AI-powered documentation generator that creates comprehensive documentation for source code snippets. It leverages the AI_COMPLETE function to analyze code and produce detailed documentation including descriptions, parameters, return values, usage examples, and important implementation notes.

## Function Signature

```sql
CREATE OR REPLACE FUNCTION document_code_udf(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
```

## Parameters

| Parameter | Type | Default | Required | Description |
|-----------|------|---------|----------|-------------|
| `input_code` | STRING | - | Yes | The source code snippet to generate documentation for |
| `code_language` | STRING | 'auto' | No | Programming language of the input code. Use 'auto' for automatic detection |
| `model_name` | STRING | 'llama3.1-70b' | No | AI model to use for documentation generation |

## Return Value

Returns a `VARIANT` containing the generated documentation as structured text, including:
- Comprehensive code description
- Parameter explanations
- Return value descriptions
- Usage examples
- Important implementation notes
- Best practices and considerations

## Usage Examples

### Basic Documentation Generation
```sql
-- Document a Python function
SELECT document_code_udf(
    'def calculate_discount(price, discount_rate): 
        return price * (1 - discount_rate)',
    'python'
);
```

### Auto-Detect Language
```sql
-- Let the AI detect the programming language
SELECT document_code_udf(
    'function validateEmail(email) {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }'
);
```

### SQL Documentation
```sql
-- Document a SQL query
SELECT document_code_udf(
    'SELECT c.customer_name, SUM(o.total_amount) as total_spent
     FROM customers c
     JOIN orders o ON c.customer_id = o.customer_id
     WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
     GROUP BY c.customer_id, c.customer_name
     ORDER BY total_spent DESC',
    'sql'
);
```

### Using Different AI Models
```sql
-- Use a different AI model for documentation
SELECT document_code_udf(
    'class DataProcessor:
        def __init__(self, config):
            self.config = config
        
        def process(self, data):
            return self.transform(data)',
    'python',
    'claude-3-5-sonnet'
);
```

## Language Support

The function supports documentation generation for various programming languages:
- **Programming Languages:** Python, JavaScript, Java, C#, C++, Go, Rust, etc.
- **Query Languages:** SQL, PostgreSQL, MySQL, etc.
- **Markup Languages:** HTML, XML, Markdown
- **Configuration:** JSON, YAML, TOML
- **Scripting:** Bash, PowerShell, etc.

## AI Model Options

| Model | Strengths | Use Cases |
|-------|-----------|-----------|
| `llama3.1-70b` | Balanced performance and quality | General documentation tasks |
| `claude-3-5-sonnet` | Superior code understanding | Complex code analysis |
| `mistral-large2` | Fast processing | High-volume documentation |

## Best Practices

### Code Preparation
- Provide complete, compilable code snippets when possible
- Include relevant context (imports, dependencies) for better analysis
- Use meaningful variable and function names for clearer documentation

### Language Specification
- Specify the exact language when dealing with ambiguous syntax
- Use 'auto' for well-defined, unambiguous code
- Consider dialect-specific documentation (e.g., 'postgresql' vs 'mysql')

### Output Processing
```sql
-- Extract documentation from the VARIANT result
WITH doc_result AS (
    SELECT document_code_udf('your_code_here') as doc_variant
)
SELECT doc_variant:documentation::STRING as documentation
FROM doc_result;
```

## Integration Examples

### Batch Documentation
```sql
-- Document multiple functions in a batch
SELECT 
    function_name,
    document_code_udf(function_code, 'sql') as documentation
FROM my_stored_procedures
WHERE needs_documentation = true;
```

### Documentation Pipeline
```sql
-- Create a documentation table
CREATE TABLE code_documentation (
    code_id INTEGER,
    original_code TEXT,
    generated_docs VARIANT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert documented code
INSERT INTO code_documentation (code_id, original_code, generated_docs)
SELECT 
    id,
    source_code,
    document_code_udf(source_code, language)
FROM code_repository
WHERE documentation_status = 'pending';
```

## Important Notes

### Performance Considerations
- Documentation generation time varies based on code complexity and chosen model
- Larger models provide higher quality but slower processing
- Consider caching results for frequently documented code patterns

### Quality Factors
- Code clarity and structure directly impact documentation quality
- Well-commented code produces more accurate documentation
- Complete code contexts yield better parameter and return value descriptions

### Limitations
- Generated documentation should be reviewed for accuracy
- Complex algorithms may require manual documentation supplements
- Domain-specific code might need additional context for optimal results

### Security Considerations
- Avoid documenting code containing sensitive information (passwords, keys)
- Review generated documentation before public sharing
- Consider data privacy implications when processing proprietary code

## Error Handling

The function handles various error conditions gracefully:
- Invalid or malformed code produces best-effort documentation
- Unsupported languages fall back to general code analysis
- Model availability issues are handled by the AI_COMPLETE function

For optimal results, ensure input code is syntactically valid and provide appropriate language hints when dealing with ambiguous syntax.

# Test Generation Functions Documentation

This collection of SQL functions provides comprehensive AI-powered test generation capabilities for various programming languages and testing scenarios. Each function utilizes the AI_COMPLETE function to generate different types of tests based on input code.

## Functions Overview

### 1. `generate_tests`
**Purpose:** Generates a comprehensive test suite covering multiple testing scenarios

**Parameters:**
- `input_code` (STRING) - The source code to generate tests for
- `code_language` (STRING, default: 'auto') - Programming language of the input code
- `test_framework` (STRING, default: 'auto') - Testing framework to use
- `model_name` (STRING, default: 'llama3.1-70b') - AI model for test generation

**Returns:** VARIANT containing the complete test suite

**Test Coverage Includes:**
- Happy path tests with valid inputs
- Edge cases and boundary conditions
- Null/undefined value handling
- Error handling and exception testing
- Mocking framework integration
- Failure mode scenarios (network failures, resource exhaustion, timeouts)

**Usage Example:**
```sql
SELECT generate_tests(
    'def calculate_discount(price, percentage): return price * (1 - percentage/100)',
    'python',
    'pytest'
);
```

### 2. `generate_unit_tests`
**Purpose:** Generates isolated unit tests for individual functions/methods

**Parameters:**
- `input_code` (STRING) - Source code to test
- `code_language` (STRING, default: 'auto') - Programming language
- `test_framework` (STRING, default: 'auto') - Testing framework
- `model_name` (STRING, default: 'llama2-70b-chat') - AI model

**Returns:** VARIANT containing unit test implementations

**Features:**
- Tests each function in isolation
- Comprehensive mocking of dependencies
- Coverage of all code paths and branches
- Edge case and error condition testing

### 3. `generate_integration_tests`
**Purpose:** Generates tests for component interactions and system workflows

**Parameters:**
- `input_code` (STRING) - Source code for integration testing
- `code_language` (STRING, default: 'auto') - Programming language
- `test_framework` (STRING, default: 'auto') - Testing framework
- `model_name` (STRING, default: 'llama2-70b-chat') - AI model

**Returns:** VARIANT containing integration test suite

**Coverage:**
- Multi-component interactions
- Database and API integrations
- End-to-end workflows
- Error propagation testing
- Concurrent operation testing

### 4. `generate_test_cases`
**Purpose:** Creates specific test cases for user-defined scenarios

**Parameters:**
- `input_code` (STRING) - Code to generate test cases for
- `test_scenarios` (STRING) - Specific scenarios to test
- `code_language` (STRING, default: 'auto') - Programming language
- `model_name` (STRING, default: 'llama2-70b-chat') - AI model

**Returns:** VARIANT containing scenario-specific test cases

**Usage Example:**
```sql
SELECT generate_test_cases(
    'def process_payment(amount, currency)',
    'Test with invalid currencies, negative amounts, and zero values',
    'python'
);
```

### 5. `generate_sql_tests`
**Purpose:** Specialized test generation for SQL code (procedures, functions, queries)

**Parameters:**
- `sql_code` (STRING) - SQL code to test
- `test_framework` (STRING, default: 'pytest') - Testing framework
- `model_name` (STRING, default: 'llama2-70b-chat') - AI model

**Returns:** VARIANT containing SQL-specific tests

**SQL Testing Features:**
- NULL value handling across columns
- Empty result set scenarios
- Data type validation
- Constraint violation testing
- Transaction rollback scenarios
- Performance testing with large datasets

### 6. `generate_test_data`
**Purpose:** Creates test data fixtures and datasets

**Parameters:**
- `input_code` (STRING) - Code requiring test data
- `data_type` (STRING, default: 'comprehensive') - Type of test data to generate
- `code_language` (STRING, default: 'auto') - Programming language
- `model_name` (STRING, default: 'llama2-70b-chat') - AI model

**Returns:** VARIANT containing test data structures

**Data Types Generated:**
- Valid typical use case data
- Edge case boundary values
- Invalid and stress test data
- Special characters and Unicode
- Realistic production-like samples

### 7. `generate_mocks`
**Purpose:** Creates mock configurations for external dependencies

**Parameters:**
- `input_code` (STRING) - Code with external dependencies
- `code_language` (STRING, default: 'auto') - Programming language
- `model_name` (STRING, default: 'llama2-70b-chat') - AI model

**Returns:** VARIANT containing mock setup configurations

**Dependency Types Mocked:**
- Database connections and queries
- HTTP/API calls
- File system operations
- Time/date functions
- Environment variables
- External services and libraries

### 8. `generate_performance_tests`
**Purpose:** Creates performance and load testing scenarios

**Parameters:**
- `input_code` (STRING) - Code to performance test
- `code_language` (STRING, default: 'auto') - Programming language
- `model_name` (STRING, default: 'llama2-70b-chat') - AI model

**Returns:** VARIANT containing performance test implementations

**Performance Testing Includes:**
- Execution time measurement
- Memory usage monitoring
- Large dataset stress testing
- Concurrent execution testing
- Scalability limit identification
- Bottleneck analysis

## Usage Guidelines

1. **Automatic Detection:** Use 'auto' for `code_language` and `test_framework` parameters to enable automatic detection
2. **Model Selection:** Choose appropriate AI models based on complexity requirements
3. **Result Processing:** Parse the VARIANT return value to extract generated test code
4. **Integration:** Combine multiple function outputs for comprehensive test coverage

## Best Practices

- Start with `generate_tests` for overall coverage, then use specialized functions for specific needs
- Use `generate_test_data` and `generate_mocks` to support your main test implementations
- Review and customize generated tests before production use
- Combine unit and integration tests for complete coverage
- Include performance tests for critical code paths

# Code Refactoring Functions Documentation

This collection of SQL functions provides comprehensive AI-powered code refactoring and optimization recommendations for various programming languages and code types. Each function leverages the AI_COMPLETE function to analyze code and suggest improvements.

## Functions Overview

### 1. `refactor_code`
**Purpose:** Provides comprehensive refactoring recommendations across multiple dimensions

**Parameters:**
- `input_code` (STRING) - The source code to analyze and refactor
- `code_language` (STRING, default: 'auto') - Programming language of the input code
- `model_name` (STRING, default: 'llama3.1-70b') - AI model for analysis
- `focus_area` (STRING, default: 'all') - Specific refactoring focus area

**Returns:** VARIANT containing detailed refactoring recommendations

**Analysis Categories:**
- Code Quality Issues (code smells, anti-patterns)
- Performance Improvements (optimization suggestions)
- Readability Enhancements (clarity improvements)
- Security Concerns (vulnerability identification)
- Maintainability (long-term code health)
- Specific Refactoring Suggestions (before/after examples with priorities)
- Best Practices (language-specific recommendations)

**Usage Example:**
```sql
SELECT refactor_code(
    'function calculateTotal(items) { var total = 0; for(var i=0; i<items.length; i++) { total += items[i].price; } return total; }',
    'javascript',
    'llama3.1-70b',
    'performance'
);
```

**Focus Area Options:**
- `'all'` - Comprehensive analysis
- `'performance'` - Performance optimizations
- `'readability'` - Code clarity improvements
- `'security'` - Security vulnerability assessment
- `'maintainability'` - Long-term maintenance considerations

### 2. `refactor_pattern`
**Purpose:** Provides targeted refactoring recommendations for specific code patterns

**Parameters:**
- `input_code` (STRING) - Code containing the pattern to analyze
- `pattern_type` (STRING) - Specific pattern type to focus on
- `model_name` (STRING, default: 'llama3.1-70b') - AI model for analysis

**Returns:** VARIANT containing pattern-specific refactoring suggestions

**Common Pattern Types:**
- `'loops'` - Loop optimization and alternatives
- `'conditionals'` - If-else and switch statement improvements
- `'error-handling'` - Exception handling patterns
- `'async-patterns'` - Asynchronous code patterns
- `'design-patterns'` - Object-oriented design patterns

**Usage Example:**
```sql
SELECT refactor_pattern(
    'if (user != null) { if (user.isActive) { if (user.hasPermission) { doAction(); } } }',
    'nested-conditionals'
);
```

### 3. `quick_refactor`
**Purpose:** Provides concise, high-impact refactoring suggestions

**Parameters:**
- `input_code` (STRING) - Code to analyze for quick improvements
- `model_name` (STRING, default: 'llama3.1-70b') - AI model for analysis

**Returns:** VARIANT containing top 3-5 actionable refactoring suggestions

**Output Format:** Brief bullet points with specific, implementable recommendations

**Usage Example:**
```sql
SELECT quick_refactor(
    'var data = getData(); if (data) { processData(data); } else { console.log("No data"); }'
);
```

**Best For:**
- Code review sessions
- Quick improvement identification
- Time-constrained refactoring sessions
- Initial code assessment

### 4. `compare_and_refactor`
**Purpose:** Analyzes differences between two code versions and suggests further improvements

**Parameters:**
- `old_code` (STRING) - Original version of the code
- `new_code` (STRING) - Updated version of the code
- `model_name` (STRING, default: 'llama3.1-70b') - AI model for analysis

**Returns:** VARIANT containing comparative analysis and additional recommendations

**Analysis Includes:**
- Improvements made in the new version
- Potential regressions or new issues
- Additional refactoring opportunities
- Quality rating (1-10) with explanation

**Usage Example:**
```sql
SELECT compare_and_refactor(
    'function add(a, b) { return a + b; }',
    'const add = (a, b) => { if(typeof a !== "number" || typeof b !== "number") throw new Error("Invalid input"); return a + b; }'
);
```

### 5. `refactor_sql`
**Purpose:** Specialized refactoring for SQL queries and database operations

**Parameters:**
- `sql_query` (STRING) - SQL query to analyze and optimize
- `model_name` (STRING, default: 'llama3.1-70b') - AI model for analysis

**Returns:** VARIANT containing SQL-specific optimization recommendations

**SQL Optimization Areas:**
- **Query Performance:** Index suggestions, join optimizations, execution plan improvements
- **Readability:** Formatting, naming conventions, logic simplification
- **Best Practices:** SQL standards compliance, anti-pattern avoidance
- **Security:** SQL injection prevention, parameterization
- **Maintainability:** Modularization, documentation, error handling

**Usage Example:**
```sql
SELECT refactor_sql(
    'SELECT * FROM users u, orders o WHERE u.id = o.user_id AND u.created_date > "2023-01-01"'
);
```

**Output Includes:**
- Rewritten optimized query
- Index recommendations
- Security improvements
- Performance explanations

### 6. `refactor_function`
**Purpose:** Specialized refactoring for functions and stored procedures

**Parameters:**
- `function_code` (STRING) - Function or procedure code to analyze
- `function_language` (STRING, default: 'auto') - Programming language
- `model_name` (STRING, default: 'llama3.1-70b') - AI model for analysis

**Returns:** VARIANT containing function-specific refactoring recommendations

**Function Analysis Areas:**
- **Complexity Reduction:** Breaking down complex functions
- **Parameter Optimization:** Input validation and handling
- **Error Handling:** Exception management improvements
- **Performance Optimizations:** Algorithm and data structure improvements
- **Code Organization:** Modularity and single responsibility
- **Testing Considerations:** Testability improvements

**Usage Example:**
```sql
SELECT refactor_function(
    'CREATE FUNCTION calculate_discount(@price DECIMAL, @customer_type VARCHAR(50)) RETURNS DECIMAL AS BEGIN DECLARE @discount DECIMAL = 0; IF @customer_type = "premium" SET @discount = 0.2; ELSE IF @customer_type = "regular" SET @discount = 0.1; RETURN @price * (1 - @discount); END',
    'sql'
);
```

## Usage Guidelines

### Best Practices

1. **Start with Comprehensive Analysis:** Use `refactor_code` for initial assessment
2. **Focus on Specific Issues:** Use `refactor_pattern` for targeted improvements
3. **Quick Wins:** Use `quick_refactor` for immediate improvements
4. **Version Comparison:** Use `compare_and_refactor` during code reviews
5. **Specialized Analysis:** Use `refactor_sql` and `refactor_function` for specific code types

### Model Selection

- **llama3.1-70b (default):** Balanced performance and quality
- **claude-3-5-sonnet:** Enhanced code analysis capabilities
- **mixtral-8x7b:** Fast analysis for simple refactoring tasks

### Integration Workflow

```sql
-- Step 1: Quick assessment
SELECT quick_refactor('your_code_here');

-- Step 2: Comprehensive analysis
SELECT refactor_code('your_code_here', 'python', 'llama3.1-70b', 'all');

-- Step 3: Targeted improvements
SELECT refactor_pattern('your_code_here', 'error-handling');

-- Step 4: Compare improvements
SELECT compare_and_refactor('old_version', 'new_version');
```

### Output Processing

The functions return VARIANT data containing structured recommendations. Parse results to extract:
- Priority levels for suggested changes
- Before/after code examples
- Explanations and rationale
- Security and performance impacts

## Common Use Cases

- **Code Review Automation:** Integrate into CI/CD pipelines
- **Legacy Code Modernization:** Systematic improvement of old codebases
- **Performance Optimization:** Identify bottlenecks and inefficiencies
- **Security Auditing:** Discover potential vulnerabilities
- **Developer Training:** Learn best practices through AI recommendations
- **Technical Debt Reduction:** Prioritize refactoring efforts



