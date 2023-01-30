resource "aws_kinesisanalyticsv2_application" "example" {
  name                   = "example-sql-application"
  runtime_environment    = "SQL-1_0"
  service_execution_role = aws_iam_role.example.arn

  application_configuration {
    application_code_configuration {
      code_content {
        text_content = "SELECT 1;\n"
      }

      code_content_type = "PLAINTEXT"
    }

    sql_application_configuration {
      input {
        name_prefix = "PREFIX_1"

        input_parallelism {
          count = 3
        }

        input_schema {
          record_column {
            name     = "COLUMN_1"
            sql_type = "VARCHAR(8)"
            mapping  = "MAPPING-1"
          }

          record_column {
            name     = "COLUMN_2"
            sql_type = "DOUBLE"
          }

          record_encoding = "UTF-8"

          record_format {
            record_format_type = "CSV"

            mapping_parameters {
              csv_mapping_parameters {
                record_column_delimiter = ","
                record_row_delimiter    = "\n"
              }
            }
          }
        }

        kinesis_streams_input {
          resource_arn = aws_kinesis_stream.example.arn
        }
      }

      output {
        name = "OUTPUT_1"

        destination_schema {
          record_format_type = "JSON"
        }

        lambda_output {
          resource_arn = aws_lambda_function.example.arn
        }
      }

      output {
        name = "OUTPUT_2"

        destination_schema {
          record_format_type = "CSV"
        }

        kinesis_firehose_output {
          resource_arn = aws_kinesis_firehose_delivery_stream.example.arn
        }
      }

      reference_data_source {
        table_name = "TABLE-1"

        reference_schema {
          record_column {
            name     = "COLUMN_1"
            sql_type = "INTEGER"
          }

          record_format {
            record_format_type = "JSON"

            mapping_parameters {
              json_mapping_parameters {
                record_row_path = "$"
              }
            }
          }
        }

        s3_reference_data_source {
          bucket_arn = aws_s3_bucket.example.arn
          file_key   = "KEY-1"
        }
      }
    }
  }

  cloudwatch_logging_options {
    log_stream_arn = aws_cloudwatch_log_stream.example.arn
  }
}
