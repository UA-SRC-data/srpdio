

# ----------------------------------------
# DOSDP pattern modules 
# ----------------------------------------
PATTERNDIR = ../patterns
PATTERNS = entity_attribute plant_part_concentration chemical_concentration
PATTERN_ROOTS = $(patsubst %, $(PATTERNDIR)/%, $(PATTERNS))
PATTERN_FILES = $(foreach n,$(PATTERN_ROOTS), $(n).owl)
#ACS_PATTERNDIR = ../patterns/acs5_variable_sheets
#ACS_PATTERNS = age_x_disability
#ACS_PATTERN_ROOTS = $(patsubst %, $(ACS_PATTERNDIR)/%, $(ACS_PATTERNS))
#ACS_PATTERN_FILES = $(foreach n,$(ACS_PATTERN_ROOTS), $(n).owl)


all_patterns: $(PATTERN_FILES)

all_acs_patterns: $(ACS_PATTERN_FILES)

# Targets for DOSDP modules
patterns/%.owl: $(PATTERNDIR)/%.csv $(PATTERNDIR)/%.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/$*.yaml --outfile=patterns/$*.tmp.owl --infile=../patterns/$*.csv
	$(ROBOT) annotate --input ../patterns/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output ../patterns/$*.owl && rm ../patterns/$*.tmp.owl

#patterns/acs_patterns/%.owl: $(ACS_PATTERNDIR)/%.csv $(ACS_PATTERNDIR)/%.yaml curie_map.yaml
#	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(ACS_PATTERNDIR)/$*.yaml --outfile=$(ACS_PATTERNDIR)/$*.tmp.owl --infile=$(ACS_PATTERNDIR)/$*.csv
#	$(ROBOT) annotate --input patterns/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output patterns/$*.owl && rm patterns/$*.tmp.owl


#chemical_concentration.owl: ../patterns/chemical_concentration.csv ../patterns/chemical_concentration.yaml #curie_map.yaml
#	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/chemical_concentration.yaml --outfile=../patterns/chemical_concentration.tmp.owl --infile=../patterns/chemical_concentration.csv
#	$(ROBOT) annotate --input ../patterns/chemical_concentration.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/chemical_concentration.owl --output ../patterns/chemical_concentration.owl && rm ../patterns/chemical_concentration.tmp.owl

age_x_disability.owl: ../patterns/acs5_variable_sheets/age_x_disability.csv ../patterns/acs5_variable_sheets/age_x_disability.yaml
	dosdp-tools generate --catalog catalog-v001.xml --obo-prefixes=true --table-format=csv --template=../patterns/acs5_variable_sheets/age_x_disability.yaml --outfile=../patterns/age_x_disability.tmp.owl --infile=../patterns/acs5_variable_sheets/age_x_disability.csv
	robot --catalog catalog-v001.xml annotate --input ../patterns/age_x_disability.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/age_x_disability.owl --output ../patterns/age_x_disability.owl && rm ../patterns/age_x_disability.tmp.owl

#dosdp-tools generate --obo-prefixes=true --table-format=csv --infile=../patterns/acs5_variable_sheets/age_x_disability.csv --template=../patterns/acs5_variable_sheets/age_x_disability.yaml --outfile=../patterns/age_x_disability.tmp.owl

