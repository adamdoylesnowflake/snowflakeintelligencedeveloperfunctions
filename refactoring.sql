-- Main function that provides comprehensive refactoring recommendations
CREATE OR REPLACE FUNCTION refactor_code(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama2-70b-chat',
    focus_area STRING DEFAULT 'all'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'You are an expert code reviewer and refactoring specialist. Analyze the following code and provide detailed refactoring recommendations.

Focus Areas (if applicable): ' || focus_area || '

Code to refactor:
' || input_code || '

Please provide refactoring recommendations in the following format:

1. **Code Quality Issues**: List any code smells, anti-patterns, or quality issues
2. **Performance Improvements**: Suggest optimizations for better performance
3. **Readability Enhancements**: Recommend changes to improve code readability
4. **Security Concerns**: Identify any security vulnerabilities or best practices
5. **Maintainability**: Suggest improvements for long-term maintainability
6. **Specific Refactoring Suggestions**: 
   - Before/After code examples
   - Explain the benefits of each refactoring
   - Priority level (High/Medium/Low)
7. **Best Practices**: Recommend adherence to language-specific best practices

Be specific and actionable. Provide code examples where helpful.'
    )
$$;

-- Function that provides refactoring recommendations for specific code patterns
CREATE OR REPLACE FUNCTION refactor_pattern(
    input_code STRING,
    pattern_type STRING,
    model_name STRING DEFAULT 'llama2-70b-chat'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Analyze the following code and provide refactoring recommendations specifically focused on ' || pattern_type || '.

Code:
' || input_code || '

Focus specifically on:
- Identifying ' || pattern_type || ' issues in the code
- Suggesting specific refactorings to address these issues
- Providing before/after code examples
- Explaining the benefits and potential risks of each refactoring

Be concise but thorough.'
    )
$$;

-- Function that provides quick refactoring suggestions (less detailed)
CREATE OR REPLACE FUNCTION quick_refactor(
    input_code STRING,
    model_name STRING DEFAULT 'llama2-70b-chat'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Provide quick, actionable refactoring suggestions for this code. Focus on the top 3-5 most important improvements.

Code:
' || input_code || '

Format: Brief bullet points with specific recommendations.'
    )
$$;

-- Function that compares two code versions and suggests improvements
CREATE OR REPLACE FUNCTION compare_and_refactor(
    old_code STRING,
    new_code STRING,
    model_name STRING DEFAULT 'llama2-70b-chat'
)
RETURNS variant
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Compare the following two code versions and provide refactoring recommendations.

OLD CODE:
' || old_code || '

NEW CODE:
' || new_code || '

Please analyze:
1. What improvements were made in the new version?
2. Are there any regressions or issues introduced?
3. What additional refactorings would further improve the code?
4. Rate the refactoring quality (1-10) and explain why.'
    )
$$;

-- Function for refactoring SQL queries specifically
CREATE OR REPLACE FUNCTION refactor_sql(
    sql_query STRING,
    model_name STRING DEFAULT 'llama2-70b-chat'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'You are a SQL optimization expert. Analyze this SQL query and provide refactoring recommendations.

SQL Query:
' || sql_query || '

Please provide recommendations for:
1. **Query Performance**: Index suggestions, join optimizations, query plan improvements
2. **Readability**: Better formatting, clearer naming, simplified logic
3. **Best Practices**: SQL standards, anti-patterns to avoid
4. **Security**: SQL injection prevention, parameterization
5. **Maintainability**: Modularization, documentation, error handling

Provide a refactored version of the query with explanations.'
    )
$$;

-- Function for refactoring stored procedures/functions
CREATE OR REPLACE FUNCTION refactor_function(
    function_code STRING,
    function_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama2-70b-chat'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model => model_name,
        prompt => 'Analyze this function/procedure code and provide refactoring recommendations.

Function Code:
' || function_code || '

Language: ' || function_language || '

Focus on:
1. Function complexity reduction
2. Parameter optimization
3. Error handling improvements
4. Performance optimizations
5. Code organization and modularity
6. Testing considerations

Provide specific refactored code examples.'
    )
$$;
