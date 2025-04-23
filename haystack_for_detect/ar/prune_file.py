import json

# Input and output file paths
input_file = "wiki_merge"  # Replace with your actual input file
output_file = "wiki_merge_pruned"

# Word count limit
word_limit = 120000
current_word_count = 0

# Open files
with open(input_file, "r", encoding="utf-8") as infile, open(output_file, "w", encoding="utf-8") as outfile:
        for line in infile:
            try:
                 data = json.loads(line)  # Parse JSON line
                 text = data.get("text", "")  # Extract 'text' field
                 word_count = len(text.split())  # Count words
                                                                        
                 if current_word_count + word_count > word_limit:
                     break  # Stop if we exceed the word limit
                                                                                                                
                 outfile.write(json.dumps(data) + "\n")  # Write to output JSONL file
                 current_word_count += word_count  # Update word count
            except json.JSONDecodeError:
                 print("Skipping invalid JSON line")
                                                                                                                                              
print(f"Extraction complete. Total words collected: {current_word_count}")
