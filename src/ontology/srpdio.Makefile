

# ----------------------------------------
# DOSDP pattern modules 
# ----------------------------------------
PATTERNDIR = ../patterns
PATTERN_OUT = modules/
PATTERNS = entity_attribute plant_part_concentration chemical_concentration
PATTERN_ROOTS = $(patsubst %, $(PATTERN_OUT)%, $(PATTERNS))
PATTERN_FILES = $(foreach n,$(PATTERN_ROOTS), $(n).owl)
ACS_PATTERNDIR = ../patterns/acs5_variable_sheets
ACS_PATTERNS2 = age_x_disability
ACS_PATTERN2_ROOTS = $(patsubst %, $(PATTERN_OUT)/%, $(ACS_PATTERNS2))
ACS_PATTERN2_FILES = $(foreach n,$(ACS_PATTERN_ROOTS), $(n).owl)
ACS_PATTERNS3 = age_x_disability_x_poverty
ACS_PATTERN3_ROOTS = $(patsubst %, $(PATTERN_OUT)/%, $(ACS_PATTERNS3))
ACS_PATTERN3_FILES = $(foreach n,$(ACS_PATTERN3_ROOTS), $(n).owl)


all_modules:: $(PATTERN_FILES)

all_acs_patterns: all_acs_patterns2 all_acs_patterns3
all_acs_patterns2: $(ACS_PATTERN2_FILES)
all_acs_patterns3: $(ACS_PATTERN3_FILES)

# Targets for DOSDP modules
modules/%.owl:: $(PATTERNDIR)/%.csv $(PATTERNDIR)/%.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/$*.yaml --outfile=$(PATTERN_OUT)$*.tmp.owl --infile=$(PATTERNDIR)/$*.csv
	$(ROBOT) annotate --input $(PATTERN_OUT)$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output $(PATTERN_OUT)$*.owl && rm $(PATTERN_OUT)$*.tmp.owl

acs_patterns2/%.owl: $(ACS_PATTERNDIR)/%.csv $(ACS_PATTERNDIR)/%.yaml #curie_map.yaml
	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=$(PATTERNDIR)/$*.yaml --outfile=$(PATTERNDIR)/$*.tmp.owl --infile=$(ACS_PATTERNDIR)/$*.csv
	$(ROBOT) annotate --input patterns/$*.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/$*.owl --output patterns/$*.owl && rm patterns/$*.tmp.owl

#TEST PATTERNS, to make sure they work: 

#chemical_concentration.owl: ../patterns/chemical_concentration.csv ../patterns/chemical_concentration.yaml #curie_map.yaml
#	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/chemical_concentration.yaml --outfile=../patterns/chemical_concentration.tmp.owl --infile=../patterns/chemical_concentration.csv
#	$(ROBOT) annotate --input ../patterns/chemical_concentration.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/chemical_concentration.owl --output ../patterns/chemical_concentration.owl && rm ../patterns/chemical_concentration.tmp.owl

#age_x_disability_x_poverty.owl: ../patterns/acs5_variable_sheets/age_x_disability_x_poverty.csv ../patterns/acs_3vars.yaml
#	dosdp-tools generate --obo-prefixes=true --table-format=csv --template=../patterns/acs_3vars.yaml --outfile=../patterns/age_x_disability_x_poverty.tmp.owl --infile=../patterns/acs5_variable_sheets/age_x_disability_x_poverty.csv
#	$(ROBOT) annotate --input ../patterns/age_x_disability_x_poverty.tmp.owl -O http://purl.obolibrary.org/obo/srpdio/age_x_disability_x_poverty.owl --output ../patterns/age_x_disability_x_poverty.owl && rm ../patterns/age_x_disability_x_poverty.tmp.owl

