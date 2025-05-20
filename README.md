# Bronbeek Data Pipeline Documentation

This pipeline supports the transformation of collection data originally exported from the The Museum System (TMS) as a .bak backup file from 2018. The .bak file has been unpacked and converted into structured CSV files that represent various aspects of the museum's collection, such as accession methods, object metadata, person roles, and connection with objects. The goal of this pipeline is to:

- Convert these CSV datasets into RDF (Resource Description Framework) using semantic web standards,
- Support linked data publishing for [PM-Sampo](https://pmsampo.demo.seco.cs.aalto.fi/en/)
- Enable ingestion into platforms like ClioPatria for querying and enrichment,
- Lay the foundation for further exploration, visualization, and integration with other heritage datasets.

## Data Overview

### Data Location
- **Local**: `/Users/sarah_shoilee/Desktop/Sarah.nosync/Bronbeek_Data/`  
- **Cloud**: [Bronbeek Data on SURF](https://vu.data.surfsara.nl/index.php/f/142262424)

---

## Data Conversion Workflow

### Input Assets
The data includes the following CSV files:

```
AccessionMethods.csv
Constituents.csv
ConXrefDetails.csv
ConXrefs.csv
ObjAccession.csv
Objects.csv
ObjectStatuses.csv
Roles.csv
RoleTypes.csv
```

---

### Step 1: Create CSV-to-RDF Mapping

#### 1.1 Write Conversion Metadata
Generate the initial mapping blueprint for CSV-to-RDF conversion using the `cow_tool`:

```bash
cow_tool build myfile.csv
```

This command creates a draft conversion metadata file for the specified CSV.

#### 1.2 Update the Mapping
Edit the generated metadata file to fine-tune the conversion process. Follow the step-by-step instructions in the [mapping process guide](./cow_process.md).
- [mapping details](https://docs.google.com/document/d/12hXBqdUr_LVh96ltt8DTXUMrewWByzCNndjEBMzqAis/edit?usp=sharing)

---

### Step 2: Convert CSV to RDF

Use the [convert_csv2rdf.py](convert_csv2rdf.py) script to transform CSV files into RDF files in N-Quads format (`.nq`).

#### Usage:
Run the script with the directory containing your CSV and metadata files:

```bash
python convert_csv2rdf.py <path-to-directory>
```

#### Key Requirements:
- **Input files**: Place the CSV files and their corresponding metadata JSON files in the same directory.
- **Function**: The script relies on `convert_csv2rdf.convert_csv_to_rdf()`, which expects all input files to be co-located.

#### Output:
- RDF files in `.nq` format.

---

### Step 3: Upload to ClioPatria

#### 3.1 Compress RDF Files
Before uploading, compress the `.nq` files using the following command:

```bash
gzip <path-to-folder>/*.nq
```

#### 3.2 Attach the Libraries in ClioPatria
From the ClioPatria CLI, attach the RDF library containing your files:

```prolog
rdf_library:rdf_attach_library('<path-to-folder-of-void.ttl>').
```

> **Note**: The [void.ttl](void.ttl) file must be in the same folder as the `.nq` files.

#### 3.3 Load RDF Data
To load the RDF data into ClioPatria, use:

```prolog
rdf_library:rdf_load_library('<library-name>').
```
For example:
```prolog
rdf_library:rdf_load_library('bronbeek').
```

---

## Data Enrichment

Enhance the RDF data with linked data enrichment using the `enrich_data_bronbeek.py` script. This adds provenance activity information, such as acquisition events, former owners, and object-to-person relationships.

#### Usage:
Run the enrichment script with the folder containing the `.nq` files:

```bash
python enrich_data_bronbeek.py <folder-path-of-all-nq-files>
```

> **Note**: The [enrich_data_bronbeek.py](enrich_data_bronbeek.py) script expects `.nq` files as input.

---

## Summary of Outputs

1. **Conversion**: CSV files → RDF files (`.nq`).
2. **Compression**: RDF files compressed to `.nq.gz`.
3. **Upload**: Files loaded into ClioPatria.
4. **Enrichment**: Enriched RDF files containing provenance and linked data.
