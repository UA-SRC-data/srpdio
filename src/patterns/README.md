This folder contains the YAML files that control how modules are built using DOSDP patterns.

It also contains the CSV input files and the output OWL files.

SRPDIO uses the following pattern-based modules:
- chemical concentration - the concentrations of chemicals in environmental substances that aren't plants (e.g., water, soil)
- plant part concentration - the concentrations of chemicals in parts of plants (e.g., leaves, roots)
- entity attribute - simple EQ qualities where some quality inheres in some entity
- acs root quality - these are the base qualities in ACS5 and EJS, like per capita income or mortgage status, without any of their qualifiers.
- acs qualifier variables - the qualities thare are used to modify acs root qualities
- TODO: acs5 - variables from the US Census based American Community Survey


Non DOSDP modules are generated using robot. Their source CSVs and output OWL files are also in ../modules.

Import modules are in ../source/imports.