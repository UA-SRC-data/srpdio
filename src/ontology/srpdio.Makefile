

# ----------------------------------------
# DOSDP pattern modules 
# ----------------------------------------
PATTERNDIR = ../patterns
PATTERNS = chemical_concentration entity_attribute plant_part_concentration
PATTERN_ROOTS = $(patsubst %, $(PATTERNDIR)/%, $(PATTERNS))
PATTERN_FILES = $(foreach n,$(PATTERN_ROOTS), $(n).owl)

all_patterns: $(PATTERN_FILES)

# Targets for DOSDP modules
#patterns/%.owl: ../patterns/%.csv ../patterns/%.yaml #curie_map.yaml
#	dosdp-tools --table-format=csv --template=../patterns/$*.yaml --outfile=../pattterns/$*.tmp.owl --obo-prefixes=true generate --infile=../patterns/$*.csv
#	$(ROBOT) annotate --input ../patterns/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/patterns/$*.owl --output ../patterns/$*.owl && rm ../patterns/$*.tmp.owl

#chemical_concentration.owl: ../patterns/chemical_concentration.csv ../patterns/chemical_concentration.yaml #curie_map.yaml
#	dosdp-tools --obo-prefixes --table-format=csv --template=../patterns/chemical_concentration.yaml --outfile=../pattterns/chemical_concentration.tmp.owl  generate --infile=../patterns/chemical_concentration.csv
#

#/Users/rwalls/gh/dosdp-tools/target/universal/stage/bin