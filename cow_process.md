Here’s a more polished and structured version of the documentation:

---

# CSV to RDF Conversion Using `CoW`

This guide explains how to convert a CSV file into RDF using the [CSV on the Web (CoW)](https://github.com/CLARIAH/COW). The process involves creating and curating metadata, followed by the conversion and sorting of the output RDF file.

---

## Workflow Steps

### Step 1: Locate the CSV File
Identify the CSV file you want to convert. This file will serve as the input for the conversion process.

---

### Step 2: Generate Metadata File
Use the `cow_tool` to create a metadata file for the CSV.

#### Command:
```bash
cow_tool build myfile.csv
```

#### Output:
- A metadata file named `<filename>-metadata.json` is created.  

---

### Step 3: Curate the Metadata File
Edit the `<filename>-metadata.json` file to align with your linked data schema. Follow these steps:

#### 3.1 Update the Base URI
Modify the `base` URI in the metadata file to reflect your desired namespace.

#### 3.2 Add Required Prefixes
Include any additional prefixes that may be required. For example:

```json
"prefixes": {
    "la": "https://linked.art/ns/terms/",
    ...
}
```

#### 3.3 Simplify Data Type Manipulation
Avoid overcomplicating data type definitions unless necessary.

#### 3.4 Define Subject, Predicate, and Object

1. **Subject (`aboutURL`)**  
   Update the `aboutURL` field to define the structure of subject URIs.  
   Example:
   ```json
   "aboutUrl": "{ConstituentID}"
   ```
   - Here, `ConstituentID` is the primary key of the table.

2. **Predicate (`propertyURL`)**  
   Specify the predicate using `propertyURL` and optionally define its value with `valueURL`.  
   Example:
   ```json
   {
       "name": "properties_name_in_uri",
       "datatype": "string",
       "dc:description": "Name of neighbourhood as described in the dataset",
       "titles": ["Property name of neighbourhood in the URI"],
       "propertyUrl": "rdf:type",
       "valueUrl": "sdmx-dimension:refArea",
       "@id": "https://iisg.amsterdam/buurt.csv/column/properties_name_in_uri"
   }
   ```

3. **Object (`valueURL` or `CSVW:value`)**  
   Define the object value using `CSVW:value` or `valueURL` to specify its format.  
   Example:
   ```json
   {
       "name": "Dienstboden",
       "propertyUrl": "vocab/averageNrMaids",
       "CSVW:value": "{{Dienstboden|replace(',', '.')}}",
       "@id": "https://iisg.amsterdam/buurt.csv/column/Dienstboden"
   }
   ```

Refer to the [COW documentation](https://github.com/CLARIAH/COW/wiki/1.-Adapting-the-Metadata) for more details on these fields.

---

### Step 4: Convert CSV to RDF
Use the `cow_tool` to convert the CSV file into an RDF file in N-Quads format.

#### Command:
```bash
cow_tool convert myfile.csv
```

#### Output:
- An RDF file named `<filename>.nq` is generated.

---

### Step 5: Sort the RDF File
Sort the contents of the `.nq` file for consistent ordering.

#### Command:
```bash
sort <filename>.nq > <filename>_sorted.nq
```

#### Output:
- A sorted RDF file named `<filename>_sorted.nq`.

---

## Summary
This process enables efficient conversion of CSV data into RDF while ensuring adherence to a linked data schema. The key steps include generating metadata, curating it, converting the file, and sorting the output.