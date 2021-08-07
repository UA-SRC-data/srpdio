

# ----------------------------------------
# DOSDP pattern modules 
# ----------------------------------------
PATTERNDIR = ../patterns
PATTERNS = entity_attribute plant_part_concentration #chemical_concentration
PATTERN_ROOTS = $(patsubst %, $(PATTERNDIR)/%, $(PATTERNS))
PATTERN_FILES = $(foreach n,$(PATTERN_ROOTS), $(n).owl)

all_patterns: $(PATTERN_FILES)

# Targets for DOSDP modules
../patterns/%.owl: $(PATTERNDIR)/%.csv $(PATTERNDIR)/%.yaml curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/$*.yaml --outfile=../patterns/$*.tmp.owl --infile=../patterns/$*.csv
	$(ROBOT) annotate --input ../patterns/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output ../patterns/$*.owl && rm ../patterns/$*.tmp.owl


#chemical_concentration.owl: ../patterns/chemical_concentration.csv ../patterns/chemical_concentration.yaml #curie_map.yaml
#	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/chemical_concentration.yaml --outfile=../patterns/chemical_concentration.tmp.owl --infile=../patterns/chemical_concentration.csv
#	$(ROBOT) annotate --input ../patterns/chemical_concentration.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/chemical_concentration.owl --output ../patterns/chemical_concentration.owl && rm ../patterns/chemical_concentration.tmp.owl
