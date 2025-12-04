-- Main function that generates comprehensive test suite
CREATE OR REPLACE FUNCTION generate_tests(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    test_framework STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'You are an expert test engineer. Generate a comprehensive test suite for the following code.

Code to test:
' || input_code || '

Language: ' || code_language || '
Test Framework: ' || test_framework || '

Generate a complete test suite that includes:

1. **Happy Path Tests**: Test normal, expected behavior with valid inputs
2. **Edge Cases**: Test boundary conditions, extreme values, empty inputs, single-item collections
3. **Null Data Values**: Test null/undefined/None handling for all inputs and intermediate values
4. **Error Handling**: Test expected exceptions, invalid inputs, error conditions, and error messages
5. **Mocking Framework Integration**: Use appropriate mocking frameworks (Jest, unittest.mock, pytest, etc.) to:
   - Mock external dependencies
   - Mock database calls
   - Mock API calls
   - Mock file system operations
   - Mock time/date functions for deterministic testing
6. **Potential Failure Modes**: Test scenarios that could cause failures:
   - Network failures
   - Resource exhaustion (memory, disk space)
   - Timeout conditions
   - Concurrent access issues
   - Invalid data types
   - Overflow/underflow conditions
   - Division by zero
   - Index out of bounds

Requirements:
- Write tests using appropriate testing framework for the language
- Include descriptive test names that explain what is being tested
- Add setup and teardown methods if needed
- Include assertions that verify both positive and negative cases
- Add comments explaining complex test scenarios
- Ensure tests are independent and can run in any order
- Include test data fixtures where appropriate
- Cover all public functions/methods
- Test return values, side effects, and state changes

Provide the complete test code ready to execute.'
    )
$$;

-- Function that generates unit tests specifically
CREATE OR REPLACE FUNCTION generate_unit_tests(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    test_framework STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Generate unit tests for the following code. Focus on isolated testing of individual functions/methods.

Code:
' || input_code || '

Language: ' || code_language || '
Test Framework: ' || test_framework || '

Generate unit tests that:
1. Test each function/method in isolation
2. Use mocks for all dependencies
3. Test all code paths (if/else branches, loops, etc.)
4. Test with valid inputs (happy path)
5. Test with invalid inputs (null, empty, wrong types, out of range)
6. Test edge cases (boundary values, empty collections, single items)
7. Test error conditions and exceptions
8. Verify return values and side effects

Include:
- Setup/teardown methods
- Mock configurations
- Test data fixtures
- Assertions for expected behavior
- Descriptive test names
- Comments for complex test scenarios'
    )
$$;

-- Function that generates integration tests
CREATE OR REPLACE FUNCTION generate_integration_tests(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    test_framework STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Generate integration tests for the following code. Test how components work together.

Code:
' || input_code || '

Language: ' || code_language || '
Test Framework: ' || test_framework || '

Generate integration tests that:
1. Test interactions between multiple functions/modules
2. Test database interactions (with test database or mocks)
3. Test API calls (with mock servers or test endpoints)
4. Test file system operations (with temporary files/directories)
5. Test end-to-end workflows
6. Test error propagation across components
7. Test data flow through the system
8. Test concurrent operations if applicable

Include:
- Test database setup/teardown
- Mock server configurations
- Test data seeding
- Cleanup procedures
- Realistic test scenarios
- Error handling verification'
    )
$$;

-- Function that generates test cases for specific scenarios
CREATE OR REPLACE FUNCTION generate_test_cases(
    input_code STRING,
    test_scenarios STRING,
    code_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Generate specific test cases for the following scenarios.

Code:
' || input_code || '

Scenarios to test:
' || test_scenarios || '

Language: ' || code_language || '

For each scenario, provide:
1. Test case name
2. Input data
3. Expected output/behavior
4. Test implementation code
5. Assertions to verify the scenario

Make the tests comprehensive and cover edge cases within each scenario.'
    )
$$;

-- Function for SQL-specific test generation
CREATE OR REPLACE FUNCTION generate_sql_tests(
    sql_code STRING,
    test_framework STRING DEFAULT 'pytest',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Generate comprehensive tests for this SQL code (stored procedure, function, or query).

SQL Code:
' || sql_code || '

Test Framework: ' || test_framework || '

Generate tests that:
1. Test with valid data (happy path)
2. Test with NULL values in various columns
3. Test with empty result sets
4. Test with edge cases (very large numbers, empty strings, special characters)
5. Test error conditions (invalid inputs, constraint violations)
6. Test transaction rollback scenarios
7. Test performance with large datasets
8. Test concurrent execution
9. Test data integrity and constraints
10. Test with various data types

Use appropriate SQL testing framework and include:
- Test database setup/teardown
- Test data fixtures
- Assertions for expected results
- Error handling verification
- Performance benchmarks if applicable'
    )
$$;

-- Function that generates test data/fixtures
CREATE OR REPLACE FUNCTION generate_test_data(
    input_code STRING,
    data_type STRING DEFAULT 'comprehensive',
    code_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Generate test data and fixtures for testing the following code.

Code:
' || input_code || '

Language: ' || code_language || '
Data Type: ' || data_type || '

Generate test data that includes:
1. Valid test data (typical use cases)
2. Edge case data (boundary values, empty collections, single items)
3. Invalid data (null values, wrong types, out of range values)
4. Stress test data (large datasets, extreme values)
5. Special characters and Unicode data if applicable
6. Realistic sample data that mimics production scenarios

Provide:
- Test data structures (arrays, objects, etc.)
- Test data generators if applicable
- Fixture setup code
- Data factory functions
- Comments explaining the purpose of each test dataset

Format the test data in a way that is easy to use in test code.'
    )
$$;

-- Function that generates mocking configuration
CREATE OR REPLACE FUNCTION generate_mocks(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Analyze the following code and generate mock configurations for all external dependencies.

Code:
' || input_code || '

Language: ' || code_language || '

Identify all external dependencies and generate mocks for:
1. Database calls (queries, connections, transactions)
2. API calls (HTTP requests, REST endpoints, external services)
3. File system operations (file reads, writes, directory operations)
4. Time/date functions (for deterministic testing)
5. Random number generators
6. Environment variables
7. External libraries and services
8. Network operations

For each dependency, provide:
- Mock setup code using appropriate framework
- Mock return values for success cases
- Mock error responses for failure cases
- Mock behavior configuration (how many times called, with what parameters)
- Assertions to verify mock was called correctly

Use appropriate mocking framework for the language (Jest, unittest.mock, pytest fixtures, etc.).'
    )
$$;

-- Function that generates performance/load tests
CREATE OR REPLACE FUNCTION generate_performance_tests(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Generate performance and load tests for the following code.

Code:
' || input_code || '

Language: ' || code_language || '

Generate performance tests that:
1. Measure execution time for various input sizes
2. Test memory usage and identify potential leaks
3. Test with large datasets (stress testing)
4. Test concurrent/parallel execution
5. Benchmark performance metrics
6. Identify bottlenecks
7. Test scalability limits
8. Compare performance of different implementations if applicable

Include:
- Performance test setup
- Benchmarking code
- Load testing scenarios
- Performance assertions (timeouts, memory limits)
- Results reporting
- Performance profiling if applicable

Use appropriate performance testing tools for the language.'
    )
$$;
