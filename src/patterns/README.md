The subfolder dosdp_patterns contains the YAML files that control how modules are built using DOSDP patterns.

The CSV input files are in src/patterns/data/default.

The output OWL files are in src/ontology/modules.

ACS5 patterns are handled separately in src/acs5-patterns

SRPDIO uses the following pattern-based modules:
- chemical concentration - the concentrations of chemicals in environmental substances that aren't plants (e.g., water, soil)
- plant part concentration - the concentrations of chemicals in parts of plants (e.g., leaves, roots)
- entity attribute - simple EQ qualities where some quality inheres in some entity
- acs root quality - these are the base qualities in ACS5 and EJS, like per capita income or mortgage status, without any of their qualifiers.
- acs qualifier variables - the qualities thare are used to modify acs root qualities
- TODO: acs5 - variables from the US Census based American Community Survey


Non-DOSDP modules are generated using robot. Their source CSVs and output OWL files are also in ../modules.

Import modules (subsets of terms from other ontologies) are in ../source/imports.
