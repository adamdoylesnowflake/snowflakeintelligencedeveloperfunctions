CREATE OR REPLACE FUNCTION document_code_udf(
    input_code STRING,
    code_language STRING DEFAULT 'auto',
    model_name STRING DEFAULT 'llama3.1-70b'
)
RETURNS VARIANT
LANGUAGE SQL
AS
$$
    SELECT AI_COMPLETE(
        model =>model_name,
        prompt =>'Generate comprehensive documentation for the following code. Include description, parameters, return values, usage examples, and any important notes:\n\n' || input_code
    )
$$;
