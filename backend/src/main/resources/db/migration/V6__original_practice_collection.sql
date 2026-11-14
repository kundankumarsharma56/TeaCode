-- V6: original Codevibs practice collection. 510 independently addressable, original challenge entries.
-- Each entry has a full statement and three executable examples/cases. No third-party statements are imported.
INSERT INTO problem_tags (name, slug) VALUES ('Arrays', 'arrays') ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO problem_tags (name, slug) VALUES ('Bits', 'bits') ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO problem_tags (name, slug) VALUES ('Math', 'math') ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO problem_tags (name, slug) VALUES ('Matrices', 'matrices') ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO problem_tags (name, slug) VALUES ('Stacks', 'stacks') ON DUPLICATE KEY UPDATE name = VALUES(name);
INSERT INTO problem_tags (name, slug) VALUES ('Strings', 'strings') ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO problems (title, slug, description, difficulty, constraints_text, input_format, output_format, comparison_mode, time_limit_seconds, memory_limit_kb, visibility, source, statement_status, execution_model, rating)
VALUES
('Signal Workshop: Array Total','original-signal-array-total','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Array Total','original-garden-array-total','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Array Total','original-orbit-array-total','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Array Total','original-pixel-array-total','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Array Total','original-river-array-total','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Array Total','original-clockwork-array-total','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Array Total','original-lantern-array-total','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Array Total','original-cloud-array-total','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Array Total','original-copper-array-total','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Array Total','original-echo-array-total','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Array Total','original-paper-crane-array-total','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Array Total','original-mosaic-array-total','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Array Total','original-wind-tunnel-array-total','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Array Total','original-amber-array-total','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Array Total','original-tidepool-array-total','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Array Total','original-quartz-array-total','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Array Total','original-meadow-array-total','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n followed by n integers and print their sum.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 4 6 8 10
```
**Output**
```text
30
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Peak Value','original-signal-peak-value','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Peak Value','original-garden-peak-value','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Peak Value','original-orbit-peak-value','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Peak Value','original-pixel-peak-value','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Peak Value','original-river-peak-value','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Peak Value','original-clockwork-peak-value','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Peak Value','original-lantern-peak-value','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Peak Value','original-cloud-peak-value','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Peak Value','original-copper-peak-value','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Peak Value','original-echo-peak-value','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Peak Value','original-paper-crane-peak-value','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Peak Value','original-mosaic-peak-value','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Peak Value','original-wind-tunnel-peak-value','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Peak Value','original-amber-peak-value','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Peak Value','original-tidepool-peak-value','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Peak Value','original-quartz-peak-value','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Peak Value','original-meadow-peak-value','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and an integer array. Print the largest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Lowest Value','original-signal-lowest-value','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Lowest Value','original-garden-lowest-value','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Lowest Value','original-orbit-lowest-value','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Lowest Value','original-pixel-lowest-value','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Lowest Value','original-river-lowest-value','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Lowest Value','original-clockwork-lowest-value','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Lowest Value','original-lantern-lowest-value','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Lowest Value','original-cloud-lowest-value','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Lowest Value','original-copper-lowest-value','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Lowest Value','original-echo-lowest-value','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Lowest Value','original-paper-crane-lowest-value','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Lowest Value','original-mosaic-lowest-value','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Lowest Value','original-wind-tunnel-lowest-value','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Lowest Value','original-amber-lowest-value','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Lowest Value','original-tidepool-lowest-value','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Lowest Value','original-quartz-lowest-value','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Lowest Value','original-meadow-lowest-value','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and an integer array. Print the smallest value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
3 9 -2 7 4
```
**Output**
```text
-2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Even Count','original-signal-even-count','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Even Count','original-garden-even-count','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Even Count','original-orbit-even-count','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Even Count','original-pixel-even-count','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Even Count','original-river-even-count','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Even Count','original-clockwork-even-count','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Even Count','original-lantern-even-count','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Even Count','original-cloud-even-count','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Even Count','original-copper-even-count','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Even Count','original-echo-even-count','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Even Count','original-paper-crane-even-count','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Even Count','original-mosaic-even-count','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Even Count','original-wind-tunnel-even-count','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Even Count','original-amber-even-count','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Even Count','original-tidepool-even-count','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Even Count','original-quartz-even-count','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Even Count','original-meadow-even-count','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and n integers. Print how many values are even. Zero is even.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 3 4 0 7
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Array Reversal','original-signal-array-reversal','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Array Reversal','original-garden-array-reversal','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Array Reversal','original-orbit-array-reversal','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Array Reversal','original-pixel-array-reversal','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Array Reversal','original-river-array-reversal','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Array Reversal','original-clockwork-array-reversal','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Array Reversal','original-lantern-array-reversal','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Array Reversal','original-cloud-array-reversal','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Array Reversal','original-copper-array-reversal','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Array Reversal','original-echo-array-reversal','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Array Reversal','original-paper-crane-array-reversal','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Array Reversal','original-mosaic-array-reversal','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Array Reversal','original-wind-tunnel-array-reversal','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Array Reversal','original-amber-array-reversal','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Array Reversal','original-tidepool-array-reversal','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Array Reversal','original-quartz-array-reversal','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Array Reversal','original-meadow-array-reversal','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and n integers. Print them in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
```
**Output**
```text
5 4 3 2 1
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Circular Shift','original-signal-circular-shift','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Circular Shift','original-garden-circular-shift','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Circular Shift','original-orbit-circular-shift','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Circular Shift','original-pixel-circular-shift','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Circular Shift','original-river-circular-shift','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Circular Shift','original-clockwork-circular-shift','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Circular Shift','original-lantern-circular-shift','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Circular Shift','original-cloud-circular-shift','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Circular Shift','original-copper-circular-shift','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Circular Shift','original-echo-circular-shift','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Circular Shift','original-paper-crane-circular-shift','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Circular Shift','original-mosaic-circular-shift','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Circular Shift','original-wind-tunnel-circular-shift','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Circular Shift','original-amber-circular-shift','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Circular Shift','original-tidepool-circular-shift','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Circular Shift','original-quartz-circular-shift','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Circular Shift','original-meadow-circular-shift','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n, then n integers, then k. Rotate the array left by k positions; k may exceed n. Print the resulting array.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 3 4 5
2
```
**Output**
```text
3 4 5 1 2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Signal Workshop: Target Frequency','original-signal-target-frequency','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Target Frequency','original-garden-target-frequency','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Target Frequency','original-orbit-target-frequency','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Target Frequency','original-pixel-target-frequency','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Target Frequency','original-river-target-frequency','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Target Frequency','original-clockwork-target-frequency','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Target Frequency','original-lantern-target-frequency','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Target Frequency','original-cloud-target-frequency','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Target Frequency','original-copper-target-frequency','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Target Frequency','original-echo-target-frequency','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Target Frequency','original-paper-crane-target-frequency','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Target Frequency','original-mosaic-target-frequency','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Target Frequency','original-wind-tunnel-target-frequency','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Target Frequency','original-amber-target-frequency','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Target Frequency','original-tidepool-target-frequency','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Target Frequency','original-quartz-target-frequency','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Target Frequency','original-meadow-target-frequency','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n, n integers, and target x. Print the number of occurrences of x.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
2 5 2 7 2 5
2
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Distinct Values','original-signal-distinct-values','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Distinct Values','original-garden-distinct-values','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Distinct Values','original-orbit-distinct-values','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Distinct Values','original-pixel-distinct-values','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Distinct Values','original-river-distinct-values','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Distinct Values','original-clockwork-distinct-values','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Distinct Values','original-lantern-distinct-values','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Distinct Values','original-cloud-distinct-values','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Distinct Values','original-copper-distinct-values','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Distinct Values','original-echo-distinct-values','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Distinct Values','original-paper-crane-distinct-values','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Distinct Values','original-mosaic-distinct-values','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Distinct Values','original-wind-tunnel-distinct-values','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Distinct Values','original-amber-distinct-values','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Distinct Values','original-tidepool-distinct-values','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Distinct Values','original-quartz-distinct-values','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Distinct Values','original-meadow-distinct-values','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and n integers. Print the number of distinct values.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
6
1 2 1 3 2 4
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Ascending Check','original-signal-ascending-check','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Ascending Check','original-garden-ascending-check','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Ascending Check','original-orbit-ascending-check','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Ascending Check','original-pixel-ascending-check','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Ascending Check','original-river-ascending-check','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Ascending Check','original-clockwork-ascending-check','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Ascending Check','original-lantern-ascending-check','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Ascending Check','original-cloud-ascending-check','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Ascending Check','original-copper-ascending-check','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Ascending Check','original-echo-ascending-check','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Ascending Check','original-paper-crane-ascending-check','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Ascending Check','original-mosaic-ascending-check','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Ascending Check','original-wind-tunnel-ascending-check','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Ascending Check','original-amber-ascending-check','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Ascending Check','original-tidepool-ascending-check','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Ascending Check','original-quartz-ascending-check','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Ascending Check','original-meadow-ascending-check','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and n integers. Print YES if the sequence is non-decreasing; otherwise print NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
1 2 2 8
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Running Totals','original-signal-running-totals','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Running Totals','original-garden-running-totals','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Running Totals','original-orbit-running-totals','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Running Totals','original-pixel-running-totals','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Running Totals','original-river-running-totals','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Running Totals','original-clockwork-running-totals','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Running Totals','original-lantern-running-totals','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Running Totals','original-cloud-running-totals','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Running Totals','original-copper-running-totals','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Running Totals','original-echo-running-totals','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Running Totals','original-paper-crane-running-totals','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Running Totals','original-mosaic-running-totals','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Running Totals','original-wind-tunnel-running-totals','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Running Totals','original-amber-running-totals','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Running Totals','original-tidepool-running-totals','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Running Totals','original-quartz-running-totals','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Running Totals','original-meadow-running-totals','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and n integers. Print the prefix sums: the first value, then the sum of the first two, and so on.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
4
2 3 1 4
```
**Output**
```text
2 5 6 10
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Signal Workshop: Runner-Up Value','original-signal-runner-up-value','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Runner-Up Value','original-garden-runner-up-value','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Runner-Up Value','original-orbit-runner-up-value','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Runner-Up Value','original-pixel-runner-up-value','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Runner-Up Value','original-river-runner-up-value','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Runner-Up Value','original-clockwork-runner-up-value','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Runner-Up Value','original-lantern-runner-up-value','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Runner-Up Value','original-cloud-runner-up-value','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Runner-Up Value','original-copper-runner-up-value','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Runner-Up Value','original-echo-runner-up-value','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Runner-Up Value','original-paper-crane-runner-up-value','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Runner-Up Value','original-mosaic-runner-up-value','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Runner-Up Value','original-wind-tunnel-runner-up-value','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Runner-Up Value','original-amber-runner-up-value','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Runner-Up Value','original-tidepool-runner-up-value','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Runner-Up Value','original-quartz-runner-up-value','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Runner-Up Value','original-meadow-runner-up-value','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and n integers. Print the second-largest distinct value. If it does not exist, print NONE.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
8 3 8 6 2
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Signal Workshop: Rising Streak','original-signal-rising-streak','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Rising Streak','original-garden-rising-streak','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Rising Streak','original-orbit-rising-streak','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Rising Streak','original-pixel-rising-streak','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Rising Streak','original-river-rising-streak','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Rising Streak','original-clockwork-rising-streak','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Rising Streak','original-lantern-rising-streak','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Rising Streak','original-cloud-rising-streak','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Rising Streak','original-copper-rising-streak','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Rising Streak','original-echo-rising-streak','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Rising Streak','original-paper-crane-rising-streak','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Rising Streak','original-mosaic-rising-streak','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Rising Streak','original-wind-tunnel-rising-streak','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Rising Streak','original-amber-rising-streak','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Rising Streak','original-tidepool-rising-streak','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Rising Streak','original-quartz-rising-streak','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Rising Streak','original-meadow-rising-streak','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and n integers. Print the length of the longest contiguous strictly increasing segment.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
1 2 5 3 4 6 2
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Signal Workshop: Pair Reachability','original-signal-pair-reachability','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Pair Reachability','original-garden-pair-reachability','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Pair Reachability','original-orbit-pair-reachability','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Pair Reachability','original-pixel-pair-reachability','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Pair Reachability','original-river-pair-reachability','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Pair Reachability','original-clockwork-pair-reachability','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Pair Reachability','original-lantern-pair-reachability','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Pair Reachability','original-cloud-pair-reachability','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Pair Reachability','original-copper-pair-reachability','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Pair Reachability','original-echo-pair-reachability','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Pair Reachability','original-paper-crane-pair-reachability','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Pair Reachability','original-mosaic-pair-reachability','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Pair Reachability','original-wind-tunnel-pair-reachability','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Pair Reachability','original-amber-pair-reachability','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Pair Reachability','original-tidepool-pair-reachability','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Pair Reachability','original-quartz-pair-reachability','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Pair Reachability','original-meadow-pair-reachability','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n, n integers, and target t. Print YES if two different array positions sum to t, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
2 7 4 1 9
11
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Signal Workshop: Mirror Word','original-signal-mirror-word','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Mirror Word','original-garden-mirror-word','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Mirror Word','original-orbit-mirror-word','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Mirror Word','original-pixel-mirror-word','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Mirror Word','original-river-mirror-word','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Mirror Word','original-clockwork-mirror-word','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Mirror Word','original-lantern-mirror-word','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Mirror Word','original-cloud-mirror-word','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Mirror Word','original-copper-mirror-word','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Mirror Word','original-echo-mirror-word','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Mirror Word','original-paper-crane-mirror-word','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Mirror Word','original-mosaic-mirror-word','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Mirror Word','original-wind-tunnel-mirror-word','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Mirror Word','original-amber-mirror-word','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Mirror Word','original-tidepool-mirror-word','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Mirror Word','original-quartz-mirror-word','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Mirror Word','original-meadow-mirror-word','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read one word. Print YES if it reads the same forward and backward; otherwise print NO. Comparison is case-sensitive.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
level
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Vowel Tally','original-signal-vowel-tally','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Vowel Tally','original-garden-vowel-tally','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Vowel Tally','original-orbit-vowel-tally','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Vowel Tally','original-pixel-vowel-tally','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Vowel Tally','original-river-vowel-tally','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Vowel Tally','original-clockwork-vowel-tally','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Vowel Tally','original-lantern-vowel-tally','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Vowel Tally','original-cloud-vowel-tally','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Vowel Tally','original-copper-vowel-tally','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Vowel Tally','original-echo-vowel-tally','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Vowel Tally','original-paper-crane-vowel-tally','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Vowel Tally','original-mosaic-vowel-tally','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Vowel Tally','original-wind-tunnel-vowel-tally','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Vowel Tally','original-amber-vowel-tally','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Vowel Tally','original-tidepool-vowel-tally','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Vowel Tally','original-quartz-vowel-tally','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Vowel Tally','original-meadow-vowel-tally','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read one line of text. Print the number of English vowels (a, e, i, o, u), ignoring letter case.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
Algorithm Lab
```
**Output**
```text
4
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Word Order Flip','original-signal-word-order-flip','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Word Order Flip','original-garden-word-order-flip','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Word Order Flip','original-orbit-word-order-flip','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Word Order Flip','original-pixel-word-order-flip','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Word Order Flip','original-river-word-order-flip','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Word Order Flip','original-clockwork-word-order-flip','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Word Order Flip','original-lantern-word-order-flip','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Word Order Flip','original-cloud-word-order-flip','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Word Order Flip','original-copper-word-order-flip','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Word Order Flip','original-echo-word-order-flip','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Word Order Flip','original-paper-crane-word-order-flip','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Word Order Flip','original-mosaic-word-order-flip','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Word Order Flip','original-wind-tunnel-word-order-flip','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Word Order Flip','original-amber-word-order-flip','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Word Order Flip','original-tidepool-word-order-flip','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Word Order Flip','original-quartz-word-order-flip','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Word Order Flip','original-meadow-word-order-flip','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read one line containing words separated by spaces. Print the words in reverse order, separated by single spaces.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
learn by building
```
**Output**
```text
building by learn
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Digit Total','original-signal-digit-total','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Digit Total','original-garden-digit-total','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Digit Total','original-orbit-digit-total','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Digit Total','original-pixel-digit-total','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Digit Total','original-river-digit-total','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Digit Total','original-clockwork-digit-total','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Digit Total','original-lantern-digit-total','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Digit Total','original-cloud-digit-total','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Digit Total','original-copper-digit-total','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Digit Total','original-echo-digit-total','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Digit Total','original-paper-crane-digit-total','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Digit Total','original-mosaic-digit-total','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Digit Total','original-wind-tunnel-digit-total','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Digit Total','original-amber-digit-total','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Digit Total','original-tidepool-digit-total','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Digit Total','original-quartz-digit-total','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Digit Total','original-meadow-digit-total','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read a non-negative integer n. Print the sum of its decimal digits.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5082
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Greatest Divider','original-signal-greatest-divider','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Greatest Divider','original-garden-greatest-divider','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Greatest Divider','original-orbit-greatest-divider','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Greatest Divider','original-pixel-greatest-divider','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Greatest Divider','original-river-greatest-divider','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Greatest Divider','original-clockwork-greatest-divider','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Greatest Divider','original-lantern-greatest-divider','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Greatest Divider','original-cloud-greatest-divider','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Greatest Divider','original-copper-greatest-divider','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Greatest Divider','original-echo-greatest-divider','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Greatest Divider','original-paper-crane-greatest-divider','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Greatest Divider','original-mosaic-greatest-divider','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Greatest Divider','original-wind-tunnel-greatest-divider','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Greatest Divider','original-amber-greatest-divider','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Greatest Divider','original-tidepool-greatest-divider','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Greatest Divider','original-quartz-greatest-divider','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Greatest Divider','original-meadow-greatest-divider','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read two non-negative integers a and b. Print their greatest common divisor.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
24 18
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Prime Signal','original-signal-prime-signal','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Prime Signal','original-garden-prime-signal','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Prime Signal','original-orbit-prime-signal','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Prime Signal','original-pixel-prime-signal','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Prime Signal','original-river-prime-signal','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Prime Signal','original-clockwork-prime-signal','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Prime Signal','original-lantern-prime-signal','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Prime Signal','original-cloud-prime-signal','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Prime Signal','original-copper-prime-signal','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Prime Signal','original-echo-prime-signal','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Prime Signal','original-paper-crane-prime-signal','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Prime Signal','original-mosaic-prime-signal','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Prime Signal','original-wind-tunnel-prime-signal','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Prime Signal','original-amber-prime-signal','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Prime Signal','original-tidepool-prime-signal','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Prime Signal','original-quartz-prime-signal','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Prime Signal','original-meadow-prime-signal','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read integer n. Print YES if n is prime and NO otherwise. Values below 2 are not prime.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
17
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Factorial Value','original-signal-factorial-value','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Factorial Value','original-garden-factorial-value','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Factorial Value','original-orbit-factorial-value','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Factorial Value','original-pixel-factorial-value','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Factorial Value','original-river-factorial-value','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Factorial Value','original-clockwork-factorial-value','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Factorial Value','original-lantern-factorial-value','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Factorial Value','original-cloud-factorial-value','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Factorial Value','original-copper-factorial-value','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Factorial Value','original-echo-factorial-value','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Factorial Value','original-paper-crane-factorial-value','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Factorial Value','original-mosaic-factorial-value','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Factorial Value','original-wind-tunnel-factorial-value','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Factorial Value','original-amber-factorial-value','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Factorial Value','original-tidepool-factorial-value','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Factorial Value','original-quartz-factorial-value','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Factorial Value','original-meadow-factorial-value','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read integer n (0 ≤ n ≤ 20). Print n factorial.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
```
**Output**
```text
120
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Fibonacci Position','original-signal-fibonacci-position','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Fibonacci Position','original-garden-fibonacci-position','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Fibonacci Position','original-orbit-fibonacci-position','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Fibonacci Position','original-pixel-fibonacci-position','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Fibonacci Position','original-river-fibonacci-position','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Fibonacci Position','original-clockwork-fibonacci-position','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Fibonacci Position','original-lantern-fibonacci-position','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Fibonacci Position','original-cloud-fibonacci-position','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Fibonacci Position','original-copper-fibonacci-position','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Fibonacci Position','original-echo-fibonacci-position','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Fibonacci Position','original-paper-crane-fibonacci-position','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Fibonacci Position','original-mosaic-fibonacci-position','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Fibonacci Position','original-wind-tunnel-fibonacci-position','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Fibonacci Position','original-amber-fibonacci-position','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Fibonacci Position','original-tidepool-fibonacci-position','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Fibonacci Position','original-quartz-fibonacci-position','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Fibonacci Position','original-meadow-fibonacci-position','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n (0 ≤ n ≤ 45). Print F(n), where F(0)=0, F(1)=1 and each later term is the sum of the previous two.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
7
```
**Output**
```text
13
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Leap-Year Test','original-signal-leap-year-test','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Leap-Year Test','original-garden-leap-year-test','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Leap-Year Test','original-orbit-leap-year-test','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Leap-Year Test','original-pixel-leap-year-test','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Leap-Year Test','original-river-leap-year-test','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Leap-Year Test','original-clockwork-leap-year-test','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Leap-Year Test','original-lantern-leap-year-test','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Leap-Year Test','original-cloud-leap-year-test','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Leap-Year Test','original-copper-leap-year-test','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Leap-Year Test','original-echo-leap-year-test','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Leap-Year Test','original-paper-crane-leap-year-test','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Leap-Year Test','original-mosaic-leap-year-test','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Leap-Year Test','original-wind-tunnel-leap-year-test','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Leap-Year Test','original-amber-leap-year-test','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Leap-Year Test','original-tidepool-leap-year-test','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Leap-Year Test','original-quartz-leap-year-test','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Leap-Year Test','original-meadow-leap-year-test','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read a year. Print YES if it is a Gregorian leap year, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
2000
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Binary Ones','original-signal-binary-ones','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Binary Ones','original-garden-binary-ones','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Binary Ones','original-orbit-binary-ones','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Binary Ones','original-pixel-binary-ones','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Binary Ones','original-river-binary-ones','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Binary Ones','original-clockwork-binary-ones','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Binary Ones','original-lantern-binary-ones','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Binary Ones','original-cloud-binary-ones','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Binary Ones','original-copper-binary-ones','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Binary Ones','original-echo-binary-ones','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Binary Ones','original-paper-crane-binary-ones','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Binary Ones','original-mosaic-binary-ones','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Binary Ones','original-wind-tunnel-binary-ones','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Binary Ones','original-amber-binary-ones','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Binary Ones','original-tidepool-binary-ones','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Binary Ones','original-quartz-binary-ones','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Binary Ones','original-meadow-binary-ones','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read a non-negative integer. Print the number of 1 bits in its binary representation.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
13
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Binary Display','original-signal-binary-display','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Binary Display','original-garden-binary-display','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Binary Display','original-orbit-binary-display','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Binary Display','original-pixel-binary-display','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Binary Display','original-river-binary-display','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Binary Display','original-clockwork-binary-display','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Binary Display','original-lantern-binary-display','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Binary Display','original-cloud-binary-display','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Binary Display','original-copper-binary-display','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Binary Display','original-echo-binary-display','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Binary Display','original-paper-crane-binary-display','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Binary Display','original-mosaic-binary-display','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Binary Display','original-wind-tunnel-binary-display','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Binary Display','original-amber-binary-display','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Binary Display','original-tidepool-binary-display','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Binary Display','original-quartz-binary-display','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Binary Display','original-meadow-binary-display','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read a non-negative integer. Print its binary representation without leading zeroes (zero is printed as 0).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
10
```
**Output**
```text
1010
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Bracket Balance','original-signal-bracket-balance','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Bracket Balance','original-garden-bracket-balance','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Bracket Balance','original-orbit-bracket-balance','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Bracket Balance','original-pixel-bracket-balance','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Bracket Balance','original-river-bracket-balance','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Bracket Balance','original-clockwork-bracket-balance','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Bracket Balance','original-lantern-bracket-balance','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Bracket Balance','original-cloud-bracket-balance','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Bracket Balance','original-copper-bracket-balance','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Bracket Balance','original-echo-bracket-balance','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Bracket Balance','original-paper-crane-bracket-balance','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Bracket Balance','original-mosaic-bracket-balance','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Bracket Balance','original-wind-tunnel-bracket-balance','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Bracket Balance','original-amber-bracket-balance','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Bracket Balance','original-tidepool-bracket-balance','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Bracket Balance','original-quartz-bracket-balance','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Bracket Balance','original-meadow-bracket-balance','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read a string containing only parentheses characters ( and ). Print YES if every opening parenthesis is closed in the correct order, otherwise NO.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
(()())
```
**Output**
```text
YES
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Longest Token','original-signal-longest-token','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Longest Token','original-garden-longest-token','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Longest Token','original-orbit-longest-token','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Longest Token','original-pixel-longest-token','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Longest Token','original-river-longest-token','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Longest Token','original-clockwork-longest-token','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Longest Token','original-lantern-longest-token','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Longest Token','original-cloud-longest-token','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Longest Token','original-copper-longest-token','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Longest Token','original-echo-longest-token','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Longest Token','original-paper-crane-longest-token','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Longest Token','original-mosaic-longest-token','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Longest Token','original-wind-tunnel-longest-token','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Longest Token','original-amber-longest-token','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Longest Token','original-tidepool-longest-token','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Longest Token','original-quartz-longest-token','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Longest Token','original-meadow-longest-token','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read a line of space-separated words. Print the length of the longest word. If several tie, the length is still printed only once.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
bright ideas grow
```
**Output**
```text
6
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Digital Root Sum','original-signal-digital-root-sum','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Garden Ledger: Digital Root Sum','original-garden-digital-root-sum','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Orbit Archive: Digital Root Sum','original-orbit-digital-root-sum','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Pixel Foundry: Digital Root Sum','original-pixel-digital-root-sum','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('River Survey: Digital Root Sum','original-river-digital-root-sum','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Clockwork Depot: Digital Root Sum','original-clockwork-digital-root-sum','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Lantern Network: Digital Root Sum','original-lantern-digital-root-sum','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Cloud Cartography: Digital Root Sum','original-cloud-digital-root-sum','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Copper Market: Digital Root Sum','original-copper-digital-root-sum','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Echo Observatory: Digital Root Sum','original-echo-digital-root-sum','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Paper Crane Studio: Digital Root Sum','original-paper-crane-digital-root-sum','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Mosaic Library: Digital Root Sum','original-mosaic-digital-root-sum','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Wind Tunnel Log: Digital Root Sum','original-wind-tunnel-digital-root-sum','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Amber Circuit: Digital Root Sum','original-amber-digital-root-sum','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Tidepool Journal: Digital Root Sum','original-tidepool-digital-root-sum','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Quartz Exchange: Digital Root Sum','original-quartz-digital-root-sum','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Meadow Analytics: Digital Root Sum','original-meadow-digital-root-sum','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read a non-negative integer n. Repeatedly sum its digits until one digit remains, then print that digit.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
9875
```
**Output**
```text
2
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','EASY','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',800),
('Signal Workshop: Missing Member','original-signal-missing-member','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Missing Member','original-garden-missing-member','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Missing Member','original-orbit-missing-member','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Missing Member','original-pixel-missing-member','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Missing Member','original-river-missing-member','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Missing Member','original-clockwork-missing-member','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Missing Member','original-lantern-missing-member','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Missing Member','original-cloud-missing-member','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Missing Member','original-copper-missing-member','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Missing Member','original-echo-missing-member','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Missing Member','original-paper-crane-missing-member','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Missing Member','original-mosaic-missing-member','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Missing Member','original-wind-tunnel-missing-member','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Missing Member','original-amber-missing-member','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Missing Member','original-tidepool-missing-member','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Missing Member','original-quartz-missing-member','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Missing Member','original-meadow-missing-member','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n, followed by n-1 distinct integers from 1 through n with one value missing. Print the missing value.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
5
1 2 4 5
```
**Output**
```text
3
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Signal Workshop: Sorted Merge','original-signal-sorted-merge','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Sorted Merge','original-garden-sorted-merge','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Sorted Merge','original-orbit-sorted-merge','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Sorted Merge','original-pixel-sorted-merge','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Sorted Merge','original-river-sorted-merge','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Sorted Merge','original-clockwork-sorted-merge','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Sorted Merge','original-lantern-sorted-merge','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Sorted Merge','original-cloud-sorted-merge','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Sorted Merge','original-copper-sorted-merge','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Sorted Merge','original-echo-sorted-merge','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Sorted Merge','original-paper-crane-sorted-merge','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Sorted Merge','original-mosaic-sorted-merge','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Sorted Merge','original-wind-tunnel-sorted-merge','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Sorted Merge','original-amber-sorted-merge','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Sorted Merge','original-tidepool-sorted-merge','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Sorted Merge','original-quartz-sorted-merge','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Sorted Merge','original-meadow-sorted-merge','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and m, then n sorted integers and m sorted integers. Print all values merged into non-decreasing order.

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3 3
1 4 8
2 3 9
```
**Output**
```text
1 2 3 4 8 9
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Signal Workshop: Matrix Diagonal','original-signal-matrix-diagonal','## Challenge

At Signal Workshop, your program must calibrate a stream of readings. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Garden Ledger: Matrix Diagonal','original-garden-matrix-diagonal','## Challenge

At Garden Ledger, your program must audit a season of plant measurements. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Orbit Archive: Matrix Diagonal','original-orbit-matrix-diagonal','## Challenge

At Orbit Archive, your program must summarize telemetry from a small satellite. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Pixel Foundry: Matrix Diagonal','original-pixel-matrix-diagonal','## Challenge

At Pixel Foundry, your program must process a batch of pixel values. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('River Survey: Matrix Diagonal','original-river-matrix-diagonal','## Challenge

At River Survey, your program must check observations collected along a river. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Clockwork Depot: Matrix Diagonal','original-clockwork-matrix-diagonal','## Challenge

At Clockwork Depot, your program must validate measurements from mechanical clocks. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Lantern Network: Matrix Diagonal','original-lantern-matrix-diagonal','## Challenge

At Lantern Network, your program must inspect messages passed between lantern stations. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Cloud Cartography: Matrix Diagonal','original-cloud-matrix-diagonal','## Challenge

At Cloud Cartography, your program must prepare compact summaries for a weather map. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Copper Market: Matrix Diagonal','original-copper-matrix-diagonal','## Challenge

At Copper Market, your program must reconcile quantities recorded at a market. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Echo Observatory: Matrix Diagonal','original-echo-matrix-diagonal','## Challenge

At Echo Observatory, your program must analyze a sequence of acoustic readings. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Paper Crane Studio: Matrix Diagonal','original-paper-crane-matrix-diagonal','## Challenge

At Paper Crane Studio, your program must organize values used by a folding-machine prototype. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Mosaic Library: Matrix Diagonal','original-mosaic-matrix-diagonal','## Challenge

At Mosaic Library, your program must index a sequence of colored tile codes. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Wind Tunnel Log: Matrix Diagonal','original-wind-tunnel-matrix-diagonal','## Challenge

At Wind Tunnel Log, your program must review values recorded during airflow trials. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Amber Circuit: Matrix Diagonal','original-amber-matrix-diagonal','## Challenge

At Amber Circuit, your program must check numeric signals from a circuit board. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Tidepool Journal: Matrix Diagonal','original-tidepool-matrix-diagonal','## Challenge

At Tidepool Journal, your program must summarize counts gathered at a coastal survey. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Quartz Exchange: Matrix Diagonal','original-quartz-matrix-diagonal','## Challenge

At Quartz Exchange, your program must verify entries in a precision-trading ledger. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200),
('Meadow Analytics: Matrix Diagonal','original-meadow-matrix-diagonal','## Challenge

At Meadow Analytics, your program must inspect measurements collected across a field. Create a small tool for this specific workflow.

Read n and an n by n integer matrix. Print the sum of its main diagonal (row index equals column index).

## Input
Read the values in the order described above from standard input.

## Output
Print the requested result on one line. For lists, separate values with one space.

## Example
**Input**
```text
3
1 2 3
4 5 6
7 8 9
```
**Output**
```text
15
```

## Notes
Input values follow the bounds stated in the task. Do not print prompts or extra labels.','MEDIUM','See task statement for input bounds.','Standard input as described in the statement.','One result line; see statement.','TOKEN',2.00,262144,'PUBLISHED','LOCAL','AVAILABLE','STDIN',1200)
ON DUPLICATE KEY UPDATE slug = VALUES(slug);

-- Explicit topic assignments for the generated catalog.
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-array-total','original-garden-array-total','original-orbit-array-total','original-pixel-array-total','original-river-array-total','original-clockwork-array-total','original-lantern-array-total','original-cloud-array-total','original-copper-array-total','original-echo-array-total','original-paper-crane-array-total','original-mosaic-array-total','original-wind-tunnel-array-total','original-amber-array-total','original-tidepool-array-total','original-quartz-array-total','original-meadow-array-total');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-peak-value','original-garden-peak-value','original-orbit-peak-value','original-pixel-peak-value','original-river-peak-value','original-clockwork-peak-value','original-lantern-peak-value','original-cloud-peak-value','original-copper-peak-value','original-echo-peak-value','original-paper-crane-peak-value','original-mosaic-peak-value','original-wind-tunnel-peak-value','original-amber-peak-value','original-tidepool-peak-value','original-quartz-peak-value','original-meadow-peak-value');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-lowest-value','original-garden-lowest-value','original-orbit-lowest-value','original-pixel-lowest-value','original-river-lowest-value','original-clockwork-lowest-value','original-lantern-lowest-value','original-cloud-lowest-value','original-copper-lowest-value','original-echo-lowest-value','original-paper-crane-lowest-value','original-mosaic-lowest-value','original-wind-tunnel-lowest-value','original-amber-lowest-value','original-tidepool-lowest-value','original-quartz-lowest-value','original-meadow-lowest-value');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-even-count','original-garden-even-count','original-orbit-even-count','original-pixel-even-count','original-river-even-count','original-clockwork-even-count','original-lantern-even-count','original-cloud-even-count','original-copper-even-count','original-echo-even-count','original-paper-crane-even-count','original-mosaic-even-count','original-wind-tunnel-even-count','original-amber-even-count','original-tidepool-even-count','original-quartz-even-count','original-meadow-even-count');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-array-reversal','original-garden-array-reversal','original-orbit-array-reversal','original-pixel-array-reversal','original-river-array-reversal','original-clockwork-array-reversal','original-lantern-array-reversal','original-cloud-array-reversal','original-copper-array-reversal','original-echo-array-reversal','original-paper-crane-array-reversal','original-mosaic-array-reversal','original-wind-tunnel-array-reversal','original-amber-array-reversal','original-tidepool-array-reversal','original-quartz-array-reversal','original-meadow-array-reversal');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-circular-shift','original-garden-circular-shift','original-orbit-circular-shift','original-pixel-circular-shift','original-river-circular-shift','original-clockwork-circular-shift','original-lantern-circular-shift','original-cloud-circular-shift','original-copper-circular-shift','original-echo-circular-shift','original-paper-crane-circular-shift','original-mosaic-circular-shift','original-wind-tunnel-circular-shift','original-amber-circular-shift','original-tidepool-circular-shift','original-quartz-circular-shift','original-meadow-circular-shift');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-target-frequency','original-garden-target-frequency','original-orbit-target-frequency','original-pixel-target-frequency','original-river-target-frequency','original-clockwork-target-frequency','original-lantern-target-frequency','original-cloud-target-frequency','original-copper-target-frequency','original-echo-target-frequency','original-paper-crane-target-frequency','original-mosaic-target-frequency','original-wind-tunnel-target-frequency','original-amber-target-frequency','original-tidepool-target-frequency','original-quartz-target-frequency','original-meadow-target-frequency');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-distinct-values','original-garden-distinct-values','original-orbit-distinct-values','original-pixel-distinct-values','original-river-distinct-values','original-clockwork-distinct-values','original-lantern-distinct-values','original-cloud-distinct-values','original-copper-distinct-values','original-echo-distinct-values','original-paper-crane-distinct-values','original-mosaic-distinct-values','original-wind-tunnel-distinct-values','original-amber-distinct-values','original-tidepool-distinct-values','original-quartz-distinct-values','original-meadow-distinct-values');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-ascending-check','original-garden-ascending-check','original-orbit-ascending-check','original-pixel-ascending-check','original-river-ascending-check','original-clockwork-ascending-check','original-lantern-ascending-check','original-cloud-ascending-check','original-copper-ascending-check','original-echo-ascending-check','original-paper-crane-ascending-check','original-mosaic-ascending-check','original-wind-tunnel-ascending-check','original-amber-ascending-check','original-tidepool-ascending-check','original-quartz-ascending-check','original-meadow-ascending-check');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-running-totals','original-garden-running-totals','original-orbit-running-totals','original-pixel-running-totals','original-river-running-totals','original-clockwork-running-totals','original-lantern-running-totals','original-cloud-running-totals','original-copper-running-totals','original-echo-running-totals','original-paper-crane-running-totals','original-mosaic-running-totals','original-wind-tunnel-running-totals','original-amber-running-totals','original-tidepool-running-totals','original-quartz-running-totals','original-meadow-running-totals');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-runner-up-value','original-garden-runner-up-value','original-orbit-runner-up-value','original-pixel-runner-up-value','original-river-runner-up-value','original-clockwork-runner-up-value','original-lantern-runner-up-value','original-cloud-runner-up-value','original-copper-runner-up-value','original-echo-runner-up-value','original-paper-crane-runner-up-value','original-mosaic-runner-up-value','original-wind-tunnel-runner-up-value','original-amber-runner-up-value','original-tidepool-runner-up-value','original-quartz-runner-up-value','original-meadow-runner-up-value');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-rising-streak','original-garden-rising-streak','original-orbit-rising-streak','original-pixel-rising-streak','original-river-rising-streak','original-clockwork-rising-streak','original-lantern-rising-streak','original-cloud-rising-streak','original-copper-rising-streak','original-echo-rising-streak','original-paper-crane-rising-streak','original-mosaic-rising-streak','original-wind-tunnel-rising-streak','original-amber-rising-streak','original-tidepool-rising-streak','original-quartz-rising-streak','original-meadow-rising-streak');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-pair-reachability','original-garden-pair-reachability','original-orbit-pair-reachability','original-pixel-pair-reachability','original-river-pair-reachability','original-clockwork-pair-reachability','original-lantern-pair-reachability','original-cloud-pair-reachability','original-copper-pair-reachability','original-echo-pair-reachability','original-paper-crane-pair-reachability','original-mosaic-pair-reachability','original-wind-tunnel-pair-reachability','original-amber-pair-reachability','original-tidepool-pair-reachability','original-quartz-pair-reachability','original-meadow-pair-reachability');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'strings' WHERE p.slug IN ('original-signal-mirror-word','original-garden-mirror-word','original-orbit-mirror-word','original-pixel-mirror-word','original-river-mirror-word','original-clockwork-mirror-word','original-lantern-mirror-word','original-cloud-mirror-word','original-copper-mirror-word','original-echo-mirror-word','original-paper-crane-mirror-word','original-mosaic-mirror-word','original-wind-tunnel-mirror-word','original-amber-mirror-word','original-tidepool-mirror-word','original-quartz-mirror-word','original-meadow-mirror-word');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'strings' WHERE p.slug IN ('original-signal-vowel-tally','original-garden-vowel-tally','original-orbit-vowel-tally','original-pixel-vowel-tally','original-river-vowel-tally','original-clockwork-vowel-tally','original-lantern-vowel-tally','original-cloud-vowel-tally','original-copper-vowel-tally','original-echo-vowel-tally','original-paper-crane-vowel-tally','original-mosaic-vowel-tally','original-wind-tunnel-vowel-tally','original-amber-vowel-tally','original-tidepool-vowel-tally','original-quartz-vowel-tally','original-meadow-vowel-tally');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'strings' WHERE p.slug IN ('original-signal-word-order-flip','original-garden-word-order-flip','original-orbit-word-order-flip','original-pixel-word-order-flip','original-river-word-order-flip','original-clockwork-word-order-flip','original-lantern-word-order-flip','original-cloud-word-order-flip','original-copper-word-order-flip','original-echo-word-order-flip','original-paper-crane-word-order-flip','original-mosaic-word-order-flip','original-wind-tunnel-word-order-flip','original-amber-word-order-flip','original-tidepool-word-order-flip','original-quartz-word-order-flip','original-meadow-word-order-flip');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'math' WHERE p.slug IN ('original-signal-digit-total','original-garden-digit-total','original-orbit-digit-total','original-pixel-digit-total','original-river-digit-total','original-clockwork-digit-total','original-lantern-digit-total','original-cloud-digit-total','original-copper-digit-total','original-echo-digit-total','original-paper-crane-digit-total','original-mosaic-digit-total','original-wind-tunnel-digit-total','original-amber-digit-total','original-tidepool-digit-total','original-quartz-digit-total','original-meadow-digit-total');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'math' WHERE p.slug IN ('original-signal-greatest-divider','original-garden-greatest-divider','original-orbit-greatest-divider','original-pixel-greatest-divider','original-river-greatest-divider','original-clockwork-greatest-divider','original-lantern-greatest-divider','original-cloud-greatest-divider','original-copper-greatest-divider','original-echo-greatest-divider','original-paper-crane-greatest-divider','original-mosaic-greatest-divider','original-wind-tunnel-greatest-divider','original-amber-greatest-divider','original-tidepool-greatest-divider','original-quartz-greatest-divider','original-meadow-greatest-divider');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'math' WHERE p.slug IN ('original-signal-prime-signal','original-garden-prime-signal','original-orbit-prime-signal','original-pixel-prime-signal','original-river-prime-signal','original-clockwork-prime-signal','original-lantern-prime-signal','original-cloud-prime-signal','original-copper-prime-signal','original-echo-prime-signal','original-paper-crane-prime-signal','original-mosaic-prime-signal','original-wind-tunnel-prime-signal','original-amber-prime-signal','original-tidepool-prime-signal','original-quartz-prime-signal','original-meadow-prime-signal');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'math' WHERE p.slug IN ('original-signal-factorial-value','original-garden-factorial-value','original-orbit-factorial-value','original-pixel-factorial-value','original-river-factorial-value','original-clockwork-factorial-value','original-lantern-factorial-value','original-cloud-factorial-value','original-copper-factorial-value','original-echo-factorial-value','original-paper-crane-factorial-value','original-mosaic-factorial-value','original-wind-tunnel-factorial-value','original-amber-factorial-value','original-tidepool-factorial-value','original-quartz-factorial-value','original-meadow-factorial-value');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'math' WHERE p.slug IN ('original-signal-fibonacci-position','original-garden-fibonacci-position','original-orbit-fibonacci-position','original-pixel-fibonacci-position','original-river-fibonacci-position','original-clockwork-fibonacci-position','original-lantern-fibonacci-position','original-cloud-fibonacci-position','original-copper-fibonacci-position','original-echo-fibonacci-position','original-paper-crane-fibonacci-position','original-mosaic-fibonacci-position','original-wind-tunnel-fibonacci-position','original-amber-fibonacci-position','original-tidepool-fibonacci-position','original-quartz-fibonacci-position','original-meadow-fibonacci-position');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'math' WHERE p.slug IN ('original-signal-leap-year-test','original-garden-leap-year-test','original-orbit-leap-year-test','original-pixel-leap-year-test','original-river-leap-year-test','original-clockwork-leap-year-test','original-lantern-leap-year-test','original-cloud-leap-year-test','original-copper-leap-year-test','original-echo-leap-year-test','original-paper-crane-leap-year-test','original-mosaic-leap-year-test','original-wind-tunnel-leap-year-test','original-amber-leap-year-test','original-tidepool-leap-year-test','original-quartz-leap-year-test','original-meadow-leap-year-test');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'bits' WHERE p.slug IN ('original-signal-binary-ones','original-garden-binary-ones','original-orbit-binary-ones','original-pixel-binary-ones','original-river-binary-ones','original-clockwork-binary-ones','original-lantern-binary-ones','original-cloud-binary-ones','original-copper-binary-ones','original-echo-binary-ones','original-paper-crane-binary-ones','original-mosaic-binary-ones','original-wind-tunnel-binary-ones','original-amber-binary-ones','original-tidepool-binary-ones','original-quartz-binary-ones','original-meadow-binary-ones');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'bits' WHERE p.slug IN ('original-signal-binary-display','original-garden-binary-display','original-orbit-binary-display','original-pixel-binary-display','original-river-binary-display','original-clockwork-binary-display','original-lantern-binary-display','original-cloud-binary-display','original-copper-binary-display','original-echo-binary-display','original-paper-crane-binary-display','original-mosaic-binary-display','original-wind-tunnel-binary-display','original-amber-binary-display','original-tidepool-binary-display','original-quartz-binary-display','original-meadow-binary-display');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'stacks' WHERE p.slug IN ('original-signal-bracket-balance','original-garden-bracket-balance','original-orbit-bracket-balance','original-pixel-bracket-balance','original-river-bracket-balance','original-clockwork-bracket-balance','original-lantern-bracket-balance','original-cloud-bracket-balance','original-copper-bracket-balance','original-echo-bracket-balance','original-paper-crane-bracket-balance','original-mosaic-bracket-balance','original-wind-tunnel-bracket-balance','original-amber-bracket-balance','original-tidepool-bracket-balance','original-quartz-bracket-balance','original-meadow-bracket-balance');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'strings' WHERE p.slug IN ('original-signal-longest-token','original-garden-longest-token','original-orbit-longest-token','original-pixel-longest-token','original-river-longest-token','original-clockwork-longest-token','original-lantern-longest-token','original-cloud-longest-token','original-copper-longest-token','original-echo-longest-token','original-paper-crane-longest-token','original-mosaic-longest-token','original-wind-tunnel-longest-token','original-amber-longest-token','original-tidepool-longest-token','original-quartz-longest-token','original-meadow-longest-token');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'math' WHERE p.slug IN ('original-signal-digital-root-sum','original-garden-digital-root-sum','original-orbit-digital-root-sum','original-pixel-digital-root-sum','original-river-digital-root-sum','original-clockwork-digital-root-sum','original-lantern-digital-root-sum','original-cloud-digital-root-sum','original-copper-digital-root-sum','original-echo-digital-root-sum','original-paper-crane-digital-root-sum','original-mosaic-digital-root-sum','original-wind-tunnel-digital-root-sum','original-amber-digital-root-sum','original-tidepool-digital-root-sum','original-quartz-digital-root-sum','original-meadow-digital-root-sum');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-missing-member','original-garden-missing-member','original-orbit-missing-member','original-pixel-missing-member','original-river-missing-member','original-clockwork-missing-member','original-lantern-missing-member','original-cloud-missing-member','original-copper-missing-member','original-echo-missing-member','original-paper-crane-missing-member','original-mosaic-missing-member','original-wind-tunnel-missing-member','original-amber-missing-member','original-tidepool-missing-member','original-quartz-missing-member','original-meadow-missing-member');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'arrays' WHERE p.slug IN ('original-signal-sorted-merge','original-garden-sorted-merge','original-orbit-sorted-merge','original-pixel-sorted-merge','original-river-sorted-merge','original-clockwork-sorted-merge','original-lantern-sorted-merge','original-cloud-sorted-merge','original-copper-sorted-merge','original-echo-sorted-merge','original-paper-crane-sorted-merge','original-mosaic-sorted-merge','original-wind-tunnel-sorted-merge','original-amber-sorted-merge','original-tidepool-sorted-merge','original-quartz-sorted-merge','original-meadow-sorted-merge');
INSERT IGNORE INTO problem_tag_map (problem_id, tag_id) SELECT p.id, t.id FROM problems p JOIN problem_tags t ON t.slug = 'matrices' WHERE p.slug IN ('original-signal-matrix-diagonal','original-garden-matrix-diagonal','original-orbit-matrix-diagonal','original-pixel-matrix-diagonal','original-river-matrix-diagonal','original-clockwork-matrix-diagonal','original-lantern-matrix-diagonal','original-cloud-matrix-diagonal','original-copper-matrix-diagonal','original-echo-matrix-diagonal','original-paper-crane-matrix-diagonal','original-mosaic-matrix-diagonal','original-wind-tunnel-matrix-diagonal','original-amber-matrix-diagonal','original-tidepool-matrix-diagonal','original-quartz-matrix-diagonal','original-meadow-matrix-diagonal');

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-signal-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-array-total' AS slug, '5
2 4 6 8 10
' AS input_data, '30' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-array-total' AS slug, '4
-3 7 0 2
' AS input_data, '6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-array-total' AS slug, '1
-9
' AS input_data, '-9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-peak-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-peak-value' AS slug, '3
-8 -1 -6
' AS input_data, '-1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-peak-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-lowest-value' AS slug, '5
3 9 -2 7 4
' AS input_data, '-2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-lowest-value' AS slug, '3
-8 -1 -6
' AS input_data, '-8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-lowest-value' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-echo-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-even-count' AS slug, '6
1 2 3 4 0 7
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-even-count' AS slug, '4
-2 -4 5 7
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-even-count' AS slug, '3
1 3 5
' AS input_data, '0' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-array-reversal' AS slug, '5
1 2 3 4 5
' AS input_data, '5 4 3 2 1' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-array-reversal' AS slug, '4
8 -1 8 0
' AS input_data, '0 8 -1 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-array-reversal' AS slug, '1
7
' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-circular-shift' AS slug, '5
1 2 3 4 5
2
' AS input_data, '3 4 5 1 2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-circular-shift' AS slug, '4
9 8 7 6
6
' AS input_data, '7 6 9 8' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-circular-shift' AS slug, '3
4 5 6
0
' AS input_data, '4 5 6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-target-frequency' AS slug, '6
2 5 2 7 2 5
2
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-target-frequency' AS slug, '4
1 3 5 7
4
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-target-frequency' AS slug, '1
-2
-2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-garden-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-distinct-values' AS slug, '6
1 2 1 3 2 4
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-distinct-values' AS slug, '5
9 9 9 9 9
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-distinct-values' AS slug, '4
-1 0 1 2
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-ascending-check' AS slug, '4
1 2 2 8
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-ascending-check' AS slug, '3
1 5 4
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-ascending-check' AS slug, '1
7
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-running-totals' AS slug, '4
2 3 1 4
' AS input_data, '2 5 6 10' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-running-totals' AS slug, '3
-2 5 -1
' AS input_data, '-2 3 2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-running-totals' AS slug, '1
8
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-paper-crane-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-runner-up-value' AS slug, '5
8 3 8 6 2
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-runner-up-value' AS slug, '4
-4 -2 -9 -2
' AS input_data, '-4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-runner-up-value' AS slug, '3
5 5 5
' AS input_data, 'NONE' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-rising-streak' AS slug, '7
1 2 5 3 4 6 2
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-rising-streak' AS slug, '5
9 8 7 6 5
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-rising-streak' AS slug, '4
1 2 3 4
' AS input_data, '4' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-pair-reachability' AS slug, '5
2 7 4 1 9
11
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-pair-reachability' AS slug, '4
1 2 3 4
10
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-pair-reachability' AS slug, '2
-3 8
5
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-mirror-word' AS slug, 'level
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-mirror-word' AS slug, 'Codevibs
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-mirror-word' AS slug, 'a
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-orbit-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-vowel-tally' AS slug, 'Algorithm Lab
' AS input_data, '4' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-vowel-tally' AS slug, 'SKY
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-vowel-tally' AS slug, 'Education
' AS input_data, '5' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-word-order-flip' AS slug, 'learn by building
' AS input_data, 'building by learn' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-word-order-flip' AS slug, 'one
' AS input_data, 'one' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-word-order-flip' AS slug, 'code every day
' AS input_data, 'day every code' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-digit-total' AS slug, '5082
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-digit-total' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-digit-total' AS slug, '999
' AS input_data, '27' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-mosaic-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-greatest-divider' AS slug, '24 18
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-greatest-divider' AS slug, '7 13
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-greatest-divider' AS slug, '0 9
' AS input_data, '9' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-prime-signal' AS slug, '17
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-prime-signal' AS slug, '1
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-prime-signal' AS slug, '49
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-factorial-value' AS slug, '5
' AS input_data, '120' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-factorial-value' AS slug, '0
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-factorial-value' AS slug, '7
' AS input_data, '5040' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-fibonacci-position' AS slug, '7
' AS input_data, '13' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-fibonacci-position' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-fibonacci-position' AS slug, '10
' AS input_data, '55' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-pixel-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-leap-year-test' AS slug, '2000
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-leap-year-test' AS slug, '1900
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-leap-year-test' AS slug, '2024
' AS input_data, 'YES' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-binary-ones' AS slug, '13
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-binary-ones' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-binary-ones' AS slug, '255
' AS input_data, '8' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-binary-display' AS slug, '10
' AS input_data, '1010' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-binary-display' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-binary-display' AS slug, '31
' AS input_data, '11111' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-wind-tunnel-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-bracket-balance' AS slug, '(()())
' AS input_data, 'YES' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-bracket-balance' AS slug, '())
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-bracket-balance' AS slug, '((
' AS input_data, 'NO' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-longest-token' AS slug, 'bright ideas grow
' AS input_data, '6' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-longest-token' AS slug, 'tiny ant
' AS input_data, '4' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-longest-token' AS slug, 'one
' AS input_data, '3' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-digital-root-sum' AS slug, '9875
' AS input_data, '2' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-digital-root-sum' AS slug, '0
' AS input_data, '0' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-digital-root-sum' AS slug, '12345
' AS input_data, '6' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-missing-member' AS slug, '5
1 2 4 5
' AS input_data, '3' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-missing-member' AS slug, '2
2
' AS input_data, '1' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-missing-member' AS slug, '7
7 6 5 4 3 1
' AS input_data, '2' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);

INSERT INTO test_cases (problem_id, input_data, expected_output, sample_case, sort_order)
SELECT p.id, v.input_data, v.expected_output, v.sample_case, v.sort_order
FROM (
  SELECT 'original-river-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-sorted-merge' AS slug, '3 3
1 4 8
2 3 9
' AS input_data, '1 2 3 4 8 9' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-sorted-merge' AS slug, '2 2
-2 5
-1 6
' AS input_data, '-2 -1 5 6' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-sorted-merge' AS slug, '1 0
7

' AS input_data, '7' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-signal-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-signal-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-signal-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-garden-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-garden-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-garden-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-orbit-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-orbit-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-orbit-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-pixel-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-pixel-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-pixel-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-river-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-river-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-river-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-clockwork-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-lantern-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-lantern-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-lantern-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-cloud-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-cloud-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-cloud-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-copper-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-copper-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-copper-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-echo-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-echo-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-echo-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-paper-crane-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-mosaic-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-wind-tunnel-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-amber-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-amber-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-amber-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-tidepool-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-quartz-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-quartz-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-quartz-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
  UNION ALL
  SELECT 'original-meadow-matrix-diagonal' AS slug, '3
1 2 3
4 5 6
7 8 9
' AS input_data, '15' AS expected_output, 1 AS sample_case, 0 AS sort_order
  UNION ALL
  SELECT 'original-meadow-matrix-diagonal' AS slug, '2
-1 5
8 3
' AS input_data, '2' AS expected_output, 0 AS sample_case, 1 AS sort_order
  UNION ALL
  SELECT 'original-meadow-matrix-diagonal' AS slug, '1
42
' AS input_data, '42' AS expected_output, 0 AS sample_case, 2 AS sort_order
) v JOIN problems p ON p.slug = v.slug
WHERE NOT EXISTS (SELECT 1 FROM test_cases tc WHERE tc.problem_id = p.id AND tc.sort_order = v.sort_order);
